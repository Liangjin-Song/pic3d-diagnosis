%% plot magnetic field slash
% writen by Liangjin Song on 20190906
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);
tt=35;
%{
c=0.6;
n0=1304.33557;
wci=0.000750;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
%}
nt=length(tt);
vA=di*wci;

for t=1:nt
    cd(indir);
    vx=read_data('vxe',tt(t));
    % vy=read_data('vye',tt(t));
    vz=read_data('vze',tt(t));

    ex=read_data('Ex',tt(t));
    % by=by/c;

    ss=read_data('stream',tt(t));


    figure;
    plot_field(ex,Lx,Ly,c);
    cl=caxis;hold on
    plot_stream(ss,Lx,Ly,40);
    caxis(cl);hold on
    plot_vector(vx,vz,Lx,Ly,40,4,'r');
    xlim([Lx/2,Lx]);
    ylim([0,Ly/2]);

    cd(outdir);
    % print('-r300','-dpng',['B_slash_k=',num2str(k),'_t',num2str(tt(t),'%06.2f'),'.png']);
end
