function fd = poynting_vector(E, B, mu)
%% 
% @info: writen by Liangjin Song on 20210809
% @brief: poynting_vector - calculate the Poynting vector
% @param: E - the electric field
% @param: B - the mganetic field
% @param: mu - the magnetic permeability
% @return: fd - the Poynting vector
%%
fd=slj.Physics.cross(E, B);
fd=fd.normalize(mu);
end
