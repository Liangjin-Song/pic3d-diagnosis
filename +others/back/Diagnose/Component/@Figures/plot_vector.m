function plot_vector(vx,vy,prm,kav,scale,color)
%calculate the vector in a compressed manner and then plot
%
%input:
%   vx and vy are x,y component of velocity
%   Lx and Ly indicate the size of simulation box
%   kav is the compression index
%   plot_vector(vx,vy,Lx,Ly,[k,color])
%---------------written by M.Zhou----------------------------------
%%--------------modified by M Zhou On Jul-10-2013-------------------
Lx=prm.value.Lx;
Ly=prm.value.Lz;
ndx=size(vx,2);
ndy=size(vx,1);
nx=ndx/kav;ny=ndy/kav;
vxt=zeros(ny,nx);
vyt=zeros(ny,nx);
%obtain the compressed vx and vy
for j=1:ny
   for i=1:nx
    for id1=0:kav-1
       for id2=0:kav-1
        vxt(j,i)=vxt(j,i)+vx(j*kav-id1,i*kav-id2);
        vyt(j,i)=vyt(j,i)+vy(j*kav-id1,i*kav-id2);
       end
    end
   end
end
%
if nargin<6, scale=1.; color='w'; end
if nargin<7, color='w'; end

vxt=vxt./(kav*kav);
vyt=vyt./(kav*kav);
xx=0:Lx/nx:Lx-Lx/nx;
yy=-Ly/2:Ly/ny:Ly/2-Ly/ny;
[X,Y]=meshgrid(xx,yy);
quiver(X,Y,vxt,vyt,scale,'color',color,'linewidth',1.5);
axis([0 Lx -Ly/2 Ly/2]) 
xlabel('X [c/\omega_{pi}]')
ylabel('Z [c/\omega_{pi}]')

