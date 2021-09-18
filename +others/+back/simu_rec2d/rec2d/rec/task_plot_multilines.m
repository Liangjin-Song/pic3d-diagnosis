%% plot multiple lines of field on the same figure
Lx=100;
Lz=50;
it=36;
zcut=[58,60,62,64,66];
nz=length(zcut);
color=['k','r','g','b','m'];
norm=0.6;
%%
% for it=it
%     filename=['Bz_t',num2str(it,'%3.3d'),'.00.txt'];
%     bz=load(filename);
%     plot_line(bz,Lx,Ly,xcut,0.6,0);
%     hold on
% end
%%
filename=['By_t',num2str(it,'%3.3d'),'.00.txt'];
ff0=load(filename);
ff=simu_filter2d(ff0);
for ii=1:nz
    plot_line(ff,Lx,Ly,zcut(ii),norm,1,color(ii));
    hold on
end
xlim([0 Lz/2])
v=axis;
plot([Lz/4 Lz/4],[v(3) v(4)],'k--')
plot([v(1) v(2)],[-0.2 -0.2],'k--')



