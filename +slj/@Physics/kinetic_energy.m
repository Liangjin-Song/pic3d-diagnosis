function K = kinetic_energy(m, N, V);
%%
% @info: writen by Liangjin Song on 20211018
% @brief: kinetic_energy - calculate the bulk kinetic energy
% @param: m - the mass
% @param: N - the density
% @param: V - the velocity
% @return: K - kinetic energy
%%
K=V.sqre();
K=slj.Scalar(K.value.*N.value.*m.*0.5);
end