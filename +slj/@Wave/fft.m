function obj = fft(obj, fd, fk, fw, icnt)
%%
% @info: writen by Liangjin Song on 20210701
% @brief: the fourier transform
% @param: fd - the field if space and time, space in x direction and time in y direction
% @param: fk - the sampling frequency in space
% @param: fw - the sampling frequency in time 
% @param: icnt - 0: fft in x and y compornents; 1: fft in y compornent; 2: fft in x compornent
% @return: obj - the Wave object
%%
%% the size of the field
fd=fd';
nx=size(fd,1);
nt=size(fd,2);
if (mod(nt,2) == 1) || (mod(nx,2)==1)
    error('Error: the size of the field should be even number!');
end

%% the fourier transform
wk=slj.Wave.wkfft2d(fd,nx,nt,icnt);
obj.wk=[fliplr(wk(4:2:end,1:2:(end-1))'),wk(1:2:end,1:2:(end-1))'];

kmin = 2/(nx*fk);
kmax = kmin*(nx/2-1);
obj.k=[-kmax:kmin:-kmin,0,kmin:kmin:kmax];

ren.t=0.006695/2;
isdiag=49.95/ren.t;
wmin = 2*pi/(ren.t*2)/2/(nt/2)/isdiag;
wmax = wmin*(nt/2);
obj.w = 0:wmin:(wmax-wmin);
% obj.w=fw*(0:round(nt/2)-1)/nt;
end
