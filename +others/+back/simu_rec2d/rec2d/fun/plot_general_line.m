function plot_general_line(indir,outdir,x0,tt,c,vA,n0,Lx,Ly,dirt)
%% plot the output file line 
% writen by Liangjin Song on 20190519 
%
% indir is the data directory 
% outdir is the saving figure's directory
% x0 is the line position cutted
% tt is the time array 
% c is the light speed 
% vA is the Alven speed 
% Lx Ly is the normalized system size
% dirt is the direction of cutting line
%%
nt=length(tt);
varname={'Bx','By','Ex','Ey','Ez','vxi','vyi','vzi','vxe','vye','vze','Densi','Dense'};
nvar=length(varname);
norm=1;

fontsize=16;
linewidth=1;
gcf_size=[100,100,900,700];
gca_size=[.11 .11 .77 .84];

for i=1:nt
    t=tt(i);
    cd(indir);
    bz=read_data('Bz',t);
    [lbz,lx]=get_line_data(bz,Lx,Ly,x0,c,dirt);

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
        [ldat,~]=get_line_data(dat,Lx,Ly,x0,norm,dirt);

        % plot figure
        h=figure;
        set(h,'Visible','off');
        [ax,h1,h2]=plotyy(lx,ldat,lx,lbz);
        % set axis
        set(ax(1),'XColor','k','YColor','b','FontSize',fontsize);
        set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);

        % set label
        set(get(ax(1),'Ylabel'),'String',name,'FontSize',fontsize);
        set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
        xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

        % set line
        set(h1,'Color','b','LineWidth',linewidth);
        set(h2,'Color','r','LineWidth',linewidth);

        % set figure
        set(gcf,'Position',gcf_size);
        set(gca,'Position',gca_size);

        save_figures(name,outdir,['_t',num2str(t,'%06.2f')]);
        close(gcf);
    end
end
