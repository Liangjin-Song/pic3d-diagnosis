% function plot_energy_spectrum()
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Spectrum';
prm=slj.Parameters(indir,outdir);
%% the time of the energy spectrum
tt = [0, 100];

izero=145;
xrange=[-5,1];
%% species
name='e';

if name == 'h'
    sfx='ic';
    m=prm.value.mi;
elseif name == 'l'
    sfx='ih';
    m=prm.value.mi;
elseif name == 'e'
    sfx='e';
    m=prm.value.me;
end

%% X range
xx = linspace(-20,20,401);
xx = 10.^xx;
xx = xx*((m/prm.value.mi)*(prm.value.c/prm.value.vA).^2);

%% read data
nt = length(tt);
lnsty = {'-k', '-r', '-b', '-g', '-m', '--k', '--r', '--b', '--g', '--m'};
lgd={};
for t = 1:nt
    spm=prm.read(['spctrm',name],tt(t));
    spm(1:izero)=0;
    loglog(xx, spm, char(lnsty(t)), 'LineWidth', 1.5); hold on
    lgd{end+1} = ['\Omega_{ci}t = ', num2str(tt(t))];
end
hold off;

legend(lgd);
% legend(['\Omega_{ci}t = ', num2str(tt(1))], ['\Omega_{ci}t = ', num2str(tt(2))], ['\Omega_{ci}t = ', num2str(tt(3))], ['\Omega_{ci}t = ', num2str(tt(4))], ['\Omega_{ci}t = ', num2str(tt(5))])
% xlim([10^xrange(1),10^xrange(2)]);
xlabel(['E_{', sfx, '} [m_iv_A^2]']);
ylabel(['f_{', sfx, '}']);
% title(['\Omega_{ci}t = ', num2str(tt1)]);
set(gca,'FontSize', 12);