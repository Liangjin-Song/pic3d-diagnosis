% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);
norm=prm.value.vA;
% norm=1;
name='Vh';
tt=[28, 30, 32];
sty = {'-r', '-b', '-k'};
xz=38;
dir=1;
xrange=[-10,10];
FontSize=14;

if dir==1
    ll=prm.value.lz;
    pstr='x';
    extra.xlabel='Z [c/\omega_{pi}]';
else
    ll=prm.value.lx;
    pstr='z';
    extra.xlabel='X [c/\omega_{pi}]';
end

nt = length(tt);
f = figure;
hold on
for t=1:nt
    %% read data
    V=prm.read(name,tt(t));
    %% get the line
    lf=V.get_line2d(xz, dir, prm, norm);
    lf = lf.lz;
    plot(ll, lf, sty{t}, 'LineWidth', 2);
    
end

xlabel(extra.xlabel);
ylabel('V_{icz}');
legend('t = 28', 't = 30', 't = 32', 'Box', 'off');
set(gca, 'FontSize', 14);

cd(outdir);
% print('-dpng','-r300',[name, '_t',num2str(tt,'%06.2f'),'_',pstr,'=',num2str(xz),'.png']);
% f.png(prm,['Bx_t',num2str(tt),'_',pstr,num2str(xz)]);