% function check_neutrality(indir, outdir)
%%
% @info: writen by Liangjin Song on 20210811
% @brief: check plasma neutrality for the asymmetric reconnection model with cold ions (asym_rec_slj)
%%
% clear;
%% parameters
indir='E:\Asym\asym_cold_Nr2\data';
outdir='E:\Asym\asym_cold_Nr2\out\Global';
prm=slj.Parameters(indir,outdir);
% time
tt=0;

% line position
z0=5;
dir=1;

%% figure style
extra.xrange=[prm.value.lz(1),prm.value.lz(end)];

%% data
Nl=prm.read('Nl',tt);
Nh=prm.read('Nh',tt);
Ne=prm.read('Ne',tt);

%% get line
l.nl=Nl.get_line2d(z0,dir,prm,1);
l.nh=Nh.get_line2d(z0,dir,prm,1);
l.ne=Ne.get_line2d(z0,dir,prm,1);
l.tot=l.nl+l.nh;

%% plot figure
extra.legend={'Ni','Nic','Ne','Ni+Nic'};
extra.LineStyle={'--','-.','-','--'};
extra.LineColor={'r','g','b','k'};
extra.ylabel='N';
extra.xlabel='Z [c/\omega_{pi}]';
f=slj.Plot;
f.linen(prm.value.lz,l,extra);
f.png(prm,['N_x=',num2str(z0),'_t',num2str(tt,'%06.2f')]);