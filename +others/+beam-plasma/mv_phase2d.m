N=2176;
ndx=128;
ndy=128;
t=N/ndy;
ndy1=ndy;
Lx=128;
Ly=128;

xx=-Lx/2:Lx/ndx:(Lx/2-Lx/ndx);
yy=-Ly/2:Ly/ndy1:(Ly/2-Lx/ndy1);
[X,Y]=meshgrid(xx,yy);


m=moviein(t);
for i=0:t-1
pp=Potential(i*N/t+1:(i+1)*N/t,:);
pcolor(X,Y,pp);colorbar;shading flat
m(:,i+1)=getframe;
end
movie(m,1,2)