%% get the component of the generalized ohm's law
%% project to the parallel direction
%%
clear

%%
tt=32;
nx=2048;
ny=1024;
Lx=51.2;
Ly=25.6;
c=0.6;
norm=1*0.015;
norm2=658;
norm3=0.6;
norm4=658*0.03;
xrange=[37 41];
yrange=[5 7.5];
shift=0;
cr=[-0.2 0.2];
%%
it=num2str(tt,'%06.2f');
it=[it(1:3),'_',it(5:6)];
load(['ohmx_t',it,'.mat']);
load(['ohmy_t',it,'.mat']);
load(['ohmz_t',it,'.mat']);
eval(['ohmx=ohmx_t',it,';']);
eval(['ohmy=ohmy_t',it,';']);
eval(['ohmz=ohmz_t',it,';']);
load(['stream_t',it,'.mat']);
eval(['ss=stream_t',it,';']);
load(['Bx_t',it,'.mat']);
load(['By_t',it,'.mat']);
load(['Bz_t',it,'.mat']);
eval(['bx=Bx_t',it,';']);
eval(['by=By_t',it,';']);
eval(['bz=Bz_t',it,';']);
%%------------x component--------------------
efx=ohmx(:,1);
evbex=ohmx(:,3);
dpx=ohmx(:,4);
dvx=ohmx(:,5);
dvtx=ohmx(:,6);
%%
efx=reshape(efx,nx,ny);
efx=efx';
evbex=reshape(evbex,nx,ny);
evbex=evbex';
dpx=reshape(dpx,nx,ny);
dpx=dpx';
dvx=reshape(dvx,nx,ny);
dvx=dvx';
dvtx=reshape(dvtx,nx,ny);
dvtx=dvtx';
%%-----------------y component---------------------
efy=ohmy(:,1);
evbey=ohmy(:,3);
dpy=ohmy(:,4);
dvy=ohmy(:,5);
dvty=ohmy(:,6);
%%
efy=reshape(efy,nx,ny);
efy=efy';
evbey=reshape(evbey,nx,ny);
evbey=evbey';
dpy=reshape(dpy,nx,ny);
dpy=dpy';
dvy=reshape(dvy,nx,ny);
dvy=dvy';
dvty=reshape(dvty,nx,ny);
dvty=dvty';
%%----------------z component----------------
efz=ohmz(:,1);
evbez=ohmz(:,3);
dpz=ohmz(:,4);
dvz=ohmz(:,5);
dvtz=ohmz(:,6);
%%
efz=reshape(efz,nx,ny);
efz=efz';
evbez=reshape(evbez,nx,ny);
evbez=evbez';
dpz=reshape(dpz,nx,ny);
dpz=dpz';
dvz=reshape(dvz,nx,ny);
dvz=dvz';
dvtz=reshape(dvtz,nx,ny);
dvtz=dvtz';
%%
aax=efx+evbex;
aay=efy+evbey;
aaz=efz+evbez;
aa_para=simu_Epara(bx,by,bz,aax,aay,aaz);
dp_para=simu_Epara(bx,by,bz,dpx,dpy,dpz);
dv_para=simu_Epara(bx,by,bz,dvx,dvy,dvz);
dvt_para=simu_Epara(bx,by,bz,dvtx,dvty,dvtz);
%%
aa_para=simu_filter2d(aa_para);
dp_para=simu_filter2d(dp_para);
dv_para=simu_filter2d(dv_para);
dvt_para=simu_filter2d(dvt_para);
aa_para=simu_shift(aa_para,Lx,Ly,shift);
dp_para=simu_shift(dp_para,Lx,Ly,shift);
dv_para=simu_shift(dv_para,Lx,Ly,shift);
dvt_para=simu_shift(dvt_para,Lx,Ly,shift);
ss=simu_shift(ss,Lx,Ly,shift);
%%-----------------male field plot--------------------
figure

h1=subplot(3,1,1);
plot_field(aa_para,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)
%%
h2=subplot(3,1,2);
plot_field(dp_para,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)
%%
h3=subplot(3,1,3);
plot_field(dv_para,Lx,Ly,norm);
hold on
plot_stream(ss,Lx,Ly,60);
xlim(xrange)
ylim(yrange)
caxis(cr)






