function plot_ampere_law()
%%
% @info: writen by Liangjin Song on 20210611
% @brief: check the ampere law
%%
%% parameters
% input/output directory
indir='E:\PIC\Asym';
outdir='E:\PIC\Asym';
prm=slj.Parameters(indir,outdir);
% time
tt=0;
% normalization
norm=prm.value.qi*(prm.value.ntm+prm.value.nts)*0.5*prm.value.vA;
% profile position and direction
x0=5;
dir=1;
% figure property
extra.LineWidth=2;
extra.xrange=[prm.value.lz(1),prm.value.lz(end)];
extra.xlabel='Z [c/\omega_{pi}]';
extra.ylabel='J';
%% read data
% plasma
Nshi=prm.read('Nshi',tt);
Nshe=prm.read('Nshe',tt);
Nspi=prm.read('Nspi',tt);
Nspe=prm.read('Nspe',tt);
Nsph=prm.read('Nsph',tt);
Nsphe=prm.read('Nsphe',tt);
Vshi=prm.read('Vshi',tt);
Vshe=prm.read('Vshe',tt);
Vspi=prm.read('Vspi',tt);
Vspe=prm.read('Vspe',tt);
Vsph=prm.read('Vsph',tt);
Vsphe=prm.read('Vsphe',tt);
% current
Js=prm.read('J',tt);
% magnetic field
B=prm.read('B',tt);
%% calculate the plasma current sheet
Jsh=Vshi*Nshi*prm.value.qi+Vshe*Nshe*prm.value.qe;
Jsp=Vspi*Nspi*prm.value.qi+Vspe*Nspe*prm.value.qe;
Jspic=Vsph*Nsph*prm.value.qi+Vsphe*Nsphe*prm.value.qe;
Jp=Jsh+Jsp+Jspic;
%% calculate the current sheet by magnetic field
