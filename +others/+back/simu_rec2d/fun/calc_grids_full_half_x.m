function dest=calc_grids_full_half_x(fd,dirt)
%% change the grids from full grids to half or half grids to full
% writen by Liangjin Song on 20180710
%   fd is the source field which need to changed
%   dirt is the average direction, if dirt=1, then dest=[fd(x)+fd(x+1)]/2 else dest=[fd(x-1)+fd(x)]/2
%
% output
%   dest is the result of changing grids, which only changed in x direction
%   

%% The size of the field
ndx=size(fd,2);
ndy=size(fd,1);

%% Creat the matric
dest=zeros(ndy,ndx);

%% in x direction
% Traversing in z direction
for j=1:ndy
    % x direction
    for i=1:ndx
        if dirt==1
            % right boundary
            if i==ndx
                dest(j,i)=(fd(j,i)+fd(j,1))/2;
            else
                dest(j,i)=(fd(j,i)+fd(j,i+1))/2;
            end
        else
            if i==1
                dest(j,i)=(fd(j,ndx)+fd(j,1))/2;
            else
                dest(j,i)=(fd(j,i-1)+df(j,i))/2;
            end
        end
    end
end
