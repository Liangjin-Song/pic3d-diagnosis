%%
% the continuity equation
%%
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Tmp';
prm=slj.Parameters(indir,outdir);

name='h';

tt=30;
dt=0.5;

dir=1;
xz=1441;
dx = 50;

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

norm=2*dt*prm.value.wci*prm.value.n0;

%% calculation
[pNt, divNV] = slj.Physics.continuity_equation(prm, name, tt, dt);


%% get line
% lpkt=pKt.get_line2d(xz,dir,prm,norm);
% ldivKV=divKV.get_line2d(xz,dir,prm,norm);
% lqVE=qVE.get_line2d(xz,dir,prm,norm);
% ldivPV=divPV.get_line2d(xz,dir,prm,norm);

lpnt = mean(pNt.value(:, xz-dx:xz+dx), 2)/norm;
ldivNV = mean(divNV.value(:, xz-dx:xz+dx),2)/norm;

%% smooth
lpnt = smoothdata(lpnt, 'movmean', 20);
ldivNV = smoothdata(ldivNV, 'movmean', 20);

%% plot figure
plot(ll, lpnt, '-r', 'LineWidth', 2); hold on
plot(ll, ldivNV, '-b', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial N/\partial t', '\nabla\cdot(NV)', 'Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial N',sfx,'/\partial t']);
% title(['\Omega_{ci}t = ',num2str(tt),', profiles  ', pstr,' = ',num2str(xz)]);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_continuity_equation_t',num2str(tt),'_line_',pstr,'=',num2str(xz),'.png']);
% close(gcf);



% end

