%% plot the simulation data
clear;
%% parameters
indir = 'D:\Develop\PIC\MPS\src\bin';
tt = 0:100;
name = 'divE';
nx=10;
ny=10;
nz=5;

%% loop
nt = length(tt);
cd(indir);
figure;
% ------------------------------------------------------------------- %
for t = 1:nt
    fd = mps_read3d(name, tt(t), nx, ny, nz);
    % --------------------------------------------------------------- %
    plot(fd(:), '-k', 'LineWidth', 2);
    title(['t = ', num2str(tt(t))]);
    xlabel('X');
    ylabel(name);
    set(gca, 'FontSize', 14);
    pause(0.5);
end
