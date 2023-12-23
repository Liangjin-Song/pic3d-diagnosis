function [sas, hsas, oft] = fft2d(fx, ft, fd)
%%
% @info: written by Liangjin Song on 20231223
% @brief: the 2D FFT
% @param: fx -- the spacial sampling frequency
% @param: ft -- the temporal sampling frequency
% @param: fd -- the field data that need to be transformed
% @return: sas -- the shift amplitude spectrum
% @return: hsas -- the half shift amplitude spectrum
% @return: oft -- the original fft data
%%
%% the 2D FFT
[nt, nx] = size(fd);
if mod(nt, 2) ~= 0
    nt0 = nt + 1;
else
    nt0 = nt;
end
if mod(nx, 2) ~= 0
    nx0 = nx + 1;
else
    nx0 = nx;
end
fd0 = zeros(nt0, nx0);
fd0(1:nt, 1:nx) = fd(1:nt, 1:nx);

%% the 2D FFT
oft.ft = fft2(fd0);
[nt, nx] = size(oft.ft);
oft.lk = linspace(0, fx, nx);
oft.lw = linspace(0, ft, nt);

%% the shift amplitude spectrum
sas.ft = abs(fftshift(oft.ft))/(nt*nx);
sas.lk = linspace(-fx/2, fx/2, nx);
sas.lw = linspace(-ft/2, ft/2, nt);

%% the half shift amplitude spectrum
hsas.ft = sas.ft((nt/2+1):end, (nx/2+1):end);
tmp = sas.ft((nt/2+1):end, 1:nx/2);
hsas.ft = hsas.ft + tmp(:, end:-1:1);
hsas.ft(2:end, 2:end) = hsas.ft(2:end, 2:end)*2;
hsas.lk = linspace(0, fx/2, nx/2);
hsas.lw = linspace(0, ft/2, nt/2);
end