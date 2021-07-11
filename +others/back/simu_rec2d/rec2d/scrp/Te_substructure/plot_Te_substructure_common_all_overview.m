%% plot overview
% writen by Liangjin on 20190519 
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/Te_substructure/overview/';
tt=43;
c=0.6;
vA=0.03;
n0=1304.33557;
di=40;
Lx=4800/di;
Ly=2400/di;

nt=length(tt);
varname={'Bx','By','Bz','Ex','Ey','Ez','vxi','vyi','vzi','vxe','vye','vze','Densi','Dense'};
nvar=length(varname);
norm=1;
for i=1:nt
    t=tt(i);
    cd(indir);
    stream=read_data('stream',t);
    for j=1:nvar
        name=char(varname(j));
        cd(indir);
        dat=read_data(name,t);

        if strcmp('Bx',name) || strcmp('By',name) || strcmp('Bz',name)
            norm=c;
        elseif strcmp('Ex',name) || strcmp('Ey',name) || strcmp('Ez',name)
            norm=vA;
        elseif strcmp('vxi',name) || strcmp('vyi',name) || strcmp('vzi',name) || strcmp('vxe',name) || strcmp('vye',name) || strcmp('vze',name)
            norm=vA;
        elseif strcmp('Densi',name) || strcmp('Dense',name)
            norm=n0;
        else
            norm=1;
        end
        plot_overview(dat,stream,norm,Lx,Ly);
        xlim([70,110]);
        ylim([7,23]);
        cd(outdir);
        print('-r300','-dpng',[name,'_overview_t',num2str(t,'%06.2f'),'.png']);
        close(gcf);
    end
end
