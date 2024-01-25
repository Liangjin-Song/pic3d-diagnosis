function [lw, res] = fft1d(fs, fd)
%%
% @brief: 1D FFT
% @info: written by Liangjin Song on 20240116
% @param: ft -- the temporal sampling frequency
% @param: fd -- the field data that need to be transformed
% @return: lw -- the frequency axis
% @return: res -- the result of fft
%%
L = length(fd);
P2 = abs(fft(fd)/L);
res = P2(1:L/2+1);
res(2:end-1) = 2*res(2:end-1);
lw = fs*(0:(L/2))/L;
end