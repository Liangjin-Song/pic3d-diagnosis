function div=calc_divergence(vx,~,vz,grids)
%% claculate the divergence of a vector
% wirten by Liangjin Song on 20190517 
% 
% vx, vy, vz is the three components of the vector 
% grids is the width of two adjacent points in the data
%
% div is the divergence of the vector, it define at the half grids
%%

%% ============================= Version 1 =======================
% pvx=calc_partial_x(vx,grids);
% pvz=calc_partial_z(vz,grids);
% define at half grids in x and z directions
% pvx=calc_grids_full_half_z(pvx,1);
% pvz=calc_grids_full_half_x(pvz,1);
% div=pvx+pvz;

%% ============================ Version 2 =======================
nx=size(vx,2);
nz=size(vx,1);
div=zeros(nz,nx);


for k=1:nz-1
    for i=1:nx-1
        div(k,i)=vx(k,i+1)-vx(k,i)+vz(k+1,i)-vz(k,i);
    end
end
div=div/grids;

% boundary condition
div(:,nx)=div(:,1);
div(nz,:)=div(nz-1,:);
