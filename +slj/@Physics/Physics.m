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
%% some vector/tensor operation
methods (Access = public, Static)
    fd = cross(A, B);
end

%% ======================================================================== %%
%% some physics value
methods (Access = public, Static)
    fd = poynting_vector(E, B, mu);
    [curv, R] = curvature(prm, B);
    R = gyroradius(q, m, V, B);
    K = kappa(prm, q, m, V, B);
end

%% ======================================================================== %%
%% some equation
methods (Access = public, Static)
    [vxB, divP, nvv, nvt] = momentum_equation(prm, name, tt, dt, q, m);
    [vxB, divP, nvv, nvt] = momentum_equation_velocity(prm, name, tt, dt, q, m);
end

%% ======================================================================== %%
%% energy conversion equation
methods (Access = public, Static)
    %% bulk kinetic energy conversion
    K = kinetic_energy(m, N, V);
    [pKt, divKV, qVE, divPV] = kinetic_energy_conversion(prm, name, tt, dt, q, m);
    %% thermal energy conversion
    U = thermal_energy(P);
    [pUt, divPV, divQ, divH] = thermal_energy_conversion(prm, name, tt, dt);
    %% temperature
    T = temperature(P, N);
    [pTt, divQ, PddivV, pdivV, VdivT] = energy_density_conversion(prm, name, tt, dt);
end


%% ======================================================================== %%
end
