classdef Physics
%%
% @info: writen by Liangjin Song on 20210502
% @brief: the Physics class contains some mathematic and physical calculation
%%
%% ======================================================================== %%
%% constructor
methods (Access = public)
    function obj=Physics()
    end
end

%% ======================================================================== %%
%% some mathematic calculation
methods (Access = public, Static)
    y = linear(point1, point2, x);
    ll= filter1d(ll, n);
end

%% ======================================================================== %%
%% some vector operation
methods (Access = public, Static)
    fd = cross(A, B);
end

%% ======================================================================== %%
%% some physics value
methods (Access = public, Static)
    fd = poynting_vector(E, B, mu);
end

%% ======================================================================== %%
%% some equation
methods (Access = public, Static)
    [vxB, divP, nvv, nvt] = momentum_equation(prm, name, tt, dt, q, m);
end


%% ======================================================================== %%
end
