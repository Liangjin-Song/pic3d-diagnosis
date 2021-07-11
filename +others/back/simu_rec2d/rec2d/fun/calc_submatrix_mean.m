function [aver,sub]=calc_submatrix_mean(fd,px,py,hx,hy)
%% claculate the mean value of a sub matrix in fd 
% writen by Liangjin Song on 20190518 
% 
% px, py are the centry point of the sub matrix 
% hx, hy are the half width and half length of the sub matrix 
%
% aver is the average value of the sub matrix
%%
sub=zeros(2*hy+1,2*hx+1);
ndy=size(fd,1);
ndx=size(fd,2);

px0=px-hx;
py0=py-hy;
if px0<1
    px0=px0+ndx;
end
if py0<1
    py0=py0+ndy;
end

nx=2*hx+1;
ny=2*hy+1;
for i=1:nx
    for j=1:ny
        m=px0+i-1;
        n=py0+j-1;
        if m>ndx
            m=m-ndx;
        end
        if n>ndy
            n=n-ndy;
        end
        sub(j,i)=fd(n,m);
    end
end
aver=mean(mean(sub));
