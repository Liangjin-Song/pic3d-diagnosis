%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot the density flux as the function of time
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt=26;
dt=0.1;
name='h';

xz=20;
dd = 40;
dir=1;
cmpt = 'z';

nm = 10;

%% figure proterty
xrange=[-4,3];

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

norm = prm.value.qi*prm.value.n0*prm.value.vA;

%% calculation
[qNE, divP, pVt, NVV, qVB] = slj.Physics.momentum_equation_electric_force_density(prm, name, tt, dt, q, m);

if cmpt == 'x'
    qNE = qNE.x;
    divP = divP.x;
    pVt = pVt.x;
    NVV = NVV.x;
    qVB = qVB.x;
elseif cmpt == 'y'
    qNE = qNE.y;
    divP = divP.y;
    pVt = pVt.y;
    NVV = NVV.y;
    qVB = qVB.y;
elseif cmpt == 'z'
    qNE = qNE.z;
    divP = divP.z;
    pVt = pVt.z;
    NVV = NVV.z;
    qVB = qVB.z;
else
    error('Parameters error!');
end

N = prm.read(['N',name], tt);
N = q.*N.value;
qNE = qNE./N;
divP = divP./N;
pVt = pVt./N;
NVV = NVV./N;
qVB = qVB./N;

if dir == 0
    sdir = 'x';
    xlab = 'X [c/\omega_{pi}]';
    ll = prm.value.lx;
    lp = prm.value.lz;
    [~, xz] = min(abs(prm.value.lz - xz));
    lqNE = mean(qNE(xz-dd:xz+dd, :), 1);
    ldivP = mean(divP(xz-dd:xz+dd, :), 1);
    lpVt = mean(pVt(xz-dd:xz+dd, :), 1);
    lNVV = mean(NVV(xz-dd:xz+dd, :), 1);
    lqVB = mean(qVB(xz-dd:xz+dd, :), 1);
elseif dir == 1
    sdir = 'z';
    xlab = 'Z [c/\omega_{pi}]';
    ll = prm.value.lz;
    lp = prm.value.lx;
    [~, xz] = min(abs(prm.value.lx - xz));
    lqNE = mean(qNE(:, xz-dd:xz+dd), 2);
    ldivP = mean(divP(:, xz-dd:xz+dd), 2);
    lpVt = mean(pVt(:, xz-dd:xz+dd), 2);
    lNVV = mean(NVV(:, xz-dd:xz+dd), 2);
    lqVB = mean(qVB(:, xz-dd:xz+dd), 2);
else
    error('Parameters error!');
end

lqNE = smoothdata(lqNE, 'movmean', nm)/norm;
ldivP = smoothdata(ldivP, 'movmean', nm)/norm;
lpVt = smoothdata(lpVt, 'movmean', nm)/norm;
lNVV = smoothdata(lNVV, 'movmean', nm)/norm;
lqVB = smoothdata(lqVB, 'movmean', nm)/norm;

ltot = ldivP + lpVt + lNVV + lqVB;

%% figure
figure;
plot(ll, lqNE, '-k', 'LineWidth', 2);
hold on
plot(ll, ldivP, '-r', 'LineWidth', 2);
plot(ll, lpVt, '-g', 'LineWidth', 2);
plot(ll, lNVV, '-b', 'LineWidth', 2);
plot(ll, lqVB, '-m', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);
legend('E', '\nabla\cdot P/qN', '(m/q)\partial V/\partial t', '(m/q)(V\cdot\nabla)V','-V\times B','Sum', 'Location', 'Best', 'Box', 'off');
xlim(xrange);
ylabel(['E_', cmpt]);
xlabel(xlab);
set(gca,'FontSize',14);

cd(outdir);
% print('-dpng','-r300',[sfx,'_momentum_equation_electric_force_density_',cmpt,'_t=',num2str(tt, '%06.2f'),'_',sdir,'=',num2str(round(lp(xz))),'.png']);
