%% plot temperature anisotropy profiles
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out';
prm=slj.Parameters(indir,outdir);

tt=40;
name='e';

dir=0;
xz=0;

if name == 'h'
    tm=prm.value.tem*prm.value.tle*prm.value.thl;
    sfx='ic';
elseif name == 'l'
    tm=prm.value.tem*prm.value.tle;
    sfx='ih';
elseif name == 'e'
    tm=prm.value.tem;
    sfx='e';
end

if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end


% norm=1;
norm=tm/prm.value.coeff;


%% read data
P=prm.read(['P',name],tt);
B=prm.read('B',tt);
N=prm.read(['N',name],tt);


%% fac tensor
P=P.fac_tensor(B,prm);

perp=(P.xx+P.yy)/2;
perp=slj.Scalar(perp./N.value);
para=slj.Scalar(P.zz./N.value);

%% get line
lperp=perp.get_line2d(xz, dir, prm, norm);
lpara=para.get_line2d(xz, dir, prm, norm);
lbz = B.get_line2d(xz, dir, prm, 1);
lbz=lbz.lz;

%% figure
figure;
plot(ll,lperp,'-r','LineWidth',2); hold on
plot(ll,lpara,'-b','LineWidth',2);
plot(ll, lbz, '-g','LineWidth',2);
legend(['T',sfx,'_{perp}'],['T',sfx,'_{para}'], 'B_z');
title(['profiles  ',pstr,'=',num2str(xz),',  \Omega_{ci}t=',num2str(tt)]);
xlabel(labelx);
set(gca,'FontSize',16);