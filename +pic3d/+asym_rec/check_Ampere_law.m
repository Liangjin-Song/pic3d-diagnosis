% function check_Ampere_law(indir,outdir)
%%
% @info: writen by Liangjin Song on 20210802
% @brief: check Ampere law for the asymmetric reconnection model with cold ions (asym_rec_slj)
%%
clear;
%% parameters
indir='E:\Simulation\Test';
outdir='E:\Simulation\Test';
prm=slj.Parameters(indir,outdir);
% time
tt=0;

% line position
z0=5;
dir=1;

%% figure style
extra.xrange=[prm.value.lz(1),prm.value.lz(end)];

%% read data
Js=prm.read('J',tt);
B=prm.read('B',tt);
Vi=prm.read('Vi',tt); 
Ve=prm.read('Ve',tt);
Ni=prm.read('Ni',tt);
Ne=prm.read('Ne',tt);

%% current calculated by the magnetic curl
Jc=B.curl(prm);
Jc=Jc.normalize(1/(prm.value.c*prm.value.c));

%% plasma current density
Jpi=(Ni*prm.value.qi)*Vi;
Jpe=(Ne*prm.value.qe)*Ve;
Jp=Jpi+Jpe;

%% get the line
ljs=Js.get_line2d(z0,dir,prm,1);
ljc=Jc.get_line2d(z0,dir,prm,1);
ljp=Jp.get_line2d(z0,dir,prm,1);
lji=Jpi.get_line2d(z0,dir,prm,1);
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
ll.ljl=lji.ly;
ll.lje=lje.ly;
ll.ljp=lji.ly+lje.ly;
extra.legend={'Ji','Je', 'Jp'};
extra.LineStyle={'-','-.','-'};
extra.LineColor={'r','b','k'};
f=slj.Plot;
f.linen(prm.value.lz,ll,extra);
f.png(prm,['Jpy_x=',num2str(z0),'_t',num2str(tt,'%06.2f')]);