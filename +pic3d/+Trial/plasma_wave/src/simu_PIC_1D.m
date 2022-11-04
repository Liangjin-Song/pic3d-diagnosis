function [prm, fd, prt] = simu_PIC_1D
%%
% one dimensional partial-in-cell simulation
% written by Liangjin Song on 20220429 at Nanchang University
% @return: prm -- the parameters
% @return: fd -- the field
% @return: prt -- the particle
%%
%% input the parameters
prm = input_parameters();

%% model initialization
[fd, prt] = initialization(prm);

%% first run
prm.first = true;
% advance the field and particle
[fd, prt] = advance(fd, prt, prm);
% plot figure
diagnosis(fd, prt, prm, 0);

%% another run
prm.first = false;
for t = 1:prm.nt
    %% advance the field and particle
    [fd, prt] = advance(fd, prt, prm);

    %% plot
    diagnosis(fd, prt, prm, t);
end

%% clear the persistent variable
clear function;
end


%% ================================================================== %%
function prm = input_parameters()
%%
% @brief: Collect input parameters from dialog
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @return: prm -- the parameters structure
%%
%% simulation model list
prm.model = {'thermal'};

%% simulation model
prm.model = select_model(prm.model);

%% ghost grids
prm.left = 2;
prm.right = 2;
prm.ghost = prm.left + prm.right;

%% the light speed
prm.c = 0.9;
prm.c2 = prm.c * prm.c;
prm.mu0 = 1/prm.c2;
prm.epsilon0 = 1;

%% the time step
prm.dt = 1;

%% the space grid step
prm.dx = 1;

%% collect the input parameters according to the simulation dialog
switch prm.model
    case 'thermal'
        prm = model_thermal(prm);
    otherwise
        error('unkonwn model');
end

%% the required memory space
prm.xx = prm.nx + prm.ghost;

%% the total number of particles
prm.tnp = prm.nx * prm.npc;

%% the simulation box
prm.x1 = prm.left + 1;
prm.x2 = prm.nx + prm.left;
prm.box = prm.x1:prm.x2;
end


%% ================================================================== %%
function [fd, prt] = initialization(prm)
%%
% @brief: initialize fields and particles according to the model
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: prm -- the parameters structure
% @return: fd -- the field, including B, E, and J
% @return: prt -- the particle
%%
switch prm.model
    case 'thermal'
        [fd, prt] = init_thermal(prm);
    otherwise
        error('unkonwn model');
end
end


%% ================================================================== %%
function diagnosis(fd, prt, prm, t)
%%
% @info: plot figure according to the model
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: fd  -- data of field
% @param: prt -- data of particles
% @param: prm -- the parameters structure
% @param: t -- the time step
%%
tt = num2str(t*prm.dt*prm.wce, '%07.3f');
switch prm.model
    case 'thermal'
        diagnosis_thermal(fd, prt, prm, tt, t);
    otherwise
        error('unkonwn model');
end
end


%% ================================================================== %%
function prt = memory_particle_2s(prm)
%%
% @brief: memory application for electrons and ions
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: prm -- the parameters structure
% @return: prt -- the particle
%%
%% electron
prt.electron.q = prm.qe;
prt.electron.m = prm.me;
prt.electron.rx = zeros(1, prm.tnp);
prt.electron.v.x = zeros(1, prm.tnp);
prt.electron.v.y = zeros(1, prm.tnp);
prt.electron.v.z = zeros(1, prm.tnp);
%% ion
prt.ion.q = prm.qi;
prt.ion.m = prm.mi;
prt.ion.rx = zeros(1, prm.tnp);
prt.ion.v.x = zeros(1, prm.tnp);
prt.ion.v.y = zeros(1, prm.tnp);
prt.ion.v.z = zeros(1, prm.tnp);
end


%% ================================================================== %%
function fd = memory_field(prm)
%%
% @brief: memory application for field
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: prm -- the parameters structure
% @return: fd -- the field
%%
%% magnetic field
fd.B.x = zeros(1, prm.xx) + prm.Bx;
fd.B.y = zeros(1, prm.xx) + prm.By;
fd.B.z = zeros(1, prm.xx) + prm.Bz;

