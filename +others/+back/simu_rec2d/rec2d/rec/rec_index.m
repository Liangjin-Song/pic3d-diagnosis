function [ix,iy]=rec_index(bb,v)
%
[c,h]=contour(bb,v);
i=find(c(1,:)==v);
%
n=length(c(1,:));
m=length(i);
k1=i(1)+1;
k2=n;
if m>1
    j1=i(m)-2; 
    j2=n-i(m);
    if j1>j2
        k1=2;
        k2=i(1)-1;
    else
        k1=i(m)+1;
        k2=n;
    end
end
    %
    ix=c(1,k1:k2);
    iy=c(2,k1:k2);
    