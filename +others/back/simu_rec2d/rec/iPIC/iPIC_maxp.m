close all
 
dir='I:\PIC simulation\iPIC3D\Mar0108B\data\';
dirout='I:\PIC simulation\iPIC3D\Mar0108B\figures\maxp\';

%% box range in the GSM coordinate
xmin=-39.8; xmax=-8.0;
ymin=-4;    ymax=15.8;
zmin=-10.8; zmax=5;
time_start='2008-03-01/01:43:00';

ncycles=1000:1000:66000;
% var={'B_x','B_y','B_z'};
var={'B_y'};
% var={'B_x'};
nvar=length(var);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% normalization
B0=0.0097;
code_E = 2060.21;
code_B = 6.87213e-06;
code_B=code_B *1e9; % to convert from Tesla to nT
code_J = 1.20082e-05;
code_J = code_J*1e9; % to convert to nA/m^2
code_V = 2.99792e+08;
code_V=code_V/1e3; %to convert to Km/s
code_T = 1.50326e-10;
code_n = 0.25;
e=1.6e-19;
%convert to keV
TeoTi=1/5;
code_T=code_T/e/1e3/TeoTi;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% for the range of colorbars 
colorBx=[-25,25];
colorBy=[-15,15];
colorBz=[-15,15];
% %% 
colorEx=[-0.4,0.4];
colorEy=[-0.4,0.4];
colorEz=[-0.4,0.4];

colorJx=[-3,3];
colorJy=[-3,3];
colorJz=[-3,3];
% colorVx_min=-800; colorVx_max=800;
% colorVy_min=-400; colorVy_max=400;
% colorVz_min=-400; colorVz_max=400;
%  
% colorN_min=0.2; colorN_max=30;
% colorP_min=0; colorP_max=500;
%  
% colorBeta_min=0.1; colorBeta_max=1.4;
% colorteta_min=0.0; colorteta_max=360;
%  
% colorJx_min=-3.5; colorJx_max=3.5;
% colorJy_min=-3.5; colorJy_max=3.5;
% colorJz_min=-3.5; colorJz_max=3.5;
% colorJp_min=-3.5; colorJp_max=3.5;
%  
% colorJ_min=0.0; colorJ_max=3.5;
%  
% colorEx_min=-1.; colorEx_max=1.;
% colorEy_min=-3.; colorEy_max=3.;
% colorEz_min=-3.; colorEz_max=3.;
%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
filename=[dir, 'settings.hdf'];
Lx=double(hdf5read(filename,'/collective/Lx'));
Ly=double(hdf5read(filename,'/collective/Ly'));
Lz=double(hdf5read(filename,'/collective/Lz'));
Nx=double(hdf5read(filename,'/collective/Nxc'));
Ny=double(hdf5read(filename,'/collective/Nyc'));
Nz=double(hdf5read(filename,'/collective/Nzc'));
dx=(xmax-xmin)/Nx;
dy=(ymax-ymin)/Nz;
dz=(zmax-zmin)/Ny;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
for ic=ncycles
 
time=60*(ic/75000.0) *4   %times four to correct for change in dt between 2D and 3D;
time1=time+strepoch(time_start);
[ddd,ttt]=tostring(time1);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% find the location of the maximum pressure plane for each (x,y) point
  file=[dir, 'Pi_per1_cycle', num2str(ic),'.gda'];
  fid= fopen(file,'rb');
  pp=fread(fid,'real*8');
  fclose(fid);
  pp=reshape(pp,Nx,Ny,Nz);
  %%
  iloc=zeros(Nx,Nz);
  for ix=1:Nx
      for iy=1:Nz
      w=pp(ix,:,iy);
      iloc(ix,iy)=round(sum(w.*(1:Ny))./sum(w));
      end
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% load the flow vector data
  file=[dir, 'Ji_x_cycle', num2str(ic),'.gda'];
  fid= fopen(file,'rb');
  Jx=fread(fid,'real*8');
  fclose(fid);
  Jx=-reshape(Jx,Nx,Ny,Nz);
  
  file=[dir, 'Ji_z_cycle', num2str(ic),'.gda'];
  fid= fopen(file,'rb');
  Jz=fread(fid,'real*8');
  fclose(fid);
  Jz=reshape(Jz,Nx,Ny,Nz);
  
  
      vx=zeros(Nx,Nz);
      for ix=1:Nx
        for iy=1:Nz
            vx(ix,iy)=Jx(ix,iloc(ix,iy),iy);
        end
      end
    vx=reshape(vx,Nx,Nz);
    vx=vx';
    vx=fliplr(vx);
     
      vy=zeros(Nx,Nz);
      for ix=1:Nx
        for iy=1:Nz
            vy(ix,iy)=Jz(ix,iloc(ix,iy),iy);
        end
      end      
    vy=reshape(vy,Nx,Nz);
    vy=vy';
    vy=fliplr(vy);    
      
         