%% electric field
fd.E.x = zeros(1, prm.xx);
fd.E.y = zeros(1, prm.xx);
fd.E.z = zeros(1, prm.xx);

%% current density
fd.J.x = zeros(1, prm.xx);
fd.J.y = zeros(1, prm.xx);
fd.J.z = zeros(1, prm.xx);
end


%% ================================================================== %%
function [fd, prt] = advance(fd, prt, prm)
%%
% @brief: advance the field and particles
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: fd  -- data of field
% @param: prt -- data of particles
% @param: prm -- the parameters structure
% @return: fd -- data of advanced field
% @return: prt -- data of advanced particle
%%

fd.B = magnetic(fd.B, fd.E, prm);

prt.electron.v = velocity(prt.electron, fd.E, fd.B, prm);
prt.ion.v = velocity(prt.ion, fd.E, fd.B, prm);

prt.electron.rx = position(prt.electron.rx, prt.electron.v.x, prm);
prt.ion.rx = position(prt.ion.rx, prt.ion.v.x, prm);

fd.B = magnetic(fd.B, fd.E, prm);

fd.J.x(:) = 0;
fd.J.y(:) = 0;
fd.J.z(:) = 0;
fd.J = current(fd.J, prt.electron, prm);
fd.J = current(fd.J, prt.ion, prm);
fd.J.x = boundary_copy(fd.J.x, prm);
fd.J.y = boundary_copy(fd.J.y, prm);
fd.J.z = boundary_copy(fd.J.z, prm);
if prm.smooth
    fd.J.x = smooth_field(fd.J.x, prm);
    fd.J.y = smooth_field(fd.J.y, prm);
    fd.J.z = smooth_field(fd.J.z, prm);
end

fd.E = electric(fd.E, fd.B, fd.J, prm);
end


%% ================================================================== %%
function B = magnetic(B, E, prm)
%%
% @brief: advance the magnetic field
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: B -- the magnetic field
% @param: E -- the electric field
% @param: prm -- the parameters structure
% @return: B -- the advanced magnetic field
%%
B.y(prm.box) = B.y(prm.box) + 0.5 * prm.dt * (E.z(prm.box+1) - E.z(prm.box)) / prm.dx;
B.z(prm.box) = B.z(prm.box) - 0.5 * prm.dt * (E.y(prm.box+1) - E.y(prm.box)) / prm.dx;
B.y = boundary_copy(B.y, prm);
B.z = boundary_copy(B.z, prm);
end


%% ================================================================== %%
function E = electric(E, B, J, prm)
%%
% @brief: advance the electric field
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: E -- the electric field
% @param: B -- the magnetic field
% @param: J -- the current density
% @param: prm -- the parameters structure
% @return: E -- the advanced electric field
%%
E.x(prm.box) = E.x(prm.box) - prm.dt * J.x(prm.box) / prm.epsilon0;
E.y(prm.box) = E.y(prm.box) - prm.c2 * prm.dt * (B.z(prm.box) - B.z(prm.box - 1)) / prm.dx - prm.dt * J.y(prm.box) / prm.epsilon0;
E.z(prm.box) = E.z(prm.box) + prm.c2 * prm.dt * (B.y(prm.box) - B.y(prm.box - 1)) / prm.dx - prm.dt * J.z(prm.box) / prm.epsilon0;
E.x = boundary_copy(E.x, prm);
E.y = boundary_copy(E.y, prm);
E.z = boundary_copy(E.z, prm);
end


%% ================================================================== %%
function rx = position(rx, vx, prm)
%%
% @brief: advance the particles' position
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: rx -- the particles' position
% @param: vx -- the particles' velocity
% @param: prm -- the parameters structure
% @return: rx -- the advanced particles' position
%%
rx = rx + prm.dt * vx;
rx = boundary_particle(rx, prm);
end


%% ================================================================== %%
function v = velocity(spcs, E, B, prm)
%%
% @brief: calculate the velocity of a species
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: spcs -- the species, e.g. ion, electron, ...
% @param: E -- the electric field
% @param: B -- the magnetic field
% @param: prm -- the parameters structure
% @return: v -- the advanced velocity
%%
%% interpolate the field to where the particle is
tnp = length(spcs.rx);
e.x = zeros(1, tnp);
e.y = zeros(1, tnp);
e.z = zeros(1, tnp);
b.x = zeros(1, tnp);
b.y = zeros(1, tnp);
b.z = zeros(1, tnp);

