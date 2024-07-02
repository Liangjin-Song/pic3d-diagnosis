function fd = mps_read3d(name, time, nx, ny, nz)
%% read the simulation data
if strcmp(name, 'divB') || strcmp(name, 'divE') || contains(name, 'charge')
    fd = read_binary([name, '_t', num2str(time, '%010.4f'),'.bsd']);
    %% ========================= reshape the data =========================== %%
    fd = reshape(fd, ny, nx, nz);
elseif strcmp(name, 'B') || strcmp(name, 'E') || contains(name, 'current')
    data = read_binary([name, '_t', num2str(time, '%010.4f'),'.bsd']);
    data = reshape(data, 3, nx * ny * nz);
    fd.x = reshape(data(1, :), ny, nx, nz);
    fd.y = reshape(data(2, :), ny, nx, nz);
    fd.z = reshape(data(3, :), ny, nx, nz);
else
    error('unrecognized parameter!');
end


end
