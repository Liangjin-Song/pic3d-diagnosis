classdef Wave
%%
% @info: writen by Liangjin Song on 20210701
% @brief: the wave analysis
%%
properties (SetAccess = private)
    w;
    k;
    wk;
end
%% ======================================================================== %%
%% constructor
methods (Access = public)
    function obj=Wave(fd, fk, fw, icnt)
        if nargin < 4
            icnt = 0;
        end
        obj=obj.fft(fd,fk,fw,icnt);
    end
end

%% ======================================================================== %%
%% the Fourier transform
methods (Access = private)
    obj = fft(obj, fd, fk, fw, icnt);
end

%% ======================================================================== %%
%% the 1d and 2d Fourier transform
methods (Access = private, Static)
    ar = wkfft2d(ar,n,m,icnt);
end

%% ======================================================================== %%
end
