%% transform the pressure tensor to the field-aligned coordinate.
function pp=simu_pres_fac(pres,bx,by,bz)
%%
%%input
%%  pres: pressure tensor directly from simulation
%%  bx,by and bz are three components of magnetic field 
%%output
%%  pp: pressure tensor in the field aligned coordinate
%%  pp=[pxx,pxy,pxz,pyy,pyz,pzz];
%% here x,y are perpendicular to B0 while z is along B0. 
%% this version consumes lot of time!!need optimization
%% -------------written by Meng Zhou, Aug-06-2013----------------

%% get the array of unit vector of magnetic field
nx=size(bx,2);
ny=size(bx,1);
nvector=zeros(nx,ny,3);
bt=sqrt(bx.^2+by.^2+bz.^2);
tmp=bx./bt;
nvector(:,:,1)=tmp';
tmp=by./bt;
nvector(:,:,2)=tmp';
tmp=bz./bt;
nvector(:,:,3)=tmp';
% for i=1:nx
%     for j=1:ny
%         nvector(i,j,1)=bx(j,i)/sqrt(bx(j,i)^2+by(j,i)^2+bz(j,i)^2);
%         nvector(i,j,2)=by(j,i)/sqrt(bx(j,i)^2+by(j,i)^2+bz(j,i)^2);
%         nvector(i,j,3)=bz(j,i)/sqrt(bx(j,i)^2+by(j,i)^2+bz(j,i)^2);
%     end
% end
nvector=reshape(nvector,nx*ny,3);
%%
nn=size(pres,1);
if nn~=nx*ny, error('the size of data are mismatch!'); end
pp=zeros(nn,6);
%%
% otherdim=[nvector(:,2),-nvector(:,1),zeros(nn,1)];
% otherdim(:,1)=otherdim(:,1)./sqrt(dot(otherdim,otherdim,2));
% otherdim(:,2)=otherdim(:,2)./sqrt(dot(otherdim,otherdim,2));
% otherdim(:,3)=otherdim(:,3)./sqrt(dot(otherdim,otherdim,2));
% %%
% nperp1=cross(nvector,otherdim,2);
% nperp1(:,1)=nperp1(:,1)/sqrt(dot(nperp1,nperp1,2));
% nperp1(:,2)=nperp1(:,2)/sqrt(dot(nperp1,nperp1,2));
% nperp1(:,3)=nperp1(:,3)/sqrt(dot(nperp1,nperp1,2));
% %%
% nperp2=cross(nb,nperp1,2);
% nperp2(:,1)=nperp2(:,1)/sqrt(dot(nperp2,nperp2,2));
% nperp2(:,2)=nperp2(:,2)/sqrt(dot(nperp2,nperp2,2));
% nperp2(:,3)=nperp2(:,3)/sqrt(dot(nperp2,nperp2,2));
%%
% for i=1:nn
%     M=[nperp1(i,:);nperp2(i,:);nb(i,:)];
%     %%
%     tmp=pres(i,:);
%     ptmp=[tmp(1),tmp(2),tmp(3);tmp(2),tmp(4),tmp(5);tmp(3),tmp(5),tmp(6)];
%     pfac=M*ptmp*M';
%     pp(i,:)=[pfac(1,1),pfac(1,2),pfac(1,3),pfac(2,2),pfac(2,3),pfac(3,3)];
% %     
% end
for i=1:nn
 %% first construct the coordinate system  
    nb=nvector(nn,:);
%     theta=acos(dot(nb,[0,0,1]))*180/pi;
%     if theta>10&&theta<170, 
%         otherdim=[0,0,1];
%     else
%         otherdim=[1,0,0];
%     end
   otherdim=[nb(2),-nb(1),0];
   otherdim=otherdim/sqrt(dot(otherdim,otherdim));
    %%
    nperp1=cross(nb,otherdim);
    nperp1=nperp1/sqrt(dot(nperp1,nperp1));
    nperp2=cross(nb,nperp1);
    nperp2=nperp2/sqrt(dot(nperp2,nperp2));
    M=[nperp1;nperp2;nb];
    %%
    tmp=pres(i,:);
    ptmp=[tmp(1),tmp(2),tmp(3);tmp(2),tmp(4),tmp(5);tmp(3),tmp(5),tmp(6)];
    pfac=M*ptmp*M';
    pp(i,:)=[pfac(1,1),pfac(1,2),pfac(1,3),pfac(2,2),pfac(2,3),pfac(3,3)];
end
%%

    
    
    
    
    

