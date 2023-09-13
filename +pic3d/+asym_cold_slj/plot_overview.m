% function plot_overview(indir, outdir)
%%
% @info: writen by Liangjin Song on 20210802
% @brief: plot the overview for the asymmetric reconnection model with cold ions (asym_rec_slj)
%%
clear;
%% parameters
% input/output directory
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);
% time
tt=28;
% the variable name
% varname={'B','E','J','Vl','Vh','Ve','Nl','Nh','Ne', 'divB', 'divE'};
% varname={'B','Vh','Nh'};
% varname={'Ne', 'Nl'};
varname={'E'};
% figure style
extra.Visible=true;
extra.xrange=[prm.value.lx(1), prm.value.lx(end)];
extra.yrange=[prm.value.lz(1)+1, prm.value.lz(end)-1];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
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
        switch name
            % scalar field
            case {'Ne'}
                norm=prm.value.n0;
                fig=slj.Plot(extra);
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([name,'   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Nl'}
                norm=prm.value.n0;
                fig=slj.Plot(extra);
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Ni   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Nh'}
                norm=prm.value.n0;
                fig=slj.Plot(extra);
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Nic   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'B'}
                norm=1;
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
                norm=prm.value.vA;
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
            case {'Vl','Vh','Ve'}
                norm=prm.value.vA;
                fig=slj.Plot(extra);
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                switch name
                    case {'Vl'}
                        tname='Vi';
                    case {'Vh'}
                        tname='Vic';
                    case {'Ve'}
                        tname='Ve';
                end
                title([tname,'_x   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'x_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([tname,'_y   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'y_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([tname,'_z   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'z_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'divE', 'divB'}
                norm=1;
                fig=slj.Plot(extra);
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([name,'   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'qfluxl', 'qfluxh', 'qfluxe'}
                norm=1;
                switch name
                    case {'qfluxl'}
                        tname='qih';
                    case {'qfluxe'}
                        tname='qe';
                    case {'qfluxh'}
                        tname='qic';
                end
                fig=slj.Plot(extra);
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([tname,'x   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [tname,'x_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([tname,'y   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [tname,'y_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot(extra);
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([tname,'z   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [tname,'z_t',num2str(tt(t),'%06.2f')]);
                fig.close();
        end
    end
end
% end