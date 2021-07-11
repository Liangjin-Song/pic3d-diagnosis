%% calculate the degree of asymmetry for reconnection study
%%
clear all

Lx=50;
Ly=50;
xrange=[33.5,38.5];
yrange=[10,15];
tt=30;
bg=-0.2*0.6;  %guide field strength
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(5:6)];
%%
fname=['By_t',it,'.mat'];
load(fname);
eval(['by=By_t',it,';'])
%%
nx=size(by,2);
ny=size(by,1);
dx=Lx/nx;
dy=Ly/ny;
ix1=floor(xrange(1)/dx)+1;
ix2=floor(xrange(2)/dx)+1;
iy1=floor((yrange(1)+Ly/2)/dy)+1;
iy2=floor((yrange(2)+Ly/2)/dy)+1;
%%
byn=by(iy1:iy2,ix1:ix2)-bg;
vv1=find(byn>=0);
vv2=find(byn<0);
degree=length(vv1)/length(vv2)





