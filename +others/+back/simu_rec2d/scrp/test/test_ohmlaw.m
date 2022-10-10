%% get the component of the generalized ohm's law
%%

clear
indir='E:\Simulation\Test_Asy\rec2d_B1.5T06Bs6Bg00\data';
outdir='E:\Simulation\Test_Asy\rec2d_B1.5T06Bs6Bg00\out';
%%
tt=15;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;

nx=ndx;
ny=ndy;

wci=0.000750;

norm=wci*di;
cut=90;
dirt=1;

%%
cd(indir);
it=num2str(tt,'%3.3d');
ohm=load(['ohmy_t',it,'.00.txt']);
% ohm=read_data('ohmx',tt);

xrange=[-Ly/2,Ly/2];

ef=ohm(:,1);
evbi=ohm(:,2);
evbe=ohm(:,3);
dv=ohm(:,4);
dp=ohm(:,5);
%%
ef=reshape(ef,nx,ny);
ef=ef';
evbi=reshape(evbi,nx,ny);
evbi=evbi';
evbe=reshape(evbe,nx,ny);
evbe=evbe';
dv=reshape(dv,nx,ny);
dv=dv';
dp=reshape(dp,nx,ny);
dp=dp';

%{
aa=ef-evbi;
bb=ef-evbe;
cc=evbe+dp+dv;
jxb=-evbi+evbe;
%}
evbe=evbe-evbi;

ef=simu_filter2d(ef);
evbi=simu_filter2d(evbi);
evbe=simu_filter2d(evbe);
dv=simu_filter2d(dv);
dp=simu_filter2d(dp);

%}
plot_line(ef,Lx,Ly,cut,norm,dirt,'k',1);
hold on
plot_line(evbi,Lx,Ly,cut,norm,dirt,'r');
plot_line(evbe,Lx,Ly,cut,norm,dirt,'g');
plot_line(dv,Lx,Ly,cut,norm,dirt,'b');
plot_line(dp,Lx,Ly,cut,norm,dirt,'m');
xlim(xrange);
legend('Electric field','Frozen-in term','Hall term','Pressure gradient term','Electron inertia term','location','best');
% legend('Electric field','Ion frozen-in term','Electron inertia term','Hall term','Pressure gradient term','location','best');
cd(outdir);
