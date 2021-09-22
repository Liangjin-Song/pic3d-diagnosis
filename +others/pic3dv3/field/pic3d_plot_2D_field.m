%% writen by Liangjin Song on 20200908
% plot the 2D field overview
%%
clear;
%% parameter
% indir='E:\PIC\Electron_Current';
% outdir='E:\PIC\Electron_Current';
indir='E:\PIC\Test';
outdir='E:\PIC\Test';

nx=100;
ny=100;
nz=1;
di=20;

tt=0;
varname={'B','E','divB','divE','J','Ni','Ne','Vi','Ve','Pi','Pe'};
% varname={'B','E','J','Nh','Nl','Ne','Nhe','Vh','Vl','Ve','Vhe','Ph','Pl','Pe','Phe','divB','divE'};
% varname={'Vh'};
norm=1;
%% parameter
Lx=nx/di;
Ly=ny/di;

xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
% xrange=[50,57];
% yrange=[-3,3];

nt=length(tt);
nvar=length(varname);

%% loop
for t=1:nt
    for n=1:nvar
        cd(indir);
        name=char(varname(n));
        fd=pic3d_read_data(name,tt(t),nx,ny,nz);
        ss=pic3d_read_data('stream',tt(t),nx,ny,nz);
        if strcmp(name,'Ni') || strcmp(name,'Ne')
            h=plot_overview(fd,ss,Lx,Ly,norm,name,tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'Nl')
            name='Ni';
            h=plot_overview(fd,ss,Lx,Ly,norm,name,tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'Nh')
            name='Nic';
            h=plot_overview(fd,ss,Lx,Ly,norm,name,tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'Nhe')
            name='Nice';
            h=plot_overview(fd,ss,Lx,Ly,norm,name,tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'B')
            h1=plot_overview(fd.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
            h2=plot_overview(fd.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
            h3=plot_overview(fd.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
            cd(outdir);
            print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h1);
            close(h2);
            close(h3);
        elseif strcmp(name,'E')
            h1=plot_overview(fd.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
            h2=plot_overview(fd.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
            h3=plot_overview(fd.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
            cd(outdir);
            print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h1);
            close(h2);
            close(h3);
        elseif strcmp(name,'J')
            h1=plot_overview(fd.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
            h2=plot_overview(fd.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
            h3=plot_overview(fd.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
            cd(outdir);
            print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h1);
            close(h2);
            close(h3);
        elseif  strcmp(name,'Vi') || strcmp(name,'Ve') || strcmp(name,'Amp')
            h1=plot_overview(fd.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
            h2=plot_overview(fd.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
            h3=plot_overview(fd.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
            cd(outdir);
            print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h1);
            close(h2);
            close(h3);
        elseif strcmp(name,'Vhe')
            name='Vice';
            h1=plot_overview(fd.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
            h2=plot_overview(fd.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
            h3=plot_overview(fd.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
            cd(outdir);
            print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h1);
            close(h2);
            close(h3);
        elseif strcmp(name,'Vl')
            name='Vi';
            h1=plot_overview(fd.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
            h2=plot_overview(fd.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
            h3=plot_overview(fd.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
            cd(outdir);
            print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h1);
            close(h2);
            close(h3);
        elseif strcmp(name,'Vh')
            name='Vic';
            h1=plot_overview(fd.x,ss,Lx,Ly,norm,[name,'x'],tt(t),xrange,yrange);
            h2=plot_overview(fd.y,ss,Lx,Ly,norm,[name,'y'],tt(t),xrange,yrange);
            h3=plot_overview(fd.z,ss,Lx,Ly,norm,[name,'z'],tt(t),xrange,yrange);
            cd(outdir);
            print(h1,'-r300','-dpng',[name,'x_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h2,'-r300','-dpng',[name,'y_t',num2str(tt(t),'%06.2f'),'.png']);
            print(h3,'-r300','-dpng',[name,'z_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h1);
            close(h2);
            close(h3);
        elseif strcmp(name,'Pi')
            fd=(fd.xx+fd.yy+fd.zz)/3;
            nn=pic3d_read_data('Ni',tt(t),nx,ny,nz);
            fd=fd./nn;
            h=plot_overview(fd,ss,Lx,Ly,norm,'Ti_{aver}',tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',['Ti_aver_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'Pe')
            fd=(fd.xx+fd.yy+fd.zz)/3;
            nn=pic3d_read_data('Ne',tt(t),nx,ny,nz);
            fd=fd./nn;
            h=plot_overview(fd,ss,Lx,Ly,norm,'Te_{aver}',tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',['Te_aver_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'Pl')
            fd=(fd.xx+fd.yy+fd.zz)/3;
            nn=pic3d_read_data('Nl',tt(t),nx,ny,nz);
            fd=fd./nn;
            h=plot_overview(fd,ss,Lx,Ly,norm,'Ti_{aver}',tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',['Ti_aver_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'Ph')
            fd=(fd.xx+fd.yy+fd.zz)/3;
            nn=pic3d_read_data('Nh',tt(t),nx,ny,nz);
            fd=fd./nn;
            h=plot_overview(fd,ss,Lx,Ly,norm,'Tic_{aver}',tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',['Tic_aver_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'Phe')
            fd=(fd.xx+fd.yy+fd.zz)/3;
            nn=pic3d_read_data('Nhe',tt(t),nx,ny,nz);
            fd=fd./nn;
            h=plot_overview(fd,ss,Lx,Ly,norm,'Tice_{aver}',tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',['Tice_aver_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'divE')
            norm=1;
            h=plot_overview(fd,ss,Lx,Ly,norm,'\nabla \cdot E-q_iN_i-q_eN_e',tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'divB')
            norm=1;
            h=plot_overview(fd,ss,Lx,Ly,norm,'\nabla \cdot B',tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        elseif strcmp(name,'divJ')
            h=plot_overview(fd,ss,Lx,Ly,norm,'\nabla \cdot J + \partial \rho/\partial t',tt(t),xrange,yrange);
            cd(outdir);
            print(h,'-r300','-dpng',[name,'_t',num2str(tt(t),'%06.2f'),'.png']);
            close(h);
        end
    end
end

%% plot figure
function h=plot_overview(fd,ss,Lx,Ly,norm,name,time,xrange,yrange)
    h=figure;
    pic3d_plot_2D_base_field(fd,Lx,Ly,norm); hold on
    cr=caxis;
    pic3d_plot_2D_stream(ss,Lx,Ly,20); hold off
    caxis(cr);
    title([name,', \Omega_{ci}t =',num2str(time)]);
    xlim(xrange);
    ylim(yrange);
end
