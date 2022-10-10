% function plot_kinetic_energy_conversion
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Tmp';
prm=slj.Parameters(indir,outdir);

tt=32;
dt=0.5;
name='h';

% xz=16;
dir=1;
xz=1361;
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

% norm=1;
norm=2*dt*prm.value.wci*prm.value.n0*tm/prm.value.coeff;


%% calculation
[pUt, divPV, divQ, divH]= slj.Physics.thermal_energy_conversion(prm, name, tt, dt);

%% get line
% lput=pUt.get_line2d(xz,dir,prm,norm);
% ldivPV=divPV.get_line2d(xz,dir,prm,norm);
% ldivQ=divQ.get_line2d(xz, dir, prm,norm);
% ldivH=divH.get_line2d(xz, dir, prm,norm);
lput = mean(pUt.value(:, xz-dx:xz+dx), 2)/norm;
ldivPV = mean(divPV.value(:, xz-dx:xz+dx),2)/norm;
ldivQ = mean(divQ.value(:, xz-dx:xz+dx),2)/norm;
ldivH = mean(divH.value(:, xz-dx:xz+dx), 2)/norm;


%% smooth
lput = smoothdata(lput, 'movmean', 10);
ldivPV = smoothdata(ldivPV, 'movmean', 10);
ldivQ = smoothdata(ldivQ, 'movmean', 10);
ldivH = smoothdata(ldivH, 'movmean', 20);

ltot = ldivPV + ldivQ + ldivH;

%% plot figure
figure;
plot(ll, lput, '-k', 'LineWidth', 2); hold on
plot(ll, ldivPV, '-r', 'LineWidth', 2);
plot(ll, ldivQ, '-b', 'LineWidth', 2);
plot(ll, ldivH, '-m', 'LineWidth', 2);
plot(ll, ltot, '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial U/\partial t', '(\nabla\cdot P) \cdot V', '-\nabla \cdot Q', '- \nabla \cdot (UV + P\cdot V)', 'Sum', 'Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['\partial U',sfx,'/\partial t']);
% title(['profiles  ', pstr,' = ',num2str(xz)]);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_thermal_energy_t',num2str(tt),'_line_', pstr,' = ',num2str(xz),'.png']);
% close(gcf);



% end
