%% plot the simulation data
clear;
%% parameters
indir = 'E:\mps\test';
tt = 198;
name = 'E';

%% loop
nt = length(tt);
cd(indir);
figure;
% ------------------------------------------------------------------- %
for t = 1:nt
    fd = others.mps_debug.line.mps_read(name, tt(t));
    % --------------------------------------------------------------- %
    plot(fd.z, '-k', 'LineWidth', 2);
    title(['t = ', num2str(tt(t))]);
    xlabel('X');
    ylabel(name);
    set(gca, 'FontSize', 14);
    pause(0.5);
end
