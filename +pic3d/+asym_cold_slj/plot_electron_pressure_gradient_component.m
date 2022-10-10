%% plot the electron pressure gradient term components
% written by Liangjin Song on 20220401 at Nanchang University
%%
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Ohm';
prm=slj.Parameters(indir,outdir);

tt=40;
dt=0.5;

xz=22;
dir=1;

ll=prm.value.lz;

norm=prm.value.qi*prm.value.n0*prm.value.vA;

%% read data
P=prm.read('Pe',tt);

%% calculation
q=prm.value.qe;
dP=P.divergence(prm);

dPxx=slj.Scalar(P.xx);
dPxx=dPxx.gradient(prm);

dPxz=slj.Scalar(P.xz);
dPxz=dPxz.gradient(prm);

%% get line
ldp=dP.get_line2d(xz, dir, prm, norm);
ldp.lx=smoothdata(ldp.lx,'movmean',5);
ldp.ly=smoothdata(ldp.ly,'movmean',5);
ldp.lz=smoothdata(ldp.lz,'movmean',5);


ldpxx=dPxx.get_line2d(xz, dir, prm, norm);
ldpxx.lx=smoothdata(ldpxx.lx,'movmean',15);
ldpxx.ly=smoothdata(ldpxx.ly,'movmean',15);
ldpxx.lz=smoothdata(ldpxx.lz,'movmean',15);
ldpxz=dPxz.get_line2d(xz, dir, prm, norm);
ldpxz.lx=smoothdata(ldpxz.lx,'movmean',15);
ldpxz.ly=smoothdata(ldpxz.ly,'movmean',15);
ldpxz.lz=smoothdata(ldpxz.lz,'movmean',15);


%% plot figure
f=figure;
hold on
plot(ll, ldpxx.lx, '-r', 'LineWidth', 2);
plot(ll, ldpxz.lz, '-b', 'LineWidth', 2);
xlim([-5,5]);
xlabel('Z [c/\omega_{pi}]');
ylabel('(\nabla\cdot P_e)_x');
legend('\partial Pxx/\partial x', '\partial Pxz/\partial z');
set(gca,'FontSize', 14);
