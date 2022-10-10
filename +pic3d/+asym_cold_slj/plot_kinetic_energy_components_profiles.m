% function plot_kinetic_energy_components_profiles(name)
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Tmp';
prm=slj.Parameters(indir,outdir);

tt=30;
name='h';
xz=16;
dir=1;

xrange=[-10, 10];

if name == 'h'
    m=prm.value.mi;
    sfx='ic';
elseif name == 'l'
    m=prm.value.mi;
    sfx='ih';
elseif name == 'e'
    m=prm.value.me;
    sfx='e';
end

norm=0.5*m*prm.value.n0*prm.value.vA*prm.value.vA;

if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end


%% read data
V=prm.read(['V',name],tt);
N=prm.read(['N',name],tt);

%% calculation
K=V.sqre();
K=slj.Scalar(0.5.*m.*N.value.*K.value);

Kx=V.x.*V.x;
Ky=V.y.*V.y;
Kz=V.z.*V.z;

Kx=slj.Scalar(0.5.*m.*N.value.*Kx);
Ky=slj.Scalar(0.5.*m.*N.value.*Ky);
Kz=slj.Scalar(0.5.*m.*N.value.*Kz);


%% get line
lkx=Kx.get_line2d(xz,dir,prm,norm);
lky=Ky.get_line2d(xz,dir,prm,norm);
lkz=Kz.get_line2d(xz,dir,prm,norm);
lk=K.get_line2d(xz,dir,prm,norm);

%% figure
figure;
plot(ll, lk, '-k', 'LineWidth', 2);
hold on
plot(ll, lkx, '-r', 'LineWidth', 2);
plot(ll, lky, '-g', 'LineWidth', 2);
plot(ll, lkz, '-b', 'LineWidth', 2);

%% set figure
xlim(xrange);
legend('K', 'Kx', 'Ky', 'Kz', 'Location', 'Best');
xlabel(labelx);
ylabel(['K',sfx]);
title(['profiles  ', pstr,' = ',num2str(xz),', \Omega_{ci}t = ', num2str(tt)]);
set(gca,'FontSize',14);
cd(outdir);
% print('-dpng','-r300',['K',sfx,'_t',num2str(tt),'_components_profiles.png']);
% close(gcf);
%     


% end