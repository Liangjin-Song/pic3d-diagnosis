function sub=get_sub_matrix(field,x0,y0,top,bottom,left,right)
%% get a sub matrix of field
% writen by Liangjin Song on 20190809 
%
% x0, and y0 are the center point of the matrix
% top, bottom, left, and right are the shift associated with the center point
%
% sub is the sub matrix
%%
ndx=size(field,2);
ndy=size(field,1);
nx=left+right;
ny=top+bottom;
sub=zeros(ny+1,nx+1);

% get the NorthWest point
x1=x0-left;
x1=x1+ndx*(x1<=0);
y1=y0-top;
y1=y1+ndy*(y1<=0);

% get the matrix
for i=0:nx
    for j=0:ny
        x2=x1+i;
        x2=x2-ndx*(x2>ndx);
        y2=y1+j;
        y2=y2-ndy*(y2>ndy);
        sub(j+1,i+1)=field(y2,x2);
    end
end
