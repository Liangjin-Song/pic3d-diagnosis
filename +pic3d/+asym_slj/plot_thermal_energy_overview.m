% function plot_thermal_energy_overview(name)
clear;
%%
indir='E:\Asym\Cold2\data';
outdir='E:\Asym\Cold2\out\Energy\Thermal';
prm=slj.Parameters(indir,outdir);

tt=0:70;
name='h';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.Visible=false;

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

norm=0.5*prm.value.n0*tm/prm.value.coeff;

for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    U=slj.Scalar((P.xx+P.yy+P.zz).*0.5);

    %% figure
    slj.Plot.overview(U, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['U',sfx,', \Omega_{ci}t=',num2str(tt(t))]);
    cd(outdir);
    print('-dpng','-r300',['U',sfx,'_t',num2str(tt(t)),'.png']);
    close(gcf);
end


% end