%%
for jj=1:nvar
    
file=[dir,var{jj},'_cycle', num2str(ic),'.gda'];
fid= fopen(file,'rb');
data=fread(fid,'real*8');
fclose(fid);
data=reshape(data,Nx,Ny,Nz);
%%
switch var{jj},
    case 'B_x', crange=colorBx; outname='Bx'; norm=1/code_B; varname='B_{x}(nT)';
    case 'B_y', crange=colorBz; outname='Bz'; norm=1/code_B; varname='B_{z}(nT)';
    case 'B_z', crange=colorBy; outname='By'; norm=1/code_B; varname='B_{y}(nT)';
    case 'E_x', crange=colorEx; outname='Ex'; norm=1/code_E; varname='E_{x}(mV/m)';
    case 'E_y', crange=colorEz; outname='Ez'; norm=1/code_E; varname='E_{z}(mV/m)';
    case 'E_z', crange=colorEy; outname='Ey'; norm=1/code_E; varname='E_{y}(mV/m)';
    case 'Ji_x', crange=colorJx; outname='Jix'; norm=1/code_J; varname='Ji_{x}(nA/m^{2})';
    case 'Ji_y', crange=colorJy; outname='Jiz'; norm=1/code_J; varname='Ji_{z}(nA/m^{2})';    
    case 'Ji_z', crange=colorJz; outname='Jiy'; norm=1/code_J; varname='Ji_{y}(nA/m^{2})';       
end
%%
if strcmp(var{jj},'B_x')==1||strcmp(var{jj},'E_x')==1||strcmp(var{jj},'Ji_x')==1||...
    strcmp(var{jj},'Je_x')==1, 
    data=-data;
end

%%
    ff=zeros(Nx,Nz);
    for ix=1:Nx
        for iy=1:Nz
            ff(ix,iy)=data(ix,iloc(ix,iy),iy);
        end
    end
    %%
    ff=reshape(ff,Nx,Nz);
    ff=ff';
    ff=fliplr(ff);
    xx=xmin:dx:xmax-dx;
    yy=ymin:dy:ymax-dy;
    xlb='X(R_{E})';
    ylb='Y(R_{E})';
    xrev=1;
    yrev=1;
    cutstr='maxp';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% --------------------make plots---------------------
timestr=['time=',ttt(1:end-2), ' UT'];
timestr=[timestr,'  ,  ',cutstr];
extras=struct('fig',1,'xlb',xlb,'ylb',ylb,'timetitle',timestr,'varlb',varname,...
    'xrev',xrev,'yrev',yrev,'crange',crange);
iPIC_plot_field(ff,xx,yy,norm,extras);
load('D:\Program Files\MATLAB\R2012a\work\simulation\rec\iPIC\colormap_Bxyz');
colormap(cmap);

hold on
extras1=struct('fig',0,'xlb',xlb,'ylb',ylb,'timetitle',timestr,...
    'xrev',xrev,'yrev',yrev, 'color','k','scale',2.);
iPIC_plot_vector(vx,vy,xx,yy,10,extras1);
%%
figname=[outname,'_',ttt(1:2),ttt(4:5),ttt(7:8),'UT_',cutstr];
print('-dpng','-r300',[dirout,figname]);
close(gcf)
 

 

 
end

end