i1 = floor(spcs.rx);
i2 = ceil(spcs.rx);
r2 = spcs.rx - i1;
r1 = 1 - r2;

for i = 1:tnp
    e.x(i) = E.x(i1(i)) .* r1(i) + E.x(i2(i)) .* r2(i);
    e.y(i) = E.y(i1(i)) .* r1(i) + E.y(i2(i)) .* r2(i);
    e.z(i) = E.z(i1(i)) .* r1(i) + E.z(i2(i)) .* r2(i);
    b.x(i) = B.x(i1(i)) .* r1(i) + B.x(i2(i)) .* r2(i);
    b.y(i) = B.y(i1(i)) .* r1(i) + B.y(i2(i)) .* r2(i);
    b.z(i) = B.z(i1(i)) .* r1(i) + B.z(i2(i)) .* r2(i);
end

%% some constant value
qm = spcs.q/spcs.m;
qt = qm * prm.dt * 0.5;

%% step 1
gamma = prm.c./(sqrt(prm.c2 - vector_square(spcs.v)));
u.x = gamma .* spcs.v.x;
u.y = gamma .* spcs.v.y;
u.z = gamma .* spcs.v.z;

%% step 2
u1.x = u.x + qt * e.x;
u1.y = u.y + qt * e.y;
u1.z = u.z + qt * e.z;

%% step 3
gamma = qt * prm.c./(sqrt(prm.c2 + vector_square(u1)));
bu.x = gamma .* b.x;
bu.y = gamma .* b.y;
bu.z = gamma .* b.z;

%% step 4
gamma = vector_cross(u1, bu);
u11.x = u1.x + gamma.x;
u11.y = u1.y + gamma.y;
u11.z = u1.z + gamma.z;

%% step 5
gamma = 2./(1 + vector_square(bu));
u2 = vector_cross(u11, bu);
u2.x = u2.x .* gamma + u1.x;
u2.y = u2.y .* gamma + u1.y;
u2.z = u2.z .* gamma + u1.z;

%% step 6
u.x = u2.x + qt * e.x;
u.y = u2.y + qt * e.y;
u.z = u2.z + qt * e.z;

%% step 7
gamma = prm.c./(sqrt(prm.c2 + vector_square(u)));
v.x = gamma .* u.x;
v.y = gamma .* u.y;
v.z = gamma .* u.z;
end


%% ================================================================== %%
function v2 = vector_square(v)
%%
% @brief: calculate the square of a vector
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: v -- a vector
% @return: v2 -- the square of the vector
%%
v2 = v.x.^2 + v.y.^2 + v.z.^2;
end


%% ================================================================== %%
function v = vector_mod(v)
%%
% @brief: calculate the mod of a vector
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: v -- a vector
% @return: v -- the mod of the vector
%%
v = sqrt(v.x.^2 + v.y.^2 + v.z.^2);
end


%% ================================================================== %%
function v = vector_cross(v1, v2)
%%
% @brief: calculate v1 cross v2
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: v1, v2 -- operands involved in the cross-multiplication operation
% @return: v -- the result of v1 cross v2
%%
v.x = v1.y .* v2.z - v1.z .* v2.y;
v.y = v1.z .* v2.x - v1.x .* v2.z;
v.z = v1.x .* v2.y - v1.y .* v2.x;
end


%% ================================================================== %%
function J = current(J, spcs, prm)
%%
% @brief: calculate the current density generated by a species
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: J -- the current
% @param: spcs -- a species, e.g. ion, electron, ...
% @param: prm -- the parameters structure
% @return: J -- the calculated current
%%
% spcs.m = 1;
% spcs.q = 1;
% spcs.rx = 12.9;
% spcs.v.x = -0.3;
% spcs.v.y = 0.4;
% spcs.v.z = 0.5;

