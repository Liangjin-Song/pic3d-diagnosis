%% plot the pressure components
%% written by Liangjin Song on 20220829
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt=40;
name='h';
cmpt = 'yy';

norm = 1;

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.Visible=true;

%% read data
cd(indir);
P = prm.read(['P',name], tt);
ss= prm.read('stream', tt);

if strcmp(cmpt, 'xx')
    P = P.xx;
elseif strcmp(cmpt, 'xy')
    P = P.xy;
elseif strcmp(cmpt, 'xz')
    P = P.xz;
elseif strcmp(cmpt, 'yy')
    P = P.yy;
elseif strcmp(cmpt, 'yz')
    P = P.yz;
else
    P = P.zz;
end
P = slj.Scalar(P);

%5 plot figure
figure;
slj.Plot.overview(P, ss, prm.value.lx, prm.value.lz, norm, extra);
title(['P',cmpt,', \Omega_{ci}t=',num2str(tt)]);


xz=10;
dir = 1;
lp=P.get_line2d(xz,dir,prm,norm);
figure;
plot(prm.value.lz, lp, '-k', 'LineWidth', 1.5);
xlim([-10,10]);
xlabel('Z [c/\omega_{pi}]');

cd(outdir);