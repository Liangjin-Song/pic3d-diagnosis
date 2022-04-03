%% plot the Hall term components
% written by Liangjin Song on 20220401 at Nanchang University
%%
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Ohm';
prm=slj.Parameters(indir,outdir);

tt=40;
dt=0.5;

xz=28;
dir=1;

ll=prm.value.lz;

norm=prm.value.qi*prm.value.n0*prm.value.vA;

%% read data
J=prm.read('J',tt);
B=prm.read('B',tt);

%% calculation
JB.x=(-B.y.*J.z+B.z.*J.y);
JB.y=(-B.z.*J.x+B.x.*J.z);
JB.z=(-B.x.*J.y+B.y.*J.x);
JB = slj.Vector(JB);

%% get line
ljb=JB.get_line2d(xz, dir, prm, norm);

%% plot figure
f=figure;
plot(ll, ljb.lx, '-r', 'LineWidth', 2);
hold on
plot(ll, ljb.ly, '-b', 'LineWidth', 2);
plot(ll, ljb.lz, '-g', 'LineWidth', 2);
xlim([-5,5]);
xlabel('Z [c/\omega_{pi}]');
ylabel('JxB')
legend('x', 'y', 'z');
set(gca,'FontSize', 14);