npt = length(spcs.rx);
r2 = spcs.rx;
r1 = r2 - spcs.v.x * prm.dt;
i1 = floor(r1);
i2 = floor(r2);
r0 = (r1 + r2) * 0.5;
i01 = floor(r0);
i02 = ceil(r0);
r01 = i02 - r0;
r02 = 1 - r01;
for i = 1:npt
    %% Jy and Jz
    J.y(i01(i)) = J.y(i01(i)) + spcs.q * spcs.v.y(i) * r01(i);
    J.y(i02(i)) = J.y(i02(i)) + spcs.q * spcs.v.y(i) * r02(i);
    J.z(i01(i)) = J.z(i01(i)) + spcs.q * spcs.v.z(i) * r01(i);
    J.z(i02(i)) = J.z(i02(i)) + spcs.q * spcs.v.z(i) * r02(i);

    %% Jx
    jx = spcs.q * spcs.v.x(i);
    dx = abs(r2(i) - r1(i));
    if i1(i) == i2(i)
        %% don't cross the cell
        J.x(i1(i)) = J.x(i1(i)) + jx;
    elseif i1(i) < i2(i)
        %% cross the cell from left to right
        x1 = (i2(i) - r1(i)) / dx;
        x2 = (r2(i) - i2(i)) / dx;
        J.x(i1(i)) = J.x(i1(i)) + jx * x1;
        J.x(i2(i)) = J.x(i2(i)) + jx * x2;
    else
        x2 = (i1(i) - r2(i)) / dx;
        x1 = (r1(i) - i1(i)) / dx;
        J.x(i1(i)) = J.x(i1(i)) + jx * x1;
        J.x(i2(i)) = J.x(i2(i)) + jx * x2;
    end
end
J.x = boundary_add(J.x, prm);
J.y = boundary_add(J.y, prm);
J.z = boundary_add(J.z, prm);
end


%% ================================================================== %%
function fd = boundary_copy(fd, prm)
%%
% @brief: copy the boundary
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: fd -- the field need to be copied
% @param: prm -- the parameters structure
% @return: fd -- the copied field
%%
fd(prm.x1 - 1) = fd(prm.x2);
fd(prm.x2 + 1) = fd(prm.x1);
end


%% ================================================================== %%
function fd = boundary_add(fd, prm)
%%
% @brief: add the boundary
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: fd -- the field need to be added
% @param: prm -- the parameters structure
% @return: fd -- the added field
%%
fd(prm.x2) = fd(prm.x2) + fd(prm.x1 - 1);
fd(prm.x2 - 1) = fd(prm.x2 - 1) + fd(prm.x1 - 2);
fd(prm.x1 - 1)  = 0;
fd(prm.x1 - 2) = 0;
fd(prm.x1) = fd(prm.x1) + fd(prm.x2 + 1);
fd(prm.x1 + 1) = fd(prm.x1 + 1) + fd(prm.x2 + 2);
fd(prm.x2 + 1) = 0;
fd(prm.x2 + 2) = 0;
end


%% ================================================================== %%
function r = boundary_particle(r, prm)
%%
% @brief: the treatment of particle boundary
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: r the particles' position
% @param: prm -- the parameters structure
% @return: position with processed boundary
%%
r = r - prm.nx * (r >= prm.x2 + 1);
r = r + prm.nx * (r < prm.x1);
end


%% ================================================================== %%
function v = relativity(v, prm)
%%
% @bried: relativistic transformation of thermal velocity
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: v -- the random thermal velocity
% @param: prm -- the parameters structure
% @return: v -- the transformed thermal velocity
%%
u2 = vector_square(v);
u4 = u2 .* u2;
c4 = prm.c2 * prm.c2;
u = sqrt((sqrt(u4 + 4 * c4) - u2)/(2 * prm.c2));
v.x = u .* v.x;
v.y = u .* v.y;
v.z = u .* v.z;
end


%% ================================================================== %%
function fd = smooth_field(fd, prm)
%%
% @brief: smooth the field
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: fd -- the field required to smooth
% @param: prm -- the parameters structure
% @return: fd -- the smoothed field
%%
fd(prm.box) = fd(prm.box) * 0.5 + fd(prm.box - 1) * 0.25 + fd(prm.box + 1) * 0.25;
fd = boundary_copy(fd, prm);
end


