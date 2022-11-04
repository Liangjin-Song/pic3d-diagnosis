function test_particle()
%%
% @brief: the entry function of test particle
% @info: writen Liangjin Song on 20221025 at NCU
%%
clear all;
%% parameters
% light speed
prm.c = 1;
% time step
prm.dt = 0.05;
% grid length
prm.dr = 0.1;
% charge of the particle
prm.q = 1;
% mass of the particle
prm.m = 1;
% ratio of charge and mass
prm.qm = prm.q/prm.m;
% the number of particles
prm.np = 1;
% the initial magnetic field
prm.b = 1;
% the number of waves, controlling the wave vector
prm.nk = 10;
% amplitude of the wave
prm.aw = 0.1;
% the frequency of the wave, the unit is the gyro-frequency
prm.w = 0.8;
% the number of time step
prm.nt = 500;
% the initial velocity of particles
prm.v = 0.5;

%% initialization of particles
[r, v] = init_particle(prm);

%% loop
for t = 1:prm.nt
    %% obtain the field
    B = magnetic(prm, r, v, t);
    E = electric(prm, r, v, t);
    %% advancing the particles
    v = velocity(prm, v, B, E);
    r = position(prm, r, v);
    %% figure
    diagnose(prm, r, v);
end
clear Function;
end

function [r, v] = init_particle(prm)
%%
% @brief: initialization of particles
% @info: writen Liangjin Song on 20221025 at NCU
% @return: r -- the particles' position
%          v -- the particles' velocity
%%
%% position
r.x = zeros(1, prm.np);
r.y = zeros(1, prm.np);
r.z = zeros(1, prm.np);
for p = 1:prm.np
    r.x(p) = prm.dr * p;
    r.y(p) = prm.dr * p;
    r.z(p) = prm.dr * p;
end
%% velocity
v.x = zeros(1, prm.np) + prm.v;
v.y = zeros(1, prm.np); 
v.z = zeros(1, prm.np);
end

function B = magnetic(prm, r, v, t)
%%
% @brief: obtain the magnetic field at the particles' position
% @info: writen Liangjin Song on 20221025 at NCU
% @param: prm -- the parameter structure
% @param: r -- the particles' position
% @param: v -- the particles' velocity
% @param: t -- the time step
% @return: B -- the magnetic field
%%
B.x = zeros(1, prm.np);
B.y = zeros(1, prm.np);
% the magnetic field is in z direction
B.z = zeros(1, prm.np) + prm.b;
end

function E = electric(prm, r, v, t)
%%
% @brief: obtain the electric field at the particles' position
% @info: writen Liangjin Song on 20221025 at NCU
% @param: prm -- the parameter structure
% @param: B -- the magnetic field
% @param: r -- the particles' position
% @param: v -- the particles' velocity
% @param: t -- the time step
% @return: E -- the electric field
%%
%% the gryo-frequency of particles
wg = abs(prm.qm * prm.b);
w = prm.w * wg;
%% the wave
ex = 0;
ey = 0;
for i = 1:prm.nk
    ex = ex + prm.aw*sin(2 * pi * i * prm.dr * r.y - w * t * prm.dt);
    ey = ex + prm.aw*sin(2 * pi * i * prm.dr * r.x - w * t * prm.dt);
end
%% the number of particles
np = length(r.x);
E.x = zeros(1, np) + ex;
E.y = zeros(1, np) + ey;
E.z = zeros(1, np);
end

function v = velocity(prm, v, b, e)
%%
% @brief: calculate the velocity
% @info: writen Liangjin Song on 20221025 at NCU
% @param: prm -- the parameter structure
% @param: v -- the particles' velocity
% @param: B -- the magnetic field
% @return: E -- the electric field
%%
qt = prm.qm * prm.dt;
c2 = prm.c * prm.c;
%% step 1
gamma = prm.c./(sqrt(c2 - vector_square(v)));
u.x = gamma .* v.x;
u.y = gamma .* v.y;
u.z = gamma .* v.z;

%% step 2
u1.x = u.x + qt * e.x;
u1.y = u.y + qt * e.y;
u1.z = u.z + qt * e.z;

%% step 3
gamma = qt * prm.c./(sqrt(c2 + vector_square(u1)));
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
gamma = prm.c./(sqrt(c2 + vector_square(u)));
v.x = gamma .* u.x;
v.y = gamma .* u.y;
v.z = gamma .* u.z;
end

function v2 = vector_square(v)
%%
% @brief: calculate the square of a vector
% @info: written by Liangjin Song on 20220429 at Nanchang University
% @param: v -- a vector
% @return: v2 -- the square of the vector
%%
v2 = v.x.^2 + v.y.^2 + v.z.^2;
end

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

function r = position(prm, r, v)
%%
% @brief: calculate the position of the particles
% @info: writen Liangjin Song on 20221025 at NCU
% @param: prm -- the parameter structure
% @param: r -- the particles' position
% @param: v -- the particles' velocity
%%
r.x = r.x + v.x * prm.dt;
r.y = r.y + v.y * prm.dt;
r.z = r.z + v.z * prm.dt;
end

function diagnose(prm, r, v, t)
%%
% @brief: plot figure
% @info: writen Liangjin Song on 20221025 at NCU
% @param: prm -- the parameter structure
% @param: r -- the particles' position
% @param: v -- the particles' velocity
%%
global e;
global de;
global f;
global x;
global y;
global z;
%% plot total energy
ae = energy(prm, v);
if isempty(e)
    for p = 1:prm.np
    tp = num2str(p);
    eval(['e.e',tp, ' = ae(p);']);
    eval(['de.e',tp, '= 0;']);
    eval(['x.r',tp, '= r.x(p);']);
    eval(['y.r',tp, '= r.y(p);']);
    eval(['z.r',tp, '= r.z(p);']);
    eval(['f.f',tp, ' = figure;']);
    ax = get(gcf, 'Position');
    ax(2) = 100;
    ax(4) = ax(4) * 2;
    set(gcf, 'Position', ax);
    end
    return;
end
nf = 3;
for p = 1:prm.np
    tp = num2str(p);
    eval(['figure(f.f',tp,');']);
    eval(['e.e',tp,' = [e.e',tp,', ae(p)];']);
    subplot(nf,1,2);
    eval(['plot(e.e', tp, ', ''-k'');']);
    xlabel('t');
    ylabel('E_{total}');
    xlim([1, prm.nt]);
    subplot(nf,1,3);
    eval(['de.e', tp, '= [de.e', tp, ', (e.e',tp, '(end)-e.e',tp,'(1))/e.e',tp,'(1)];']);
    eval(['plot(de.e',tp,', ''-k'');']);
    xlabel('t');
    ylabel('\Delta E_{total}/E_0');
    xlim([1, prm.nt]);
    subplot(nf,1,1);
    eval(['x.r',tp,' = [x.r',tp,', r.x(p)];']);
    eval(['y.r',tp,' = [y.r',tp,', r.y(p)];']);
    eval(['z.r',tp,' = [z.r',tp,', r.z(p)];']);
    eval(['plot3(x.r', tp, ', y.r', tp, ', z.r', tp, ',''-k'');']);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title(['Particle ', tp]);
end
end

function e = energy(prm, v)
%%
% @brief: calculate the position
% @info: writen Liangjin Song on 20221025 at NCU
% @param: prm -- the parameter structure
% @param: r -- the particles' position
% @param: v -- the particles' velocity
%%
c2 = prm.c * prm.c;
e = (1./sqrt(1 - vector_square(v)./c2) - 1) .* prm.m .* c2;
end