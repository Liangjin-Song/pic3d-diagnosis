function c=calc_cross(a,b)
% calculate a cross b
% writen by Liangjin Song on 20190531

c.x=a.y.*b.z-a.z.*b.y;
c.y=a.z.*b.x-a.x.*b.z;
c.z=a.x.*b.y-a.y.*b.x;
