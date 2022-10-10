%% get the component of the generalized ohm's law
%%
clear
indir='E:\Simulation\rec2d_M100SBg00Sx\data';
outdir='E:\Simulation\rec2d_M100SBg00Sx\out\line\DF';
%%
tt=40;
nx=4800;
ny=2400;
di=40;
Lx=nx/di;
Ly=ny/di;
c=0.6;
norm=0.03;
% cut=30.7090;
cut=15;
dirt=0;
xrange=[0 Lx];
%%
cd(indir);
it=num2str(tt,'%3.3d');
% ohm=load(['ohmy_t',it,'.00.txt']);
ohm=read_data('ohmx',tt);

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

plot_line(ef,Lx,Ly,cut,norm,dirt,'k',1);
hold on
plot_line(evbi,Lx,Ly,cut,norm,dirt,'r');
plot_line(evbe,Lx,Ly,cut,norm,dirt,'b');
plot_line(dv,Lx,Ly,cut,norm,dirt,'g');
plot_line(dp,Lx,Ly,cut,norm,dirt,'m');
xlim(xrange)
legend('Electric field','Frozen-in term','Hall term','Pressure gradient term','Electron inertia term','location','best');
% legend('Electric field','Ion frozen-in term','Electron inertia term','Hall term','Pressure gradient term','location','best');

cd(outdir);
