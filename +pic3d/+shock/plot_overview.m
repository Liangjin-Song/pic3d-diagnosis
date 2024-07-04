% function plot_overview
%%
% @info: writen by Liangjin Song on 20210706
% @brief: plot the overview for the harris reconnection model
%%
clear;
%% parameters
% input/output directory
indir='C:\Users\Liangjin\Pictures\Shock\data';
outdir='C:\Users\Liangjin\Pictures\Shock\out';
prm=slj.Parameters(indir,outdir);
% time
tt=0;
% the variable name
varname={'B','E','J','Vi','Ve','Ni','Ne', 'divE', 'divB'};
% varname={'B', 'E', 'J', 'Vi', 'Ve', 'Ni', 'Ne'};
% varname={'J', 'Vi', 'Ve', 'Ni', 'Ne'};
% figure style
extra.Visible=true;
extra.xrange=[prm.value.lx(1), prm.value.lx(end)];
extra.yrange=[prm.value.lz(1), prm.value.lz(end)];
% extra.xrange=[60,90];
% extra.yrange=[9,15];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
% extra=[];
%% the length of the time and the variable name
nt=length(tt);
nvar=length(varname);
%% loop
for t=1:nt
    for n=1:nvar
        %% read data
        name=char(varname(n));
        fd=prm.read(name,tt(t));
        ss=prm.read('stream',tt(t));
        %% select the variable
        switch name
            % scalar field
            case {'Ni', 'Ne'}
                norm=prm.value.n0;
                fig=slj.Plot(extra);
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([name,'   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'B'}
                norm=prm.value.b0;
                fig=slj.Plot(extra);
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Bx   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Bx_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['By   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['By_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Bz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Bz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'E'}
                norm=prm.value.vA*prm.value.b0;
                fig=slj.Plot(extra);
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Ex   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ex_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Ey   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ey_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Ez   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ez_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'J'}
                norm=prm.value.qi*prm.value.n0*prm.value.vA;
                fig=slj.Plot(extra);
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Jx   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jx_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Jy   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jy_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Jz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Vi','Ve'}
                norm=prm.value.vA;
                fig=slj.Plot(extra);
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([name,'_x   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'x_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([name,'_y   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'y_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([name,'_z   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'z_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'divB', 'divE'}
                norm=1;
                fig=slj.Plot(extra);
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([name,'   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
        end
    end
end