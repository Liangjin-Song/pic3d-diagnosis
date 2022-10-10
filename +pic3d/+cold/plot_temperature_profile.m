% function plot_temperature(name)
% clear;
%% 
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out';
prm=slj.Parameters(indir,outdir);

tt=30;
name='l';

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
N=prm.read(['N',name],tt);
%% calculation
T=slj.Scalar((P.xx+P.yy+P.zz)./(N.value.*3));
lt=T.get_line2d(xz, dir, prm,norm);
%% figure
plot(ll,lt,'-k','LineWidth',2);
title(['T',sfx,', \Omega_{ci}t=',num2str(tt)]);
cd(outdir);
% print('-dpng','-r300',['T',sfx,'_t',num2str(tt(t)),'_',pstr,'=',num2str(xz),'.png']);
% close(gcf);


% end