function plot_velocity_vector(obj)
%% writen by Liangjin Song on 20210411
%% plot the velocity vector in the plane
%%
tt=30;
Vic=obj.prm.read_data('Vh', tt);
Figures.plot_vector(Vic.value.x, Vic.value.z, obj.prm, 10, 5, 'r');

