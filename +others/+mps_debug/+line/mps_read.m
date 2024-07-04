function fd = mps_read(name, time)
%% read the simulation data
if strcmp(name, 'divB') || strcmp(name, 'divE') || contains(name, 'charge')
    fd = read_binary([name, '_t', num2str(time, '%010.4f'),'.bsd']);
elseif strcmp(name, 'B') || strcmp(name, 'E') || contains(name, 'current')
    data = read_binary([name, '_t', num2str(time, '%010.4f'),'.bsd']);
    nx = length(data) / 3;
    data = reshape(data, 3, nx);
    fd.x = data(1, :);
    fd.y = data(2, :);
    fd.z = data(3, :);
else
    error('unrecognized parameter!');
end


end

function fd = read_binary(name)
%% read the binary
fid = fopen(name, 'rb');
fd=fread(fid,Inf,'float');
fclose(fid);
end
