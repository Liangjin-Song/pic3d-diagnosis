%% plot the simulation data
clear;
%% parameters
indir = 'E:\mps\turbulence\run1.1\data';
tt = 50;
% name = 'electron_regular_mass';
name = 'divE';
nx=2000;
ny=2000;

%% loop
nt = length(tt);
cd(indir);
figure;
% ------------------------------------------------------------------- %
for t = 1:nt
    fd = mps_read2d(name, tt(t), nx, ny);
    % --------------------------------------------------------------- %
    p=pcolor(fd);
    shading flat;
    % axis on;
    p.FaceColor = 'interp';
    title(['t = ', num2str(tt(t))]);
    xlabel('X');
    ylabel('Y');
    colorbar;
    set(gca, 'FontSize', 14);
    pause(0.5);
end

%% =============================================================== %%
function fd = mps_read2d(name, time, nx, ny)
%% read the simulation data
if strcmp(name, 'divB') || strcmp(name, 'divE') || contains(name, 'charge') ...
        || strcmp(name, 'stream') || contains(name, 'mass') 
    fd = read_binary([name, '_t', num2str(time, '%010.4f'),'.bsd']);
    %% ========================= reshape the data =========================== %%
    fd = reshape(fd, ny, nx);
elseif strcmp(name, 'B') || strcmp(name, 'E') || contains(name, 'current') ...
        || contains(name, 'momentum')
    data = read_binary([name, '_t', num2str(time, '%010.4f'),'.bsd']);
    % nx = length(data) / 3;
    %% ========================= reshape the data =========================== %%
    data = reshape(data, 3, nx * ny);
    fd.x = reshape(data(1, :), ny, nx);
    fd.y = reshape(data(2, :), ny, nx);
    fd.z = reshape(data(3, :), ny, nx);
else
    error('unrecognized parameter!');
end


end

%% =============================================================== %%
function fd = read_binary(name)
%% read the binary
fid = fopen(name, 'rb');
fd=fread(fid,Inf,'float');
fclose(fid);
end