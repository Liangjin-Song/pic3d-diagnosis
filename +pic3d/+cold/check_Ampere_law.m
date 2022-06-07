% function check_Ampere_law(indir,outdir)
%%
% @info: writen by Liangjin Song on 20210802
% @brief: check Ampere law for the asymmetric reconnection model with cold ions (asym_rec_slj)
%%
clear;
%% parameters
indir='E:\Simulation\Cold\Data';
outdir='E:\Simulation\Cold\Out\Global';
prm=slj.Parameters(indir,outdir);
% time
tt=0;

% line position
z0=15;
dir=1;

%% figure style
extra.xrange=[prm.value.lz(1),prm.value.lz(end)];

%% read data
Js=prm.read('J',tt);
B=prm.read('B',tt);
Vl=prm.read('Vl',tt); 
Vh=prm.read('Vh',tt);
Ve=prm.read('Ve',tt);
Vhe=prm.read('Vhe',tt);
Nl=prm.read('Nl',tt);
Nh=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);
Nhe=prm.read('Nhe',tt);

%% current calculated by the magnetic curl
Jc=B.curl(prm);
Jc=Jc.normalize(1/(prm.value.c*prm.value.c));

%% plasma current density
Jpl=(Nl*prm.value.ql)*Vl;
Jph=(Nh*prm.value.qh)*Vh;
Jpe=(Ne*prm.value.qe)*Ve;
Jphe=(Nhe*prm.value.qe)*Vhe;
Jpe = Jpe + Jphe;
Jp=Jpl+Jph+Jpe;

%% get the line
ljs=Js.get_line2d(z0,dir,prm,1);
ljc=Jc.get_line2d(z0,dir,prm,1);
ljp=Jp.get_line2d(z0,dir,prm,1);
ljl=Jpl.get_line2d(z0,dir,prm,1);
ljh=Jph.get_line2d(z0,dir,prm,1);
lje=Jpe.get_line2d(z0,dir,prm,1);

%% plot figure
% Jy for Jp, Jc, Js
ll.ljs=ljs.ly;
ll.ljp=ljp.ly;
ll.ljc=ljc.ly;
extra.LineStyle={'-','-.','--'};
extra.LineColor={'r','k','b'};
extra.legend={'Js','Jp','Jc'};
extra.ylabel='Jy';
extra.xlabel='Z [c/\omega_{pi}]';
extra.FontSize=16;
f=slj.Plot;
f.linen(prm.value.lz,ll,extra);
f.png(prm,['Jy_x=',num2str(z0),'_t',num2str(tt,'%06.2f')]);

% Jy for Jl, Jh, and Je
ll=[];
ll.ljl=ljl.ly;
ll.ljh=ljh.ly;
ll.lje=lje.ly;
extra.legend={'Ji','Jic','Je'};
f=slj.Plot;
f.linen(prm.value.lz,ll,extra);
f.png(prm,['Jpy_x=',num2str(z0),'_t',num2str(tt,'%06.2f')]);