function plot_line_yy(fin,dist,Lx,Ly,x0,norm,direction,cc,fig)
%
%form: f=plot_line_yy(fd,Lx,Ly,x0,norm,[direction])
%
%input: 
%     fin is the data of field,it should be a cell 
%     Lx and Ly is the length and width of fd
%     x0 is the location of the line
%     norm is the normalized unit
%     direction indicate the direction of the line
%
%output:
%     fout is the field along the line
%
%-----------written by M.Zhou,2012, at SDCC------------------------
nf=length(fin);
if dist>=nf||dist==0, error('please choose the script "plot_line" instead!'); end
if nargin<7, direction=0; end   % 0 imply horizotal line
if nargin>7, color=cc; else color={'k','r','g','b','m','y','c'}; end
if nargin>8, figure;  end
%%
fd=fin{1};
fd=fd/norm(1);
ndx=size(fd,1); ndy=size(fd,2);
xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;
if direction==0, 
   rr1=xx;
   x0=x0+Ly/2;
   ny=floor(x0/Ly*ndy)+1;
   ny1=ny+1;
   ddx=x0/Ly*ndy-ny+1.;
   f1=fd(ny,:)*(1-ddx)+fd(ny1,:)*ddx;
else
   rr1=yy;
   nx=floor(x0/Lx*ndx)+1;
   nx1=nx+1;
   ddx=x0/Lx*ndx-nx+1.;
   f1=fd(:,nx)*(1-ddx)+fd(:,nx1)*ddx;
end
%%
fd=fin{dist+1};
fd=fd/norm(dist+1);
ndx=size(fd,1); ndy=size(fd,2);
xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;
if direction==0, 
   rr2=xx;
   x0=x0+Ly/2;
   ny=floor(x0/Ly*ndy)+1;
   ny1=ny+1;
   ddx=x0/Ly*ndy-ny+1.;
   f2=fd(ny,:)*(1-ddx)+fd(ny1,:)*ddx;
else
   rr2=yy;
   nx=floor(x0/Lx*ndx)+1;
   nx1=nx+1;
   ddx=x0/Lx*ndx-nx+1.;
   f2=fd(:,nx)*(1-ddx)+fd(:,nx1)*ddx;
end

 %%--------------make plots-----------------
 [ax,h1,h2]=plotyy(rr1,f1,rr2,f2);
 set(h1,'color',color{1},'linewidth',1.)
 set(h2,'color',color{dist+1},'linewidth',1.)
 set(ax(1),'Ycolor',color{1})
 set(ax(2),'Ycolor',color{dist+1})
 set(ax(2),'xticklabel','');
 %%
 hold(ax(1))
 for i=2:dist,
  fd=fin{i};
  fd=fd/norm(i);
  ndx=size(fd,1); ndy=size(fd,2);
  xx=0:Lx/ndx:Lx-Lx/ndx;
  yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;
  if direction==0, 
   rr3=xx;
   x0=x0+Ly/2;
   ny=floor(x0/Ly*ndy)+1;
   ny1=ny+1;
   ddx=x0/Ly*ndy-ny+1.;
   f3=fd(ny,:)*(1-ddx)+fd(ny1,:)*ddx;
  else
   rr3=yy;
   nx=floor(x0/Lx*ndx)+1;
   nx1=nx+1;
   ddx=x0/Lx*ndx-nx+1.;
   f3=fd(:,nx)*(1-ddx)+fd(:,nx1)*ddx;
  end
  plot(ax(1),rr3,f3,'linewidth',1.,'color',color{i});
 end
 %%
  hold(ax(2))
 for i=dist+2:nf,
  fd=fin{i};
  fd=fd/norm(i);
  ndx=size(fd,1); ndy=size(fd,2);
  xx=0:Lx/ndx:Lx-Lx/ndx;
  yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;
  if direction==0, 
   rr4=xx;
   x0=x0+Ly/2;
   ny=floor(x0/Ly*ndy)+1;
   ny1=ny+1;
   ddx=x0/Ly*ndy-ny+1.;
   f4=fd(ny,:)*(1-ddx)+fd(ny1,:)*ddx;
  else
   rr4=yy;
   nx=floor(x0/Lx*ndx)+1;
   nx1=nx+1;
   ddx=x0/Lx*ndx-nx+1.;
   f4=fd(:,nx)*(1-ddx)+fd(:,nx1)*ddx;
  end
  plot(ax(1),rr4,f4,'linewidth',1.,'color',color{i});
 end



