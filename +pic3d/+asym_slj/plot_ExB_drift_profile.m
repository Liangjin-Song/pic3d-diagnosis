% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\Asym\cold2\data';
outdir='E:\Asym\cold2\out\Article';
prm=slj.Parameters(indir,outdir);
norm=prm.value.vA;

name = 'h';
cmpt = 'y';
tt=34;

xz=30;
dir=1;
dd = 40;
nn = 10;

xrange=[-5,3];


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

%% read data
V=prm.read(['V',name],tt);
N=prm.read(['N',name],tt);
P=prm.read(['P',name],tt);
E=prm.read('E', tt);
B=prm.read('B', tt);

%% E times B
ExB = E.cross(B);

%% gradient drift
dP=P.divergence(prm);
dP = B.cross(dP);


BB = B.x.^2 + B.y.^2 + B.z.^2;

if cmpt == 'x'
    V = V.x;
    EB = ExB.x./BB;
    dP = dP.x./(q.*N.value.*BB);
elseif cmpt == 'y'
    V = V.y;
    EB = ExB.y./BB;
    dP = dP.y./(q.*N.value.*BB);
elseif cmpt == 'z'
    V = V.z;
    EB = ExB.z./BB;
    dP = dP.z./(q.*N.value.*BB);
else
    error('Parameters error!');
end

if dir==1
    ll=prm.value.lz;
    pstr='x';
    xlab='Z [c/\omega_{pi}]';
    lp = prm.value.lx;
    [~, xz] = min(abs(prm.value.lx - xz));
    V = mean(V(:, xz-dd:xz+dd), 2);
    EB = mean(EB(:, xz-dd:xz+dd), 2);
elseif dir == 0
    ll=prm.value.lx;
    pstr='z';
    xlab='X [c/\omega_{pi}]';
    lp = prm.value.lz;
    [~, xz] = min(abs(prm.value.lz - xz));
    V = mean(V(xz-dd:xz+dd, :), 1);
    EB = mean(EB(xz-dd:xz+dd, :), 1);
else
    error('Parameters error!');
end

%% smooth
V=smoothdata(V,'movmean',nn);
EB=smoothdata(EB,'movmean',nn);


% f=slj.Plot();
% f.line(ll, lf, extra);
figure;
plot(ll, V/norm, '-k', 'LineWidth', 2);
hold on
plot(ll, EB/norm, '-r', 'LineWidth', 2);
% plot(ll, dP/norm, '-b', 'LineWidth', 2);
% plot(ll, (EB+dP)/norm, '--k', 'LineWidth', 2);
title(['\Omega_{ci}t=',num2str(tt),', profiles  ', pstr,' = ',num2str(round(lp(xz)))]);
legend('V', 'E\timesB', 'B\times\nabla P','Sum');
xlim(xrange);
xlabel(xlab);
ylabel(['Vic', cmpt]);
set(gca,'FontSize', 14);

cd(outdir);
% print('-dpng','-r300',['V', name, cmpt, '_t',num2str(tt,'%06.2f'),'_',pstr,'=',num2str(xz),'.png']);