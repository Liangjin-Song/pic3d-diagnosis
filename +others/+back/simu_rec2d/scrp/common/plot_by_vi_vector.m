%% plot magnetic field slash
% writen by Liangjin Song on 20190906
clear;
indir='E:\B1.5T06Bs6Bg00';
outdir='E:\B1.5T06Bs6Bg00';
tt=73;
c=0.6;
di=40;
Lx=4800/di;
Ly=2400/di;
nt=length(tt);

for t=1:nt
    cd(indir);
    vx=read_data('vxi',tt(t));
    % vy=read_data('vye',tt(t));
    vz=read_data('vzi',tt(t));

    by=read_data('Bz',tt(t));
    by=by/c;

    ss=read_data('stream',tt(t));


    figure;
    plot_field(by,Lx,Ly,c);
    cl=caxis;hold on
    plot_stream(ss,Lx,Ly,40);
    caxis(cl);hold on
    plot_vector(vx,vz,Lx,Ly,40,2,'r');

    cd(outdir);
    % print('-r300','-dpng',['B_slash_k=',num2str(k),'_t',num2str(tt(t),'%06.2f'),'.png']);
end
