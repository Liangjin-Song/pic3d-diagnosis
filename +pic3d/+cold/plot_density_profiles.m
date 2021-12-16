% function plot_density_profiles
%% plot the cold ions density profiles
% clear;
%% parameters 
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out';
prm=slj.Parameters(indir,outdir);
name='Nl';
tt1=16;
tt2=26;
tt3=44;
tt4=46;
xz=0;
dir=0;
extra.xlabel='Z [c/\omega_{pi}]';
extra.ylabel='N_{ic}';
extra.xrange=[50,100];
extra.LineStyle={'-','-','-','-'};
extra.LineColor={'g','r','k','b'};
extra.legend={['\Omega_{ci}t=',num2str(tt1)],['\Omega_{ci}t=',num2str(tt2)],['\Omega_{ci}t=',num2str(tt3)],['\Omega_{ci}t=',num2str(tt4)]};

%% read data
N1=prm.read(name,tt1);
N2=prm.read(name,tt2);
N3=prm.read(name,tt3);
N4=prm.read(name,tt4);
N1=N1.filter2d(3);
N2=N2.filter2d(3);
N3=N3.filter2d(3);
N4=N4.filter2d(3);

%% get the line
ln.l1=N1.get_line2d(xz, dir, prm, prm.value.n0);
ln.l2=N2.get_line2d(xz, dir, prm, prm.value.n0);
ln.l3=N3.get_line2d(xz, dir, prm, prm.value.n0);
ln.l4=N4.get_line2d(xz, dir, prm, prm.value.n0);
if dir==1
    ll=prm.value.lz;
else
    ll=prm.value.lx;
end
f=slj.Plot();
f.linen(ll, ln, extra);
% f.png(prm,'Nic_t13-16_cross_x-line');
% f.close();