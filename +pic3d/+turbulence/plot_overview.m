% function plot_overview
%%
% @info: writen by Liangjin Song on 20210706
% @brief: plot the overview for the harris reconnection model
%%
clear;
%% parameters
% input/output directory
indir='E:\Turbulence\run1.1\data';
outdir='E:\Turbulence\run1.1\out\overview';
prm=slj.Parameters(indir,outdir);
% time
tt=70:79;
% the variable name
% varname={'B','E','Vi','Ve','Ni','Ne'};
varname={'B', 'E', 'J', 'Ni', 'Ne', 'Vi', 'Ve'};
% figure style
extra.Visible=true;
extra.xrange=[prm.value.lx(1), prm.value.lx(end)];
extra.yrange=[prm.value.lz(1), prm.value.lz(end)];
% extra.xrange=[60,90];
% extra.yrange=[9,15];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
lx=prm.value.lx;
ly=prm.value.lz;

%% the length of the time and the variable name
nt=length(tt);
nvar=length(varname);
%% loop
for t=1:nt
    for n=1:nvar
        %% read data
        name=char(varname(n));
        fd=prm.read(name, tt(t));
        % ss=prm.read('stream', tt(t));
        %% select the variable
        switch name
            % scalar field
            case {'Ni', 'Ne'}
                norm=prm.value.n0;
                fig=slj.Plot(extra);
                fig.field2d(fd.value/norm, lx, ly, extra);
                title([name,'   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'divB', 'divE'}
                norm=1;
                fig=slj.Plot(extra);
                fig.field2d(fd.value/norm, lx, ly, extra);
                title([name,'   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'B'}
                norm=1;
                fig=slj.Plot(extra);
               fig.field2d(fd.x/norm, lx, ly, extra);
                title(['Bx   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Bx_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.field2d(fd.y/norm, lx, ly, extra);
                title(['By   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['By_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.field2d(fd.z/norm, lx, ly, extra);
                title(['Bz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Bz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'E'}
                norm=prm.value.vA;
                fig=slj.Plot(extra);
                 fig.field2d(fd.x/norm, lx, ly, extra);
                title(['Ex   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ex_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                 fig.field2d(fd.y/norm, lx, ly, extra);
                title(['Ey   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ey_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                 fig.field2d(fd.z/norm, lx, ly, extra);
                title(['Ez   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ez_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'J'}
                norm=prm.value.qi*prm.value.n0*prm.value.vA;
                fig=slj.Plot(extra);
                fig.field2d(fd.x/norm, lx, ly, extra);
                title(['Jx   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jx_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.field2d(fd.y/norm, lx, ly, extra);
                title(['Jy   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jy_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.field2d(fd.z/norm, lx, ly, extra);
                title(['Jz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Vi','Ve'}
                norm=prm.value.vA;
                fig=slj.Plot(extra);
                fig.field2d(fd.x/norm, lx, ly, extra);
                title([name,'_x   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'x_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.field2d(fd.y/norm, lx, ly, extra);
                title([name,'_y   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'y_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.field2d(fd.z/norm, lx, ly, extra);
                title([name,'_z   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'z_t',num2str(tt(t),'%06.2f')]);
                fig.close();
        end
    end
end