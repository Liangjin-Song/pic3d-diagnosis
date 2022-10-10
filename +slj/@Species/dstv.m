function fd = dstv(obj, varargin)
%%
% @info: writen by Liangjin Song on 20210603
% @brief: generate the velocity distribution function
% @param: norm - the velocity normalization
% @return: fd - the distribution function
%%
%% normalization
if nargin == 1
    norm=1;
    % the precision
    nv=100;
elseif nargin == 2
    norm=varargin{1};
    % the precision
    nv=100;
elseif nargin == 3
    norm=varargin{1};
    % the precision
    nv=varargin{2};
else
    error('Parameters error!');
end
obj.value.vx=obj.value.vx/norm;
obj.value.vy=obj.value.vy/norm;
obj.value.vz=obj.value.vz/norm;
%% the maxinum velocity value
mv=ceil(max([max(abs(obj.value.vx));max(abs(obj.value.vy));max(abs(obj.value.vz))])+0.1);
% speed vector
lv=linspace(-mv,mv,nv);
sv=-mv:2*mv/nv:mv;
% the number of particles
np=length(obj.value.id);
%% the array of distribution function
f=zeros(nv,nv,nv);
%% the distribution function
for s=1:np
    [nx,ny,nz]=velocity_index(obj.value.vx(s),obj.value.vy(s),obj.value.vz(s),sv);
    f(nx,ny,nz)=f(nx,ny,nz) + obj.value.weight(s);
end
%% the Distribution class
fd=slj.Distribution(obj.time, obj.range, lv, f);
end

%% ======================================================================== %%
function [nx,ny,nz]=velocity_index(vx,vy,vz,sv)
%%
% @brief: get the index of a particle in the distribution function
% @param: vx - the velocity
% @param: vy - the velocity
% @param: vz - the velocity
% @param: sv - the speed vector
% @return: nx - the index in the velocity space
% @return: ny - the index in the velocity space
% @return: nz - the index in the velocity space
%%
nsv=length(sv)-1;
for i=1:nsv
    if(vx>sv(i) && vx <= sv(i+1))
        nx=i;
        break;
    end
end
for j=1:nsv
    if(vy>sv(j) && vy <= sv(j+1))
        ny=j;
        break;
    end
end
for k=1:nsv
    if(vz>sv(k) && vz <= sv(k+1))
        nz=k;
        break;
    end
end
end
