indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Distribution\Cold_Ions\Separatrix\Sphere\t=20';
prm=slj.Parameters(indir,outdir);



tt=50;
name='h';

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

% norm=tm/prm.value.coeff;
norm=1;
% norm=prm.value.vA;

for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    N=prm.read(['N',name],tt(t));
    B=prm.read('B', tt(t));
    E=prm.read('E', tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    T=slj.Scalar((P.xx+P.yy+P.zz)./(N.value.*3));
    
    %% figure
    f=figure('Visible', extra.Visible);
    slj.Plot.overview(B.z, ss, prm.value.lx, prm.value.lz, norm, extra);
    % title(['T',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    title(['Bz, \Omega_{ci}t=',num2str(tt(t))]);
    
    
    xlim([15,35])
    ylim([-10,10])
    hold on
    rgx=[29.5, 31];
    rgz=[0,2];
    plot([rgx(2),rgx(2)],rgz,'-r','LineWidth',2);
    plot([rgx(1),rgx(1)],rgz,'-r','LineWidth',2);
    plot(rgx,[rgz(1),rgz(1)],'-r','LineWidth',2);
    plot(rgx,[rgz(2),rgz(2)],'-r','LineWidth',2);
    
    cd(outdir);
%     print(f, '-dpng','-r300',['T',sfx,'_t',num2str(tt(t), '%06.2f'),'.png']);
%     close(gcf);
end
