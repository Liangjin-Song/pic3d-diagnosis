c=0.5;
mu=1/(c*c);
S=slj.Physics.poynting_vector(E, B, mu);
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
f=figure;
slj.Plot.overview(S.x,ss,lx, lz,1,extra);
f=figure;
slj.Plot.overview(S.z,ss,lx, lz,1,extra);



lsx=S.x(:,2704);
lsz=S.z(:,2704);
f=figure;
plot(lz,lsx,'-r','LineWidth',2); hold on
plot(lz,lsz,'-k','LineWidth',2);
legend('S_x','S_z','Location','Best');
xlabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',14);