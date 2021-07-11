function dest=calc_grids_full_half_z(fd,dirt)
%% change the grids from full grids to half or half grids to full
% writen by Liangjin Song on 20180710
%   fd is the source field which need to changed
%   dirt is the average direction, if dirt=1, then dest=[fd(z)+fd(z+1)]/2 else dest=[fd(z-1)+fd(z)]/2
%
% output
%   dest is the result of changing grids, which only changed in z direction
%   

%% The size of the field
ndx=size(fd,2);
ndy=size(fd,1);

%% Creat the matric
dest=zeros(ndy,ndx);

%% in z direction
% Traversing in x direction
for i=1:ndx
    % z direction
    for j=1:ndy
        if dirt==1
            % up boundary
            if j==ndy
                dest(j,i)=(fd(j,i)+fd(1,i))/2;
            else
                dest(j,i)=(fd(j,i)+fd(j+1,i))/2;
            end
        else
            if j==1
                dest(j,i)=(fd(ndy,i)+fd(1,i))/2;
            else
                dest(j,i)=(fd(j-1,i)+df(j,i))/2;
            end
        end
    end
end
