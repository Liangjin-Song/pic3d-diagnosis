% function plot_energy_spectrum()
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Spectrum';
prm=slj.Parameters(indir,outdir);
%% the time of the energy spectrum
tt1=0;
tt2=20;
tt3=50;
tt4=80;
tt5=100;

izero=1;

xrange=[-5,1];
%% species
name='h';

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

%% read data
spm1=prm.read(['spctrm',name],tt1);
spm2=prm.read(['spctrm',name],tt2);
spm3=prm.read(['spctrm',name],tt3);
spm4=prm.read(['spctrm',name],tt4);
spm5=prm.read(['spctrm',name],tt5);

xx = linspace(-20,20,401);
xx = 10.^xx;
xx = xx*((m/prm.value.mi)*(prm.value.c/prm.value.vA).^2);
spm1(1:izero)=0;
spm2(1:izero)=0;
spm3(1:izero)=0;
spm4(1:izero)=0;
spm5(1:izero)=0;
loglog(xx, spm1, '-k', 'LineWidth', 1.5);
hold on
loglog(xx, spm2, '-r', 'LineWidth', 1.5);
loglog(xx, spm3, '-g', 'LineWidth', 1.5);
loglog(xx, spm4, '-b', 'LineWidth', 1.5);
loglog(xx, spm5, '-m', 'LineWidth', 1.5);
legend(['\Omega_{ci}t = ', num2str(tt1)], ['\Omega_{ci}t = ', num2str(tt2)], ['\Omega_{ci}t = ', num2str(tt3)], ['\Omega_{ci}t = ', num2str(tt4)], ['\Omega_{ci}t = ', num2str(tt5)])
% xlim([10^xrange(1),10^xrange(2)]);
xlabel(['E_{', sfx, '} [m_iv_A^2]']);
ylabel(['f_{', sfx, '}']);
% title(['\Omega_{ci}t = ', num2str(tt1)]);
set(gca,'FontSize', 14);