function fd=read_vector(obj,name)
%% writen by Liangjin Song on 20210329
% read the vector data
%%
if contains(name, 'PV')
    fd = read_particle_distribution(obj, name);
elseif contains(name, 'traj')
    fd = read_particle_trajectory(obj, name);
else
    error('Parameters error!');
end
end
