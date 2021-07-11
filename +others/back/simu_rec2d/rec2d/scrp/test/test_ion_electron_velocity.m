%% test the ion and electron velocity
% writen by Liangjin Song on 20191209
clear;

prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);

tt=45;

cd(indir);

bz=read_data('Bz',tt);

vix=read_data('vxi',tt);
viy=read_data('vyi',tt);
viz=read_data('vzi',tt);
ni=read_data('Densi',tt);
ki=0.5*ni.*(vix.^2+viy.^2+viz.^2);

vex=read_data('vxe',tt);
vey=read_data('vye',tt);
vez=read_data('vze',tt);
ne=read_data('Dense',tt);
ke=0.5*ne.*(vex.^2+vey.^2+vez.^2);

[lbz,~]=get_line_data(bz,Lx,Ly,z0,vA,0);

[lvix,lx]=get_line_data(vix,Lx,Ly,z0,vA,0);
[lviy,~]=get_line_data(viy,Lx,Ly,z0,vA,0);
[lviz,~]=get_line_data(viz,Lx,Ly,z0,vA,0);
[lki,~]=get_line_data(ki,Lx,Ly,z0,vA,0);
[lni,~]=get_line_data(ni,Lx,Ly,z0,vA,0);
lvi=sqrt(lvix.^2+lviy.^2+lviz.^2);

[lvex,~]=get_line_data(vex,Lx,Ly,z0,vA,0);
[lvey,~]=get_line_data(vey,Lx,Ly,z0,vA,0);
[lvez,~]=get_line_data(vez,Lx,Ly,z0,vA,0);
[lke,~]=get_line_data(ke,Lx,Ly,z0,vA,0);
[lne,~]=get_line_data(ne,Lx,Ly,z0,vA,0);
lve=sqrt(lvex.^2+lvey.^2+lvez.^2);


lw=2;
fs=16;

figure;
plot(lx,lbz,'k','LineWidth',lw);
xlabel('X [c/\omega{pi}]');
ylabel('B_z');

figure;
subplot(3,1,1);
plot(lx,lvix,'r','LineWidth',lw); hold on
plot(lx,lviy,'g','LineWidth',lw);
plot(lx,lviz,'b','LineWidth',lw);
plot(lx,lvi,'k','LineWidth',lw); hold off
xlabel('X [c/\omega{pi}]');
ylabel('V_i');
legend('Vi_x','Vi_y','Vi_z','Vi');

subplot(3,1,2);
plot(lx,lvex,'r','LineWidth',lw); hold on
plot(lx,lvey,'g','LineWidth',lw);
plot(lx,lvez,'b','LineWidth',lw);
plot(lx,lve,'k','LineWidth',lw); hold off
xlabel('X [c/\omega{pi}]');
ylabel('V_e');
legend('Ve_x','Ve_y','Ve_z','Ve');

subplot(3,1,3)
plot(lx,lvi,'r','LineWidth',lw); hold on
plot(lx,lve,'k','LineWidth',lw); hold off
xlabel('X [c/\omega{pi}]');
ylabel('V');
legend('Vi','Ve');

figure;
plot(lx,lni,'r','LineWidth',lw); hold on
plot(lx,lne,'k','LineWidth',lw); hold off
xlabel('X [c/\omega{pi}]');
ylabel('N');
legend('Ni','Ne');

figure;
plot(lx,lki,'r','LineWidth',lw); hold on
plot(lx,lke,'k','LineWidth',lw); hold off
xlabel('X [c/\omega{pi}]');
ylabel('K');
legend('Ki','Ke');


cd(outdir);
