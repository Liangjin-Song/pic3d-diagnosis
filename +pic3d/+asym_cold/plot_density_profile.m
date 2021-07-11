function plot_density_profile()
%%
% @info: writen by Liangjin Song on 20210611
% @brief: plot_density_profile - plot the plasma density profile
%%
%% parameters
% input/output directory
indir='E:\PIC\Asym';
outdir='E:\PIC\Asym';
prm=slj.Parameters(indir,outdir);
% time
tt=0;
% normalization
norm=(prm.value.ntm+prm.value.nts)/2;
% profile position and direction
x0=5;
dir=1;
% figure property
extra.LineWidth=2;
extra.xrange=[prm.value.lz(1),prm.value.lz(end)];
extra.xlabel='Z [c/\omega_{pi}]';
extra.ylabel='N';
%% read data
Nshi=prm.read('Nshi',tt);
Nshe=prm.read('Nshe',tt);
Nspi=prm.read('Nspi',tt);
Nspe=prm.read('Nspe',tt);
Nsph=prm.read('Nsph',tt);
Nsphe=prm.read('Nsphe',tt);
%% get the profile
li.Nshi=Nshi.get_line2d(x0,dir,prm,norm);
le.Nshe=Nshe.get_line2d(x0,dir,prm,norm);
li.Nspi=Nspi.get_line2d(x0,dir,prm,norm);
le.Nspe=Nspe.get_line2d(x0,dir,prm,norm);
li.Nsph=Nsph.get_line2d(x0,dir,prm,norm);
le.Nsphe=Nsphe.get_line2d(x0,dir,prm,norm);
ll=prm.value.lz;
li.ss=li.Nshi+li.Nspi+li.Nsph;
le.ss=le.Nshe+le.Nspe+le.Nsphe;
%% plot the figure
% density profile
% the figure property
extra.LineStyle={'-','-','-','-'};
extra.LineColor={'r','g','b','k'};
extra.legend={'Nsh','Nsp','Nspic','Sum'};
fig=slj.Plot();
fig.linen(ll,li,extra);
fig.png(prm,'density_profile');
% ion density and electron density
extra.LineStyle={'-','-'};
extra.LineColor={'r','k'};
extra.legend={'Ni','Ne'};
ls.i=li.ss;
ls.e=le.ss;
fig=slj.Plot();
fig.linen(ll,ls,extra);
fig.png(prm,'Ni_Ne');
