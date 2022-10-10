% function check_neutrality(indir, outdir)
%%
% @info: writen by Liangjin Song on 20210811
% @brief: check plasma neutrality for the asymmetric reconnection model with cold ions (asym_rec_slj)
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

%% data
Ni=prm.read('Ni',tt);
Ne=prm.read('Ne',tt);

%% get line
l.ni=Ni.get_line2d(z0,dir,prm,1)/prm.value.coeff;
l.ne=Ne.get_line2d(z0,dir,prm,1)/prm.value.coeff;

%% plot figure
extra.legend={'Ni','Ne'};
extra.LineStyle={'-','--'};
extra.LineColor={'k','b'};
extra.ylabel='N';
extra.xlabel='Z [c/\omega_{pi}]';
extra.LineWidth=2;
f=slj.Plot;
f.linen(prm.value.lz,l,extra);
cd(outdir);
print('-dpng','-r300','Ni-Ne.png')
close(gcf);