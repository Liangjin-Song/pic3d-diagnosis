% function plot_density_current_profiles
%% plot the density and current profiles
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\model';
prm=slj.Parameters(indir,outdir);

%% time
tt=0;

%% line position
xz=10;
dir=1;

%% properties of figures
extra.xlabel='Z [c/\omega_{pi}]';
extra.title='\Omega_{ci}t=0';

%% read data
Ni=prm.read('Nl',tt);
Nic=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
Nice=prm.read('Nhe',tt);
Vi=prm.read('Vl',tt);
Vic=prm.read('Vh',tt);
Ve=prm.read('Ve',tt);
Vice=prm.read('Vhe',tt);

%% the calculation of current density
Ji=prm.value.qi*Ni*Vi;
Jic=prm.value.qi*Nic*Vic;
Je=prm.value.qe*Ne*Ve;
Jice=prm.value.qe*Nice*Vice;

%% density profiles
Ne=Ne+Nice;
ln.l1=Ni.get_line2d(xz, dir, prm, prm.value.n0);
ln.l2=Nic.get_line2d(xz, dir, prm, prm.value.n0);
ln.l3=Ne.get_line2d(xz, dir, prm, prm.value.n0);
ln.l4=ln.l1+ln.l2;
ll=prm.value.lz;
%% figure properties
extra.ylabel='plasma density';
extra.xrange=[ll(1),ll(end)];
extra.LineStyle={'-','-','-','--'};
extra.LineColor={'b','r','k','g'};
extra.legend={'Ni','N_{ic}','Ne','Ni+N_{ic}'};
%%
f=slj.Plot();
f.linen(ll, ln, extra);
f.png(prm,'plasma_density');
f.close();

%% current density profile
norm=prm.value.qi*prm.value.n0*prm.value.vA;
ji=Ji.get_line2d(xz, dir, prm, norm);
jic=Jic.get_line2d(xz, dir, prm, norm);
je=Je.get_line2d(xz, dir, prm, norm);
jice=Jice.get_line2d(xz, dir, prm, norm);
ln.l1=ji.ly;
ln.l2=jic.ly;
ln.l3=je.ly+jice.ly;
ln.l4=ln.l1+ln.l2+ln.l3;
ln.l2=ln.l3;
ln.l3=ln.l4;
ln.l4=jic.ly;
%% figure properties
extra.ylabel='J_y';
extra.xrange=[ll(1),ll(end)];
extra.LineStyle={'-','-','-','-'};
extra.LineColor={'b','r','g','k'};
extra.legend={'Ji','J_e','Sum','J_{ic}'};
%%
f=slj.Plot();
f.linen(ll, ln, extra);
f.png(prm,'Jy');
f.close();