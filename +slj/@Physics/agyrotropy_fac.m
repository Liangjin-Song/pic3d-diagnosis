function [aphi, dng, q, pp_fac]=agyrotropy_fac(P, B, prm)
%%
% @info: writen by Liangjin Song on 20220820
% @brief: agyrotropy_fac - quantifying gyrotropy in the fac system
% @param: P -- pressure directly from the simulation
% @param: B -- the magnetic field directly from simulation
% @param: prm -- the Parameters
% @output
%%  aphi,dng and q are quantities to quantify the degree of agyrotropy.
%%   defined in papers of Scudder and Daughton (2008), Aunai et al., 2011
%%   and Swisdak et al., 2016.
%%  pp_fac: pressure tensor in the field aligned coordinate
%%  pp=[pxx,pxy,pxz,pyy,pyz,pzz];
%%
%% reshape the tensor to a matrix
pp = P.reshape_old(prm);
[aphi,dng,q,pp_fac]=simu_agyrotropy(pp,B.x,B.y,B.z);
end


function [aphi,dng,q,pp_fac]=simu_agyrotropy(pres,bx,by,bz)
%%
%%input
%%  pres: pressure tensor directly from simulation
%%  bx,by and bz are three components of magnetic field 
%%output
%%  aphi,dng and q are quantities to quantify the degree of agyrotropy.
%%   defined in papers of Scudder and Daughton (2008), Aunai et al., 2011
%%   and Swisdak et al., 2016.
%%  pp_fac: pressure tensor in the field aligned coordinate
%%  pp=[pxx,pxy,pxz,pyy,pyz,pzz];
%% here x,y are perpendicular to B0 while z is along B0. 
%% this version consumes lot of time!!need optimization
%% -------------written by Meng Zhou, Jan/30/2017----------------
%% -------------modified from a version in IDL----------------------

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
nvector=reshape(nvector,nx*ny,3);
%%
nn=size(pres,1);
if nn~=nx*ny, error('the size of data are mismatch!'); end
pp_fac=zeros(nn,6);
aphi=zeros(nn,1);
dng=zeros(nn,1);
q=zeros(nn,1);
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
    pp_fac(i,:)=[pfac(1,1),pfac(1,2),pfac(1,3),pfac(2,2),pfac(2,3),pfac(3,3)];
    %%
     %% calculate the eigenvalue of the pressure tensor in FAC
      theta=atan2(2*pfac(2,1),pfac(1,1)-pfac(2,2))/2;
      rot_eigen=[[cos(theta),sin(theta),0];[-sin(theta),cos(theta),0];[0,0,1]];
      peigen=rot_eigen*pfac*rot_eigen';
      %%
      lamda1=peigen(1,1);
      lamda2=peigen(2,2);
      aphi(i)=2*abs(lamda1-lamda2)/(lamda1+lamda2);
      
      %%
      %% calculate Dng and Q defined by Aunai and Swisdak,respectively
      theta=atan2((pfac(2,2)-pfac(1,1))/2,pfac(2,1))/2;
      rot_gyro=[[cos(theta),sin(theta),0];[-sin(theta),cos(theta),0];[0,0,1]];
      pgyro=rot_gyro*pfac*rot_gyro';
      %%
      dng(i)=sqrt(8*(pgyro(2,1)^2+pgyro(3,1)^2+pgyro(2,3)^2))/(pgyro(3,3)+2*pgyro(1,1));
      q(i)=sqrt((pgyro(2,1)^2+pgyro(3,1)^2+pgyro(2,3)^2)/(pgyro(1,1)^2+2*pgyro(1,1)*pgyro(3,3)));
end
%%
 aphi=reshape(aphi,nx,ny); aphi=aphi';
 dng=reshape(dng,nx,ny);  dng=dng';
 q=reshape(q,nx,ny);      q=q';
end 