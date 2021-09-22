function [f,lv]=pic3d_get_distribution_function(data)
%% writen by Liangjin Song on 20201126
% distribution function
%% parameters
% light speed
% c=0.5;
% the precision
% nv=100;
% speed vector
% lv=linspace(-c,c,nv);
% sv=-c:1/nv:c;
% the maxinum velocity value
mv=ceil(max([max(abs(data.vx));max(abs(data.vy));max(abs(data.vz))])+0.1);
% the precision
nv=100;
% speed vector
lv=linspace(-mv,mv,nv);
sv=-mv:2*mv/nv:mv;
% the number of particles
np=length(data.vx);

%% the array of distribution function
f=zeros(nv,nv,nv);

%% the distribution function
for s=1:np
    [nx,ny,nz]=velocity_index(data.vx(s),data.vy(s),data.vz(s),sv);
    f(nx,ny,nz)=f(nx,ny,nz)+1;
end