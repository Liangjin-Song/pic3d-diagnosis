%%
% simulate the Langmuir oscillation
%%
clear;

%% parameters
% number of grids in space
nx = 1000;

% nmber of time step
nt = 1000;


% initial density
n = 1;

% initial density disturbance
dnt0 = 0.1;

% elementary charge
e = 1;

% mass of electron
m = 1;

% vacuum permittivity
epsilon = 1;

% time step and grid length
dx = 0.1;
dt = 0.05;
Lx = dx*nx;
lx = linspace(0, Lx, nx);

%% the electron plasma frequency
wp = sqrt(n*e*e/(m*epsilon));

%% apply for memory
dn0 = zeros(1, nx);     % previous
dn1 = zeros(1, nx);     % current
dn2 = zeros(1, nx);     % next
nn = zeros(1, nt);

%% initial condition
dn1 = dn1 + dnt0 .* sin(dt) .* sech(((1:nx) - nx*0.5)*dx);
nn(1) = dn1(nx/2);
figure;
pause('on');
%% solve the equation
for t = 1:nt
    dn2 = 2*dn1 - dn0 - wp*wp*dt*dt*dn1;

    %% switch data
    dn0 = dn1;
    dn1 = dn2;
    nn(t) = dn2(nx / 2) + n;

    %% figure
    plot(lx, dn2 + n, '-r', 'LineWidth', 2);
    xlim([0, Lx]);
    ylim([n - dnt0 * 1.5, n + dnt0*1.5]);
    xlabel('X');
    ylabel('N');
    title(['t = ', num2str(t*dt, '%06.2f')]);
    pause(0.01);
end

%% 
figure;
tt = nt*dt;
lt = linspace(0, tt, nt);
plot(lt, nn, '-k', 'LineWidth', 1);
hold on
plot(lt, dnt0*sin(wp*(lt + dt)) + n, '--r', 'LineWidth', 1);
legend('Simulation', 'Theory');
xlabel('t');
ylabel('N');
xlim([0, tt]);
ylim([n - dnt0 * 1.5, n + dnt0*1.5]);