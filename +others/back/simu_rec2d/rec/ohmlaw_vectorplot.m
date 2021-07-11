%% get the component of the generalized ohm's law
%%
clear

%%
tt=46;
nx=1280;
ny=1280;
Lx=102.4;
Ly=102.4;
c=0.6;
qe=-0.000391;
norm=836;
norm2=836;
norm3=0.6;
norm4=658*0.03;
xrange=[35 47];
yrange=[21 30.2];
shift=30;
% cr=[-0.6 0.6];
%%
it=num2str(tt,'%3.3d');
load(['Dense_t',it,'_00.mat']);
eval(['ne=Dense_t',it,'_00;']);
load(['ohmx_t',it,'_00.mat']);
eval(['ohmx=ohmx_t',it,'_00;']);
load(['ohmz_t',it,'_00.mat']);
eval(['ohmz=ohmz_t',it,'_00;']);
load(['stream_t',it,'_00.mat']);
eval(['ss=stream_t',it,'_00;']);
%%
efx=ohmx(:,1);
evbix=ohmx(:,2);
evbex=ohmx(:,3);
dpx=ohmx(:,4);
%%
efz=ohmz(:,1);
evbiz=ohmz(:,2);
evbez=ohmz(:,3);
dpz=ohmz(:,4);
%%
efx=reshape(efx,nx,ny);
efx=efx';
evbix=reshape(evbix,nx,ny);
evbix=evbix';
evbex=reshape(evbex,nx,ny);
evbex=evbex';
dpx=reshape(dpx,nx,ny);
dpx=dpx';
%%
efz=reshape(efz,nx,ny);
efz=efz';
evbiz=reshape(evbiz,nx,ny);
evbiz=evbiz';
evbez=reshape(evbez,nx,ny);
evbez=evbez';
dpz=reshape(dpz,nx,ny);
dpz=dpz';
%%
Fx=qe*ne.*(efx-evbex-dpx);
Fz=qe*ne.*(efz-evbez-dpz);
Fx=simu_filter2d(Fx);
Fz=simu_filter2d(Fz);

% aa=ef-evbi;
% bb=ef-evbe;
% cc=evbe+dp+dv+dvdt;
% jxb=-evbi+evbe;
% efx=simu_filter2d(efx);
% evbix=simu_filter2d(evbix);
% evbex=simu_filter2d(evbex);
% dpx=simu_filter2d(dpx);
%%
% efz=simu_filter2d(efz);
% evbiz=simu_filter2d(evbiz);
% evbez=simu_filter2d(evbez);
% dpz=simu_filter2d(dpz);

%%
Fx=simu_shift(Fx,Lx,Ly,shift);
Fz=simu_shift(Fz,Lx,Ly,shift);
ne=simu_shift(ne,Lx,Ly,shift);
ss=simu_shift(ss,Lx,Ly,shift);
%%-----------------male field plot--------------------
figure
plot_field(ne,Lx,Ly,norm);
cr=caxis;
hold on
plot_stream(ss,Lx,Ly,60);
plot_vector(Fx,Fz,Lx,Ly,4,2);
xlim(xrange)
ylim(yrange)
caxis(cr)
%%






