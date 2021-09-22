% function plot_momentum_equation
clear;
%% parameters
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Momentum';
prm=slj.Parameters(indir,outdir);

tt=100;
dt=1;
name='l';

q=prm.value.qi;
m=prm.value.mi;

norm=prm.value.vA;
xz=50;
dir=1;

%% momentum equation
E=prm.read('E',tt);

[vxB, dP, vv] = slj.Physics.momentum_equation(prm, name, tt);
divP.x=dP.x/q;
divP.y=dP.y/q;
divP.z=dP.z/q;
divP=slj.Vector(divP);

vdv.x=vv.x*m/q;
vdv.y=vv.y*m/q;
vdv.z=vv.z*m/q;
vdv=slj.Vector(vdv);

V1=prm.read(['V',name],tt-dt);
V2=prm.read(['V',name],tt+dt);
N1=prm.read(['N',name],tt-dt);
N2=prm.read(['N',name],tt+dt);
Vt.x=(V2.x.*N2.value-V1.x.*N1.value)*prm.value.wci/2;
Vt.y=(V2.y.*N2.value-V1.y.*N1.value)*prm.value.wci/2;
Vt.z=(V2.z.*N2.value-V1.z.*N1.value)*prm.value.wci/2;
Vt.x=(m/q)*Vt.x./N;
Vt.y=(m/q)*Vt.y./N;
Vt.z=(m/q)*Vt.z./N;
Vt=slj.Vector(Vt);

%% get the line
eee=E.get_line2d(xz, dir, prm, norm);
vxb=vxB.get_line2d(xz, dir, prm, norm);
dvp=divP.get_line2d(xz, dir, prm, norm);
vdv=vdv.get_line2d(xz, dir, prm, norm);
vpt=Vt.get_line2d(xz, dir, prm, norm);

%% figure
ll=prm.value.lz;
figure;
plot(ll,eee.ly,'--k','LineWidth',2); hold on
plot(ll,vxb.ly,'-r','LineWidth',2);
plot(ll,dvp.ly,'-g','LineWidth',2);
plot(ll,vdv.ly,'-b','LineWidth',2);
plot(ll,vpt.ly,'-m','LineWidth',2); hold off