%% ================================================================== %%
function model = select_model(list)
%%
% @brief: choose the simulation model
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: list -- the simulatiom model list
% @return: model -- the simulation model string
%%
tf = false;
while ~tf
    [indx, tf] = listdlg('ListString', list, 'SelectionMode','single', ...
        'Name', 'select the simulation model','InitialValue', 1,...
        'ListSize', [300, 200]);
    if ~tf
        opts = struct('WindowStyle','modal',...
            'Interpreter','tex');
        f = warndlg('\color{blue} Please select a simulatiom model to cintinue',...
            'Warning', opts);
        uiwait(f);
    end
end
model = char(list(indx));
end


%% ================================================================== %%
function sm = smoothdlg()
%%
% @brief: smooth the data or not
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: sm -- true - smooth; false - unsmooth
%%
tf = false;
while ~tf
    [indx, tf] = listdlg('ListString', {'unsmooth', 'smooth'}, 'SelectionMode','single', ...
        'Name', 'smooth data','InitialValue', 1,...
        'ListSize', [300, 100]);
    if ~tf
        opts = struct('WindowStyle','modal',...
            'Interpreter','tex');
        f = warndlg('\color{blue} Please select smoothed or unsmoothed data',...
            'Warning', opts);
        uiwait(f);
    end
end
sm = (indx == 2);
end


%% ================================================================== %%
function fd = assign2grid(r, val, fd)
%%
% @brief: interpolate value to grid points
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: r -- the position of field interpolation
% @param: val -- the value need to be interpolated
% @param: fd -- the field before interpolating
% @return: fd -- the interpolated field
%%
i1 = floor(r);
i2 = ceil(r);
r2 = r - i1;
r1 = 1 - r2;
tnp = length(r);
for i = 1:tnp
    fd(i1(i)) = fd(i1(i)) + val .* r1(i);
    fd(i2(i)) = fd(i2(i)) + val .* r2(i);
end
end

%% ================================================================== %%
function [divE, rho] = gass_law(E, prt, prm)
%%
% @brief: calculate the gass's law of electric field
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: E -- the electric field
% @param: prt -- the particles
% @param: prm -- the parameters structure
% @return: divE -- the divergence of electric field
% @return: rho -- the net charge density
%%
divE = zeros(1, prm.xx);
divE(prm.box) = E.x(prm.box) - E.x(prm.box - 1);
divE = boundary_copy(divE, prm);

rho = zeros(1, prm.xx);
rho = assign2grid(prt.electron.rx, prt.electron.q, rho);
rho = assign2grid(prt.ion.rx, prt.ion.q, rho);
rho = boundary_add(rho, prm);
rho = boundary_copy(rho, prm);
if prm.smooth
    rho = smooth_field(rho, prm);
end
end


%% ================================================================== %%
function [divJ, pnt] = continuity(J, prt, prm)
%%
% @brief: calculate the continuity equation
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: J -- the current density
% @param: prt -- the particles
% @param: prm -- the parameters structure
% @return: divJ -- the divergence of current density
% @return: pnt -- partial n/partial t
%%
divJ = zeros(1, prm.xx);
divJ(prm.box) = J.x(prm.box) - J.x(prm.box - 1);
divJ = boundary_copy(divJ, prm);


persistent n0;
if prm.first
    n0 = zeros(1, prm.xx);
end

rho = zeros(1, prm.xx);
rho = assign2grid(prt.electron.rx, prt.electron.q, rho);
rho = assign2grid(prt.ion.rx, prt.ion.q, rho);
rho = boundary_add(rho, prm);
rho = boundary_copy(rho, prm);
if prm.smooth
    rho = smooth_field(rho, prm);
end

pnt = (rho - n0) * prm.dt;
pnt = boundary_copy(pnt, prm);

n0 = rho;
end


%% ================================================================== %%
function Ep = particle_energy(spcs, prm)
%%
% @brief: calculate the kinetic energy of a species
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: spcs -- the species, e.g. electron, ion
% @param: prm -- the parameters structure
% @return: Ep -- the particle's energy
%%
Ep = (1./sqrt(1 - vector_square(spcs.v)./prm.c2) - 1) .* spcs.m .* prm.c2;
end


%% ================================================================== %%
function [Eb, Ee, Ep] = energy(B, E, prt, prm)
%%
% @brief: calculate the energy of field and particles
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: B -- the magnetic field
% @param: E -- the electric field
% @param: prt -- the particles
% @param: prm -- the parameters structure
%%
Eb = vector_square(B);
Eb = sum(Eb(prm.box))*prm.c2*0.5;
Ee = vector_square(E);
Ee = sum(Ee(prm.box))*prm.epsilon0*0.5;

