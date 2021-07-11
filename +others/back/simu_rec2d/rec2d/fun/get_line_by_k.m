function [ln,lx,ly]=get_line_by_k(fd,nx0,ny0,k)
%% get the line data by slope
% writen by Liangjin Song on 20190906
%
% fd is the two dimensional distribution of the field
% nx0, ny0 are the index of the point
% k is the slope of the line
%
% nx0, ny0, and k can construct a straight line, 
% and this should be made by linear interpolation.
%
% ln is the line data
%%
ndx=size(fd,2);
ndy=size(fd,1);

ln=[];
lx=[];
ly=[];

for x=1:ndx
    y=(x-nx0)*k+ny0;
    if y<1 || y > ndy
        continue;
    end
    if y==ndy
        lx=[lx,x];
        ly=[ly,y];
        ln=[ln,fd(y,x)];
        continue;
    end

    % linear interpolation
    y1=floor(y);
    fd1=fd(y1,x);
    fd2=fd(y1+1,x);
    ln0=fd1+(fd2-fd1)*(y-y1);
    ln=[ln,ln0];
    lx=[lx,x];
    ly=[ly,y];
end
