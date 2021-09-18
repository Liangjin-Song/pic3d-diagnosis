%% plot magnetic field slash
% writen by Liangjin Song on 20190906
clear;
indir='/data/simulation/M100B15Bg10/data/';
outdir='/data/simulation/M100B15Bg10/out/zhong/';
tt=50;
c=0.6;
wci=0.0006;
di=27.2;
ndx=2400;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
vA=di*wci;

for t=1:nt
    cd(indir);
    vx=read_data('vxe',tt(t));
    % vy=read_data('vye',tt(t));
    vz=read_data('vze',tt(t));

    by=read_data('By',tt(t));
    by=by/c;

    ss=read_data('stream',tt(t));


    plot_field(by,Lx,Ly,c);
    cl=caxis;hold on
    plot_stream(ss,Lx,Ly,40);
    caxis(cl);hold on
    plot_vector(vx,vz,Lx,Ly,20,2,'r');

    cd(outdir);
    % print('-r300','-dpng',['B_slash_k=',num2str(k),'_t',num2str(tt(t),'%06.2f'),'.png']);
end
