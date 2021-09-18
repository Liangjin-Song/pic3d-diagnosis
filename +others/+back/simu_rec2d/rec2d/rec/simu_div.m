function fout=simu_div(fx,fy,norm)
%% purpose: calculate the divergence of a variable in simulation
%%  this version if for 2D simulation
%%
%%--------------written by Meng Zhou, Nov/17/2012------------------------
nx=size(fx,2);
ny=size(fx,1);
if nargin>2, 
    fx=fx/norm;
    fy=fy/norm;
end
%%
fout=zeros(ny,nx);
for j=1:ny-1
    for i=1:nx-1
        fout(j,i)=fx(j,i+1)-fx(j,i)+fy(j+1,i)-fy(j,i);
    end
end
