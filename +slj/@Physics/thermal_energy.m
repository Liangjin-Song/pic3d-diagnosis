function U = thermal_energy(P)
%%
% Syntax: U = thermal_energy(P)
% @info: writen by Liangjin Song on 20211019
% @brief: thermal_energy - calculate the thermal energy
% @param: P - the plasma pressure
% @return: U - the thermal energy of the plasma
%%
U = slj.Scalar((P.xx + P.yy + P.zz) * 0.5); 
end