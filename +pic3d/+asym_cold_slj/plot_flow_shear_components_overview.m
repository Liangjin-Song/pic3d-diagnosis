%% plot the flow shear components 
% clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt=40;
name='h';
cmpt = 'zx';

norm = 1;

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.Visible=true;


%% read data
cd(indir);
V = prm.read(['V',name], tt);
ss= prm.read('stream', tt);

if cmpt(1) == 'x'
    V = slj.Scalar(V.x);
elseif cmpt(1) == 'y'
    V = slj.Scalar(V.y);
else
    V = slj.Scalar(V.z);
end

V = V.gradient(prm);

if cmpt(2) == 'x'
    V = slj.Scalar(V.x);
elseif cmpt(2) == 'y'
    V = slj.Scalar(V.y);
else
    V = slj.Scalar(V.z);
end




figure;
slj.Plot.overview(V, ss, prm.value.lx, prm.value.lz, norm, extra);
title(['\partialV',cmpt(1),'/\partial',cmpt(2), ', \Omega_{ci}t=',num2str(tt)]);


xz=-2;
dir = 0;
lv=V.get_line2d(xz,dir,prm,norm);
figure;
plot(prm.value.lx, lv, '-k', 'LineWidth', 1.5);
xlim([-10,10]);
xlabel('Z [c/\omega_{pi}]');

cd(outdir);