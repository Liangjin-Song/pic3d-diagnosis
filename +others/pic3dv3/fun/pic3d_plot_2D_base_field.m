function pic3d_plot_2D_base_field(fd,Lx,Ly,norm,fig)
%plot the 2D field diagram of reconnetion code.
%
%input:
%      fd is the array containing the information of field
%      Lx is the length of x direction
%      Ly is the length of y direction
%      norm is the nomarlized factor
%
%    if fd is electric field, then fd=fd*(C/Va)/B0
%    if fd is density, then fd=fd/nb;
%    if fd is velocity, then fd=fd/Va;
%-----------written by M.Zhou------------------------------
if nargin<5, fig=0; end
%%
ndx=size(fd,2);
ndy=size(fd,1);
fd=fd./norm;
%plot the figure
xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;
[X,Y]=meshgrid(xx,yy);
%%
if fig>0, figure; end
pcolor(X,Y,fd);colorbar;shading flat
axis([0 Lx -Ly/2 Ly/2])
%title([', t \omega_{ce}=',num2str(819.2)])
xlabel('X [c/\omega_{pi}]','fontsize',14)
ylabel('Z [c/\omega_{pi}]','fontsize',14)

%%
axis on
set(gca,'fontsize',14,'DataAspectRatio',[1 1 1],'PlotBoxAspectRatio',[1 1 1],...
    'Xminortick','on','Yminortick','on','tickdir','out')



