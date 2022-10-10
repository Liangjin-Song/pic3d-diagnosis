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
    R = gyroradius(q, m, T, B);
    K = kappa(prm, q, m, T, B);
end

%% ======================================================================== %%
%% momentum equation
methods (Access = public, Static)
    [vxB, divP, nvv, nvt] = momentum_equation(prm, name, tt, dt, q, m);
    [vxB, divP, nvv, nvt] = momentum_equation_velocity(prm, name, tt, dt, q, m);
    [qNE, divP, pVt, NVV, qVB] = momentum_equation_electric_force_density(prm, name, tt, dt, q, m);
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
    %% total energy conversion
    [pTt, divF, qVE] = total_energy_conversion(prm, name, tt, dt, q, m);
    %% average total energy conversion
    [pAt, qVE, VdA, divF] = average_total_energy_conversion(prm, name, tt, dt, q, m);
    %% continuity equation
    [pNt, divNV] = continuity_equation(prm, name, tt, dt);
    %% averate bulk kinetic energy conversion
    [pv2t, qve, vdv, divPV] = average_kinetic_energy_conversion(prm, name, tt, dt, q, m);
end

%% ======================================================================== %%
%% integration of flux
methods (Access = public, Static)
    [top, bottom, left, right] = integrate2d_flux(flx, xrange, zrange, prm);
end

%% ======================================================================== %%
%% Quantifying Gyrotropy
methods (Access = public, Static)
    [aphi, dng, q, pp_fac]=agyrotropy_fac(P, B, prm);
    q = agyrotropy(P, B, prm);
end


%% ======================================================================== %%
%% Linear interpolation
methods (Access = public, Static)
    v = linear_interp_2d(px, pz, fd);
end


%% ======================================================================== %%
%% pitch angle
methods (Access = public, Static)
    angle = pitch_angle(bx, by, bz, vx, vy, vz);
end



%% ======================================================================== %%
end
