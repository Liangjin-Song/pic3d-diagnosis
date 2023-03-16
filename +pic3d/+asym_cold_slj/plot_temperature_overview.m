% function plot_temperature_overview(name)
clear;
%% 
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution';
prm=slj.Parameters(indir,outdir);



tt=0;
name='l';
disp(name);

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.Visible=true;

if name == 'h'
    tm=prm.value.thm;
    sfx='ic';
elseif name == 'l'
    tm=prm.value.tlm;
    sfx='ih';
elseif name == 'e'
    tm=prm.value.tem;
    sfx='e';
end

norm=tm/prm.value.coeff;
% norm = 1;

for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    T=slj.Scalar((P.xx+P.yy+P.zz)./(N.value.*3));

    %% figure
    f=figure('Visible', extra.Visible);
    slj.Plot.overview(T, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['T',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    cd(outdir);
%     print(f, '-dpng','-r300',['T',sfx,'_t',num2str(tt(t), '%06.2f'),'.png']);
%     close(gcf);
end


% end