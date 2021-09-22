function pm=particle_position(mr,pr)
%% change the particle position from simulation frame to rest frame
%% writen by Liangjin Song on 20210413
%% @para: mr, the vector in x or z direction
%% @para: pr, the particle's position in the simulation frame
    k=(mr(end)-mr(1))/(length(mr)-1);
    pm=k*(pr-1)+mr(1);
end
