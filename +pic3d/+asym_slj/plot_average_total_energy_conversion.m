%% plot the average total energy conversion profiles
% written by Liangjin Song on 20220412 at Nanchang University
%%
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Tmp';
prm=slj.Parameters(indir,outdir);

tt=33;
dt=0.5;
name='h';

% xz=16;
dir=1;
xz=641;
dx = 20;

nt=length(tt);

xrange=[-5,5];

if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tlm;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.thm;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.tem;
else
    error('Parameters Error!');
end

norm=2*dt*prm.value.wci*tm/prm.value.coeff;

%% calculation
[pAt, qVE, VdA, divF] = slj.Physics.average_total_energy_conversion(prm, name, tt, dt, q, m);

%% obtain the line
lpAt = mean(pAt.value(:, xz-dx:xz+dx), 2)/norm;
lqVE = mean(qVE.value(:, xz-dx:xz+dx),2)/norm;
lVdA = mean(VdA.value(:, xz-dx:xz+dx),2)/norm;
ldivF = mean(divF.value(:, xz-dx:xz+dx),2)/norm;

%% smooth
lpAt = smoothdata(lpAt, 'movmean', 10);
lqVE = smoothdata(lqVE, 'movmean', 10);
lVdA = smoothdata(lVdA, 'movmean', 10);
ldivF = smoothdata(ldivF, 'movmean', 13);

ltot = lqVE + lVdA + ldivF;

%% figure
figure;
plot(ll, lqVE, '-b', 'LineWidth', 2);
hold on
plot(ll, lVdA, '-g', 'LineWidth', 2);
plot(ll, ldivF, '-r', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);
plot(ll, lpAt, '-k', 'LineWidth', 2);
hold off

%%
xlim(xrange);
legend('qV\cdot E', '-V\cdot \nabla A', '-1/N*\nabla \cdot (Q + P\cdot V)', 'Sum', '\partial [(K+U)/N]/\partial t');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial [(K',sfx,'+U',sfx,')/N]/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_average_total_energy_t',num2str(tt),'_line_', pstr,' = ',num2str(xz),'.png']);
