% function plot_kinetic_energy_conversion
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Tmp';
prm=slj.Parameters(indir,outdir);

name='h';

%{
tt=33;
dt=0.5;

dir=1;
xz=1441;
dx = 15;
%}

tt=52;
dt=1;

dir=1;
xz=1601;
dx = 15;





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
[pKt, divKV, qVE, divPV] = slj.Physics.kinetic_energy_conversion(prm, name, tt, dt, q, m);

%% get line
% lpkt=pKt.get_line2d(xz,dir,prm,norm);
% ldivKV=divKV.get_line2d(xz,dir,prm,norm);
% lqVE=qVE.get_line2d(xz,dir,prm,norm);
% ldivPV=divPV.get_line2d(xz,dir,prm,norm);

lpkt = mean(pKt.value(:, xz-dx:xz+dx), 2)/norm;
ldivKV = mean(divKV.value(:, xz-dx:xz+dx),2)/norm;
lqVE = mean(qVE.value(:, xz-dx:xz+dx),2)/norm;
ldivPV = mean(divPV.value(:, xz-dx:xz+dx), 2)/norm;

%% smooth
lpkt = smoothdata(lpkt, 'movmean', 20);
ldivKV = smoothdata(ldivKV, 'movmean', 20);
lqVE = smoothdata(lqVE, 'movmean', 20);
ldivPV = smoothdata(ldivPV, 'movmean', 20);

ltot=ldivKV + ldivPV + lqVE;

%% plot figure
plot(ll, lpkt, '-k', 'LineWidth', 2); hold on
plot(ll, ldivKV, '-b', 'LineWidth', 2);
plot(ll, lqVE, '-m', 'LineWidth', 2);
plot(ll, ldivPV, '-r', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial K/\partial t', '-\nabla\cdot(KV)', 'qNV\cdot E', '- (\nabla\cdot P) \cdot V', 'Sum', 'Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial K',sfx,'/\partial t']);
% title(['\Omega_{ci}t = ',num2str(tt),', profiles  ', pstr,' = ',num2str(xz)]);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
% print('-dpng','-r300',[sfx,'_bulk_kinetic_energy_t',num2str(tt),'_line_',pstr,'=',num2str(xz),'.png']);
% close(gcf);



% end