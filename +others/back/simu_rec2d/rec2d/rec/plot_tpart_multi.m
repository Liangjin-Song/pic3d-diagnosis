function plot_tpart_multi(part,varname,norm,dt,t1,t2)
%%
c=0.6;  %speed of light
%%
N=size(part,1);
Mv=length(varname);  %how many variables to be plotted
Mn=length(norm);
if Mn<Mv, norm=[norm,ones(Mv-Mn,1)]; end
%%
xx=part(:,2);
zz=part(:,3);
vx=part(:,4);
vy=-part(:,5);  %due to rotation of coord between simu and tail.
vz=part(:,6);
en=part(:,7);
bx=part(:,8);
by=-part(:,9);
bz=part(:,10);
ex=part(:,11);
ey=-part(:,12);
ez=part(:,13);
rk=part(:,14);
%%
f=zeros(Mv,N);
title=cell(Mv,1);
%%
%%
for ii=1:Mv
switch varname{ii}
    case 'x',  f(ii,:)=xx/norm(ii);  title{ii}='x/d_{i}';
    case 'z',  f(ii,:)=zz/norm(ii);  title{ii}='z/d_{i}';
    case 'vx', f(ii,:)=vx/norm(ii);  title{ii}='v_{x}/v_{A}';
    case 'vy', f(ii,:)=vy/norm(ii);  title{ii}='v_{y}/v_{A}';
    case 'vz', f(ii,:)=vz/norm(ii);  title{ii}='v_{z}/v_{A}';
    case 'energy',f(ii,:)=en/norm(ii); title{ii}='wk/m_{e}c^{2}';
    case 'bx', f(ii,:)=bx/norm(ii);    title{ii}='b_{x}/b0';
    case 'by', f(ii,:)=by/norm(ii);    title{ii}='b_{y}/b0';
    case 'bz', f(ii,:)=bz/norm(ii);   title{ii}='b_{z}/b0';
    case 'ex', f(ii,:)=ex/norm(ii);   title{ii}='e_{x}/(v_{A}b_{0})';
    case 'ey', f(ii,:)=ey/norm(ii);   title{ii}='e_{y}/(v_{A}b_{0})';
    case 'ez', f(ii,:)=ez/norm(ii);   title{ii}='e_{z}/(v_{A}b_{0})';
    case 'kappa',f(ii,:)=rk;          title{ii}='\kappa';
    case 'vpara',
         btot=bx.^2+by.^2+bz.^2;
         f(ii,:)=(vx.*bx+vy.*by+vz.*bz)./sqrt(btot);
         f(ii,:)=f(ii,:)/norm(ii);
         title{ii}='v_{||}/(v_{A}';
    case 'vperp',
         btot=bx.^2+by.^2+bz.^2;
%          vthx=vx-(ey.*bz-ez.*by)./btot;
%          vthy=vy-(ez.*bx-ex.*bz)./btot;
%          vthz=vz-(ex.*by-ey.*bx)./btot;
         vpara=(vx.*bx+vy.*by+vz.*bz)./sqrt(btot);
         f(ii,:)=sqrt(vx.^2+vy.^2+vz.^2-vpara.^2);
         f(ii,:)=f(ii,:)/norm(ii);
         title{ii}='v_{\perp}/v_{A}';
    case 'veb',
         btot=bx.^2+by.^2+bz.^2;
         vebx=(ey.*bz-ez.*by)./btot;
         veby=(ez.*bx-ex.*bz)./btot;
         vebz=(ex.*by-ey.*bx)./btot;
         f(ii,:)=sqrt(vebx.^2+veby.^2+vebz.^2);
         f(ii,:)=f(ii,:)/norm(ii);
         title{ii}='v_{ExB}/v_{A}';
    case 'wpara',
         btot=bx.^2+by.^2+bz.^2;
         vpara=(vx.*bx+vy.*by+vz.*bz)./sqrt(btot);
         f(ii,:)=(c./sqrt(c^2-vpara.^2)-1).*c^2;
         f(ii,:)=f(ii,:)/norm(ii);
         title{ii}='w_{||}/m_{e}c^{2}';
    case 'wperp'
         btot=bx.^2+by.^2+bz.^2;
         vpara=(vx.*bx+vy.*by+vz.*bz)./sqrt(btot);
         wpara=(c./sqrt(c^2-vpara.^2)-1).*c^2;
         f(ii,:)=(en-wpara)/norm(ii);
         title{ii}='w_{\perp}/m_{e}c^{2}';
    case 'epara',
          btot=bx.^2+by.^2+bz.^2;
          f(ii,:)=(ex.*bx+ey.*by+ez.*bz)./sqrt(btot);
          f(ii,:)=f(ii,:)/norm(ii);
          title{ii}='E_{||}/(v_{A}b_{0})';
    case 'eperp',
          btot=bx.^2+by.^2+bz.^2;
          epara=(ex.*bx+ey.*by+ez.*bz)./sqrt(btot);
          f(ii,:)=sqrt(ex.^2+ey.^2+ez.^2-epara.^2);
          f(ii,:)=f(ii,:)/norm(ii);
          title{ii}='E_{\perp}/(v_{A}b_{0})';
end
end
%%
tt=dt:dt:(N-1)*dt;
if nargin>4,    % clip a time range to plot
  n1=floor(t1/dt)+1;
  n2=floor(t2/dt);
  if n2>N, n=N; end
  f=f(:,n1:n2);
  tt=n1*dt:dt:n2*dt;
end

%%----------------------make plots with multiple panels-------------------%
figure
left=0.3;
width=0.5;
gap=0.02;
height=(1-0.1-0.05)/Mv-gap;
for jj=1:Mv
bottom=(1-0.05)-(height+gap)*jj;
h=subplot('position',[left,bottom,width,height]);
plot(tt,f(jj,:),'k','linewidth',2)
set(h,'fontsize',12,'linewidth',1.5)
if jj~=Mv, set(h,'xticklabel',''); end
if jj==Mv,xlabel('t\omega_{ci}','fontsize',14); end
ylabel(title{jj},'fontsize',14)
end
%%








