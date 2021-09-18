function P_z=calc_partial_z(fd,divsor)
%% calculate the partial in z direction
% writen by Liangjin Song on 20180719
%   fd is the field
%   divsor is the interval between two points
%   
% output
%   P_z is partial(fd/z)
%

%% The size of the field
ndx=size(fd,2);
ndy=size(fd,1);

%% Creat the matric
P_z=zeros(ndy,ndx);

%% Partial fd/z
% Traversing in x direction
for i=1:ndx;
    % Partial fd/z
    for j=1:ndy
        % Period boundary
        % Up boundary
        if j==ndy
            b1=fd(j,i);
            b2=fd(1,i);
        else
            b1=fd(j,i);
            b2=fd(j+1,i);
        end
        P_z(j,i)=(b2-b1)/divsor;
    end
end