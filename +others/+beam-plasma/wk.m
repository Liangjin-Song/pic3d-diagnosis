nx=128;
ny=128;
dx=2*pi/256;
dy=2*pi/51.2;
xx=-(nx-1)*dx:dx:(nx-1)*dx;
yy=0:dy:(ny-1)*dy;
[X,Y]=meshgrid(xx,yy);
%
fw1=wk_ey_ly1';
fw2=wk_ey_ly2';
fw2=fw2(:,2:nx);
fw2=fliplr(fw2);
%
fw=[fw2,fw1];
%pcolor(X,Y,fw);shading flat
contour(xx,yy,fw,20)