Ep.ion = sum(particle_energy(prt.ion, prm));
Ep.electron = sum(particle_energy(prt.electron, prm));
end


%% ================================================================== %%
function prm = model_thermal(prm)
%%
% @brief: collect the parameters of thermal model
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: prm -- the parameters structure
% @return: prm -- the parameters structure
%%
%% obtain the necessary parameters from the dialog
prompt = {'number of grid points: ', ...
    'number of time steps: ', ...
    'mass ratio between ion and electron m_i/m_e: ', ...
    'temperature ratio between ion and electron T_i/T_e: ', ...
    'electron inertial length d_e: ', ...
    'number of particles per cell: ', ...
    'ratio between plasma frequency and gyro-frequency of electron \omega_{pe}/\omega_{ce}: ', ...
    'the beta value \beta'};
dlgtitle = [prm.model, ' model parameters'];
dims = [1 100];
definput = {'300' , '556', '25', '2', '10', '100', '5', '1'};
opts = struct('WindowStyle','modal', 'Interpreter','tex');
answer = inputdlg(prompt,dlgtitle,dims,definput,opts);

%% set the parameters according to the input
prm.nx = str2double(answer{1});
prm.nt = str2double(answer{2});
prm.mie = str2double(answer{3});
prm.tie = str2double(answer{4});
prm.de = str2double(answer{5});
prm.npc = str2double(answer{6});
prm.wpce = str2double(answer{7});
prm.beta = str2double(answer{8});

%% smooth
prm.smooth = smoothdlg();

%% magnetic field
prm.Bx = 1;
prm.By = 0;
prm.Bz = 0;
prm.B = sqrt(prm.Bx.^2 + prm.By.^2 + prm.Bz.^2);

%% ion inertial length
prm.di = prm.de * sqrt(prm.mie);

%% electron temperature
prm.te = 1;

% the magnetic pressure
Pb = prm.B * prm.B * prm.c2 * 0.5;

% the thermal pressure
Pt = prm.beta * Pb;

% plasma density
prm.n0 = Pt/(prm.te*(1 + prm.tie));

% the number of particle represented by one super-particle
prm.coeff = prm.npc / prm.n0;

% reset the density and temperature
prm.n0 = prm.n0 * prm.coeff;
prm.te = prm.te / prm.coeff;
prm.ti = prm.te * prm.tie;

% frequency
prm.wpe = prm.c / prm.de;
prm.wce = prm.wpe / prm.wpce;
prm.wpi = prm.c / prm.di;
prm.wci = prm.wce / prm.mie;

% the charge and mass
prm.me = prm.wpce.^2 * prm.epsilon0 * prm.B.^2 / prm.n0;
prm.mi = prm.me * prm.mie;
prm.qi = prm.wci * prm.mi / prm.B;
prm.qe = - prm.qi;

% thermal velocity
prm.vte = sqrt(prm.te / prm.me);
prm.vti = sqrt(prm.ti / prm.mi);

% debye length
prm.debye = prm.vte / prm.wpe;

% Larmor length
prm.ali = prm.vti / prm.wci;
prm.ale = prm.vte / prm.wce;

% alfven speed
prm.via = prm.B * prm.c / sqrt(prm.n0 * prm.mi);
prm.vea = prm.B * prm.c / sqrt(prm.n0 * prm.me);

% box
prm.Lx = prm.nx/prm.de;
prm.lx = linspace(0, prm.Lx, prm.nx);

prm.Lt = prm.nt * prm.dt * prm.wce;
prm.lt = linspace(0, prm.Lt, prm.nt + 1);
end


%% ================================================================== %%
function [fd, prt] = init_thermal(prm)
%%
% @brief: initialization of thermal model
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: prm -- the parameters structure
% @return: fd -- the field, including B, E, and J
% @return: prt -- the particle
%%
%% field
fd = memory_field(prm);

%% particle
prt = memory_particle_2s(prm);

