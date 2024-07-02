%% plot the simulation data
clear;
%% parameters
indir = 'D:\Downloads\mps';
tt = 0:100;
name = 'divE';

%% loop
nt = length(tt);
cd(indir);
figure;
% ------------------------------------------------------------------- %
for t = 1:nt
    fd = mps_read(name, tt(t));
    % --------------------------------------------------------------- %
    plot(fd, '-k', 'LineWidth', 2);
    title(['t = ', num2str(tt(t))]);
    xlabel('X');
    ylabel(name);
    set(gca, 'FontSize', 14);
    pause(0.5);
end
