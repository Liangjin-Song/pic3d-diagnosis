%% get the component of the generalized ohm's law
%%
clear
indir='/data/simulation/test/symmetric/data/';
outdir='/data/simulation/test/symmetric/out/';
%%
tt=20;
nx=640;
ny=640;
di=40;
Lx=1280/di;
Ly=1280/di;
norm=0.02;
cut=25;
dirt=1;
xrange=[16,32];
%%
cd(indir);
it=num2str(tt,'%3.3d');
ohm=load(['ohmz_t',it,'.00.txt']);

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


plot_line(ef,Lx,Ly,cut,norm,dirt,'k',1);
hold on
plot_line(evbi,Lx,Ly,cut,norm,dirt,'r');
plot_line(evbe,Lx,Ly,cut,norm,dirt,'b');
plot_line(dv,Lx,Ly,cut,norm,dirt,'g');
plot_line(dp,Lx,Ly,cut,norm,dirt,'m');
xlim(xrange);
legend('Electric field','Frozen-in term','Hall term','Pressure gradient term','Electron inertia term','location','best');
% legend('Electric field','Ion frozen-in term','Electron inertia term','Hall term','Pressure gradient term','location','best');
cd(outdir);
