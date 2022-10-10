%% plot the total energy conversion profiles
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

norm=2*dt*prm.value.wci*prm.value.n0*tm/prm.value.coeff;

%% calculation
[pTt, divF, qVE] = slj.Physics.total_energy_conversion(prm, name, tt, dt, q, m);


%% obtain the line
lpTt = mean(pTt.value(:, xz-dx:xz+dx), 2)/norm;
ldivF = mean(divF.value(:, xz-dx:xz+dx),2)/norm;
lqVE = mean(qVE.value(:, xz-dx:xz+dx),2)/norm;

%% smooth
% lpTt = smoothdata(lpTt, 'movmean', 10);
ldivF = smoothdata(ldivF, 'movmean', 13);
% lqVE = smoothdata(lqVE, 'movmean', 10);

ltot = ldivF + lqVE;


%% plot figure
figure;
plot(ll, ldivF, '-r', 'LineWidth', 2);
hold on
plot(ll, lqVE, '-b', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);
plot(ll, lpTt, '-k', 'LineWidth', 2);
hold off

%% set figure
xlim(xrange);
legend('-\nabla \cdot (KV + Q + H)', 'qNV\cdot E', 'Sum', '\partial (K + U)/\partial t');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial (K',sfx,'+U',sfx,')/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_total_energy_t',num2str(tt),'_line_', pstr,' = ',num2str(xz),'.png']);

