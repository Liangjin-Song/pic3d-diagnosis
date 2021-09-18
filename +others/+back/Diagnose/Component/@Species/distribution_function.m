function dst = distribution_function(obj, prm, varargin)
%% writen by Liangjin Song on 20210330
% get the distribution function
%%
if ~isa(prm,'Parameters')
    error('Parameters error!');
end
%% normalization
if nargin == 3
    norm=varargin{1};
else
    norm=prm.value.vA;
end
obj.value.vx=obj.value.vx/norm;
obj.value.vy=obj.value.vy/norm;
obj.value.vz=obj.value.vz/norm;
dst=Distribution();
dst.name=obj.name;
dst.species=obj.species;
dst.time=obj.time;
dst.xrange=obj.xrange;
dst.yrange=obj.yrange;
dst.zrange=obj.zrange;

%% the maxinum velocity value
mv=ceil(max([max(abs(obj.value.vx));max(abs(obj.value.vy));max(abs(obj.value.vz))])+0.1);
% the precision
nv=100;
% speed vector
dst.value.lv=linspace(-mv,mv,nv);
sv=-mv:2*mv/nv:mv;
% the number of particles
np=length(obj.value.id);

%% the array of distribution function
f=zeros(nv,nv,nv);

%% the distribution function
for s=1:np
    [nx,ny,nz]=velocity_index(obj.value.vx(s),obj.value.vy(s),obj.value.vz(s),sv);
    f(nx,ny,nz)=f(nx,ny,nz)+1;
end
dst.value.fun=f;
end

%% ======================================================================== %%
%% get the index of a particle in the distribution function
function [nx,ny,nz]=velocity_index(vx,vy,vz,sv)
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
