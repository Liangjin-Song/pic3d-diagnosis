function hfd = highpass2d(fd)
%%
% @brief: the high pass filter by Gauss filter
% @info: written by Liangjin Song on 20240604
% @param: fd -- the 2d field that need to filted
% @return: hfd -- the high pass filter field
%%

%% the size of the filter
M=2*size(fd,1);
N=2*size(fd,2);
u=-M/2:(M/2-1);
v=-N/2:(N/2-1);
[U,V]=meshgrid(u,v);

%% Gauss' filter
D=sqrt(U.^2+V.^2);
D0=15;
n=6;
H2=1./(1+(D0./D).^(2*n));

%% high pass
J2=fftshift(fft2(fd, size(H2,1), size(H2,2)));
K2=J2.*H2;
L2=ifft2(ifftshift(K2));
hfd=L2(1:size(fd, 1), 1:size(fd,2));
end