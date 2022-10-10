% function plot_overview()
%%
% @info: writen by Liangjin Song on 20210611
% @brief: plot the overview for the asymetric reconnection with cold ions model
%%
clear;
%% parameters
% input/output directory
indir='E:\PIC\Asym\data';
outdir='E:\PIC\Asym\out\Overview';
prm=slj.Parameters(indir,outdir);
% time
tt=0:199;
% the variable name
varname={'B','E','J','Nshi','Nshe','Nspi','Nspe','Nsph','Nsphe','Vshi','Vshe','Vspi','Vspe','Vsph','Vsphe','Pshi','Pshe','Pspi','Pspe','Psph','Psphe','divB','divE'};
% varname={'B'};
% figure style
extra.xrange=[prm.value.lx(1), prm.value.lx(end)];
extra.yrange=[prm.value.lz(1), prm.value.lz(end)];
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
        %% select the variable
        switch name
            % scalar field
            case {'Nshi', 'Nspe', 'Nspi', 'Nshe'}
                norm=(prm.value.ntm+prm.value.nts)/2;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title([name,'   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, [name,'_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Nsph'}
                norm=(prm.value.ntm+prm.value.nts)/2;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Nspic   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Nspic_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Nsphe'}
                norm=(prm.value.ntm+prm.value.nts)/2;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Nspice   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Nspice_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'B'}
                norm=1;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Bx   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Bx_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['By   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['By_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Bz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Bz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'E'}
                norm=prm.value.vA;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Ex   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ex_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Ey   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ey_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Ez   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Ez_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'J'}
                norm=prm.value.qi*(prm.value.ntm+prm.value.nts)*0.5*prm.value.vA;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Jx   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jx_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Jy   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jy_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Jz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Jz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Vshi'}
                norm=prm.value.vA;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vshix   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vshix_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vshiy   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vshiy_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vshiz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vshiz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Vshe'}
                norm=prm.value.vA;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vshex   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vshex_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vshey   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vshey_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vshez   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vshez_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Vspi'}
                norm=prm.value.vA;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspix   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspix_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspiy   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspiy_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspiz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspiz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Vspe'}
                norm=prm.value.vA;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspex   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspex_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspey   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspey_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspez   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspez_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Vsph'}
                norm=prm.value.vA;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspicx   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspicx_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspicy   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspicy_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspicz   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspicz_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Vsphe'}
                norm=prm.value.vA;
                fig=slj.Plot();
                fig.overview(fd.x, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspicex   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspicex_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.y, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspicey   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspicey_t',num2str(tt(t),'%06.2f')]);
                fig.close();
                fig=slj.Plot();
                fig.overview(fd.z, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Vspicez   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Vspicez_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Pshi'}
                norm=prm.value.tls;
                N=prm.read('Nshi',tt(t));
                fd=fd.scalar();
                fd=fd/N;
                fd=fd.value;
                fd(isnan(fd))=0;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Tshi   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Tshi_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Pshe'}
                norm=prm.value.tes;
                N=prm.read('Nshe',tt(t));
                fd=fd.scalar();
                fd=fd/N;
                fd=fd.value;
                fd(isnan(fd))=0;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Tshe   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Tshe_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Pspi'}
                norm=prm.value.tlm;
                N=prm.read('Nspi',tt(t));
                fd=fd.scalar();
                fd=fd/N;
                fd=fd.value;
                fd(isnan(fd))=0;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Tspi   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Tspi_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Pspe'}
                norm=prm.value.tem;
                N=prm.read('Nspe',tt(t));
                fd=fd.scalar();
                fd=fd/N;
                fd=fd.value;
                fd(isnan(fd))=0;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Tspe   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Tspe_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Psph'}
                norm=prm.value.thm;
                N=prm.read('Nsph',tt(t));
                fd=fd.scalar();
                fd=fd/N;
                fd=fd.value;
                fd(isnan(fd))=0;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Tspic   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Tspic_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'Psphe'}
                norm=prm.value.tem;
                N=prm.read('Nsphe',tt(t));
                fd=fd.scalar();
                fd=fd/N;
                fd=fd.value;
                fd(isnan(fd))=0;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['Tspice   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['Tspice_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'divB'}
                norm=1;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['\nabla \cdot B   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['divB_t',num2str(tt(t),'%06.2f')]);
                fig.close();
            case {'divE'}
                norm=1;
                fig=slj.Plot();
                fig.overview(fd, ss, prm.value.lx, prm.value.lz, norm, extra);
                title(['\nabla \cdot E - \rho/\epsilon_0   \Omega_{ci}t=',num2str(tt(t))]);
                fig.png(prm, ['divE_t',num2str(tt(t),'%06.2f')]);
                fig.close();
        end
    end
end
