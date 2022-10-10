function plot_general_overview(indir,outdir,tt,varname,c,vA,n0,Lx,Ly)
%% plot the output file overview 
% writen by Liangjin Song on 20190519 
%
% indir is the data directory 
% outdir is the saving figure's directory
% tt is the time array 
% varname is the physics variable
% c is the light speed 
% vA is the Alven speed 
% Lx Ly is the normalized system size
%%
nt=length(tt);
nvar=length(varname);
norm=1;
for i=1:nt
    t=tt(i);
    cd(indir);
    stream=read_data('stream',t);
    for j=1:nvar
        name=char(varname(j));
        cd(indir);
        

        if strcmp('Bx',name) || strcmp('By',name) || strcmp('Bz',name)
            norm=c;
            dat=read_data(name,t);
        elseif strcmp('Ex',name) || strcmp('Ey',name) || strcmp('Ez',name)
            norm=vA;
            dat=read_data(name,t);
        elseif strcmp('vxi',name) || strcmp('vyi',name) || strcmp('vzi',name) || strcmp('vxe',name) || strcmp('vye',name) || strcmp('vze',name)
            norm=vA;
            dat=read_data(name,t);
        elseif strcmp('Densi',name) || strcmp('Dense',name)
            norm=n0;
            dat=read_data(name,t);
        elseif strcmp('Ti',name)
            dat=read_data('presi',t);
            ni=read_data('Densi',t);
            bx=read_data('Bx',t);
            by=read_data('By',t);
            bz=read_data('Bz',t);
            [dat,~,~,~]=calc_temperature(dat,bx,by,bz,ni);
            norm=1;
        elseif strcmp('Te',name)
            dat=read_data('prese',t);
            ne=read_data('Dense',t);
            bx=read_data('Bx',t);
            by=read_data('By',t);
            bz=read_data('Bz',t);
            [dat,~,~,~]=calc_temperature(dat,bx,by,bz,ne);
            norm=1;
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