prt.electron.rx = unifrnd(prm.x1, prm.x2+1, [1, prm.tnp]);
prt.ion.rx = prt.electron.rx;
prt.electron.v.x = normrnd(0, prm.vte, [1, prm.tnp]);
prt.electron.v.y = normrnd(0, prm.vte, [1, prm.tnp]);
prt.electron.v.z = normrnd(0, prm.vte, [1, prm.tnp]);
prt.electron.v = relativity(prt.electron.v, prm);

prt.ion.v.x = normrnd(0, prm.vti, [1, prm.tnp]);
prt.ion.v.y = normrnd(0, prm.vti, [1, prm.tnp]);
prt.ion.v.z = normrnd(0, prm.vti, [1, prm.tnp]);
prt.ion.v = relativity(prt.ion.v, prm);
end


%% ================================================================== %%
function diagnosis_thermal(fd, prt, prm, tt, t)
%%
% @info: plot figure of thermal model
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: fd  -- data of field
% @param: prt -- data of particles
% @param: prm -- the parameters structure
% @param: tt -- the currnet time, which is a string
% @param: t -- the current time step, which is a number
%%

%% set the figure
if prm.first
    f = figure;
    pos = get(f,'Position');
    pos(2) = 100;
    pos(4) = 700;
    set(f, 'Position', pos);
end

%% continuity equation
[divJ, pnt] = continuity(fd.J, prt, prm);
subplot(5, 1, 1);
plot(prm.lx, divJ(prm.box) + pnt(prm.box), '-r', 'LineWidth', 1);
xlim([0, prm.Lx]);
title({'thermal model', ['t = ', tt, ' \omega_{ce}^{-1}']});
ylabel('\nabla \cdot J + \partial \rho/\partial t');


%% gauss law
[divE, rho] = gass_law(fd.E, prt, prm);
subplot(5,1,2)
plot(prm.lx, divE(prm.box) - rho(prm.box)/prm.epsilon0, '-r', 'LineWidth', 1);
xlim([0, prm.Lx]);
ylabel('\nabla \cdot E - \rho/\epsilon_0');


%% magnetic field
subplot(5,1,3);
plot(prm.lx, fd.B.x(prm.box), '-k', 'LineWidth', 1);
hold on
plot(prm.lx, fd.B.y(prm.box), '-r', 'LineWidth', 1);
plot(prm.lx, fd.B.z(prm.box), '-b', 'LineWidth', 1);
hold off
xlim([0, prm.Lx]);
ylabel('B');
legend('Bx', 'By', 'Bz');


%% electric field
subplot(5,1,4);
plot(prm.lx, fd.E.x(prm.box), '-k', 'LineWidth', 1);
hold on
plot(prm.lx, fd.E.y(prm.box), '-r', 'LineWidth', 1);
plot(prm.lx, fd.E.z(prm.box), '-b', 'LineWidth', 1);
hold off
xlim([0, prm.Lx]);
ylabel('E');
legend('Ex', 'Ey', 'Ez');
xlabel('X [de]');

%% energy
persistent Eb
persistent Ee
persistent Epi
persistent Epe
persistent Et
if prm.first
    Eb = zeros(1, prm.nt+1);
    Ee = zeros(1, prm.nt+1);
    Epi = zeros(1, prm.nt+1);
    Epe = zeros(1, prm.nt+1);
    Et = zeros(1, prm.nt+1);
end
[b, e, p] = energy(fd.B, fd.E, prt, prm);
Eb(t + 1) = b;
Ee(t + 1) = e;
Epi(t + 1) = p.ion;
Epe(t + 1) = p.electron;
Et(t + 1) = b + e + p.ion + p.electron;
subplot(5,1,5);
it = 1:t+1;
plot(prm.lt(it), Eb(it), '-r', 'LineWidth', 1);
hold on
plot(prm.lt(it), Ee(it), '-g', 'LineWidth', 1);
plot(prm.lt(it), Epi(it), '--b', 'LineWidth', 1);
plot(prm.lt(it), Epe(it), '-m', 'LineWidth', 1);
plot(prm.lt(it), Et(it), '-k', 'LineWidth', 1);
xlim([0, prm.Lt]);
ylabel('energy');
legend('B', 'E', 'Ion', 'Electron', 'Sum');
xlabel('t [\omega_{ce}^{-1}]');
drawnow;
end