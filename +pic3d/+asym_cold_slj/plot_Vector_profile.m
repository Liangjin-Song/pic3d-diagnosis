% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
% indir='E:\Asym\dst1\data';
% outdir='E:\Asym\dst1\out\Global';
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution';
prm=slj.Parameters(indir,outdir);
norm=prm.value.vA;
name='E';
nn = 1;
norm=1;
tt=40;
xz=25;
dir=1;
xrange=[-5,5];
extra.title=['\Omega_{ci}t=',num2str(tt)];
FontSize=14;

%% read data
V=prm.read(name,tt);
%% get the line
lf=V.get_line2d(xz, dir, prm, norm);

% lf.lx = smoothdata(lf.lx, 'movmean', nn);
% lf.ly = smoothdata(lf.ly, 'movmean', nn);
% lf.lz = smoothdata(lf.lz, 'movmean', nn);

if dir==1
    ll=prm.value.lz;
    pstr='x';
    extra.xlabel='Z [c/\omega_{pi}]';
else
    ll=prm.value.lx;
    pstr='z';
    extra.xlabel='X [c/\omega_{pi}]';
end
% if component=='x'
%     lf=lf.lx;
%     extra.ylabel=[name,'_{x}'];
% elseif component=='y'
%     lf=lf.ly;
%     extra.ylabel=[name,'_{y}'];
% elseif component=='z'
%     lf=lf.lz;
%     extra.ylabel=[name,'_{z}'];
% end

extra.title=['profiles ',pstr,' = ',num2str(xz),',  \Omega_{ci}t=',num2str(tt)];

% f=slj.Plot();
% f.line(ll, lf, extra);
figure;
plot(ll, lf.lx, 'r', 'LineWidth', 2);
hold on
plot(ll, lf.ly, 'b', 'LineWidth', 2);
plot(ll, lf.lz, 'm', 'LineWidth', 2);
legend('Ex', 'Ey', 'Ez');
xlim(xrange);
xlabel(extra.xlabel);
ylabel('E');
set(gca,'FontSize', FontSize);

cd(outdir);
% print('-dpng','-r300',['E_t',num2str(tt,'%06.2f'),'_',pstr,'=',num2str(xz),'.png']);
% f.png(prm,['Bx_t',num2str(tt),'_',pstr,num2str(xz)]);