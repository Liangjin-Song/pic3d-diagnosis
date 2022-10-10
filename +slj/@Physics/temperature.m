function T = temperature(P, N)
%%
% Syntax: T = temperature(P, N)
% @info: writen by Liangjin Song on 20211019
% @brief: temperature - calculate the scalar temperature
% @param: P - the plasma pressure
% @param: N - the plasma density
% @return: T - the temperature
%%
T = (P.xx + P.yy + P.zz)/3;
T = slj.Scalar(T./N.value);
end