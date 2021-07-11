function plot_general_overview(indir,outdir,tt,c,vA,n0,Lx,Ly)
%% plot the output file overview 
% writen by Liangjin Song on 20190519 
%
% indir is the data directory 
% outdir is the saving figure's directory
% tt is the time array 
% c is the light speed 
% vA is the Alven speed 
% Lx Ly is the normalized system size
%%
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
        h=figure;
        set(h,'Visible','off');
        plot_overview(dat,stream,norm,Lx,Ly);
        save_figures(name,outdir,['_t',num2str(t,'%06.2f')]);
        close(gcf);
    end
end
