function plot_field2d(fd, norm, prm)
%% writen by Liangjin Song on 20210409
%% plot 2d field
%% 
fd=fd/norm;
Figures.field(prm.value.lx, prm.value.lz,fd);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
xlim([0,prm.value.Lx]);
ylim([-prm.value.Lz/2, prm.value.Lz/2]);
