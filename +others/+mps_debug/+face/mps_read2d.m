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
