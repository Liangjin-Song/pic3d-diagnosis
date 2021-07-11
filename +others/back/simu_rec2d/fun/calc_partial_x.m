function px=calc_partial_x(fd,grids)
%% calculate the partial in x direction
% writen by Liangjin Song on 20190627
%   fd is the field
%   grids is the interval between two points
%
% output
%   px is partial(fd/x)
%%

%% The size of the field
ndx=size(fd,2);
ndy=size(fd,1);

%% Creat the matric
px=zeros(ndy,ndx);

%% Partial fd/x
% Traversing in z direction
for j=1:ndy
   % Partial fd/x
   for i=1:ndx
       % Period boundary
       % right boundary
       if i==ndx
           b1=fd(j,i);
           b2=fd(j,1);
       else
           b1=fd(j,i);
           b2=fd(j,i+1);
       end
       px(j,i)=(b2-b1)/grids;
   end
end
