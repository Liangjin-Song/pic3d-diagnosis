%%
% simulate the Langmuir wave
%%
clear;

%% parameters
% number of grids in space
nx = 1000;

% nmber of time step
nt = 5000;

% polytropic index
gamma = 1;

% electron temperature
Te = 1;

% Boltzmann constant
kB = 1;

% electron mass
m = 1;

% vacuum permittivity
epsilon = 1;

% elementary charge
e = 1;

% initial density
n = 1;

% time step and grid length
dx = 0.1;
dt = 0.05;

% initial density disturbance
dnt0 = 0.1;

%% the electron plasma frequency
wp = sqrt(n*e*e/(m*epsilon));

%% some constant values
K = gamma * kB * Te / m;
v = sqrt(K);
vthe = sqrt(kB * Te / m);
C1 = K * dt * dt / (dx * dx);
C2 = dt * dt * wp * wp;

%% apply for memory
xx = nx + 4;
dn0 = zeros(1, xx);     % previous
dn1 = zeros(1, xx);     % current
dn2 = zeros(1, xx);     % next
nn = zeros(nt, nx);

box = 3:nx+2;

%% space and time length
Lx = nx * dx;
lx = linspace(0, Lx, nx);
TT = nt * dt;
lt = linspace(0, TT, nt);

%% the initial condition
dn1 = dn1 + dnt0 .* sin(dt) .* sech(((1:xx) - xx*0.5)*dx);

%% solve the wave equation
figure;
pause('on');
for t = 1:nt
    dn2(box) = 2 * dn1(box) - dn0(box) + C1 * (dn1(box + 1) - 2 * dn1(box) + dn1(box - 1)) - C2 * dn1(box);

    %% boundary condition
    dn2 = boundary(dn2, 'periodic', box, dx, dt, v, dn1);

    %% save the data
    dn0 = dn1;
    dn1 = dn2;
    nn(t, :) = dn2(box);

    plot(lx, dn1(box) + n, '-r', 'LineWidth', 1);
    title(['t = ', num2str(t*dt, '%06.2f')]);
    ylabel('N');
    xlim([0,Lx]);
    ylim([n-dnt0, n+dnt0]);
    xlabel('X');
    pause(0.001);
end


figure;
F = fftshift(fft2(nn));
k = 2*pi/dx;
k = linspace(-k*0.5, k*0.5, nx);
f = 2*pi/dt;
f = linspace(-f*0.5, f*0.5, nt);


[X, Y] = meshgrid(k, f);
p = pcolor(X, Y, abs(F));
shading flat;
p.FaceColor = 'interp';
colorbar;

w = sqrt(wp*wp + k.*k.*gamma.*vthe.*vthe);
hold on
plot(k, w, '--k', 'LineWidth', 1);

xlim([-5,5]);
ylim([0,5]);

xlabel('k');
ylabel('\omega');
title('Langmuir Wave');
set(gca,'FontSize', 14);



%% boundary
function fd = boundary(fd, type, box, dx, dt, v, fd0)
if strcmp(type, 'periodic')
    fd(box(1) - 1) = fd(box(end));
    fd(box(end) + 1) = fd(box(1));
elseif strcmp(type, 'open')
    k = dx/(v*dt);
    fd(box(end) + 1) = fd(box(end)) - k * (fd(box(end)) - fd0(box(end)));
    fd(box(1) - 1) = fd(box(1)) - k * (fd(box(1)) - fd0(box(1)));
elseif strcmp(type, 'dirichlet')
    fd(box(end) + 1) = 0;
    fd(box(1) - 1) = 0;
elseif strcmp(type, 'neumann')
    fd(box(end) + 1) = fd(box(end));
    fd(box(1) - 1) = fd(box(1));
end
end