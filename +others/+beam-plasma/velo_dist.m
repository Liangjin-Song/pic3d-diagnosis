function [vmean,vth]=velo_dist(Dist,i,tag)
%for the velocity distribution,tag can be a vector
%tag used to indicate which kind of species are ploted.
%Dist=load(file);
N=length(Dist(:,1));
ndv=length(Dist(1,:));
ndy=2;%total number of species
%ion=0;%the number of species of ions
t=N/ndy;
%i=0;%select the time to plot
Lv(1)=20.;
Lv(2)=20.;
Lv(3)=10.;
%Lv(4)=1.;%the maximun of velocity
%tag=0;%control parameter
%nor=10000;%for nomarlization
%
dd=zeros(ndy,ndv);
ndv1=ndv-1;
for j=1:ndy
dd(j,:)=Dist(i*ndy+j,:);
dd(j,:)=dd(j,:)/sum(dd(j,:));
end
%dd=dd/nor;
%
 m=length(tag);
 if m==1
    vv=-Lv(tag):2*Lv(tag)/ndv1:Lv(tag);
    plot(vv,dd(tag,:));
    vmean=sum(dd(tag,:).*vv);
    vth=sqrt(sum(dd(tag,:).*vv.^2)-vmean.^2);
 else
     for j=1:ndv
         dd(1,j)=sum(dd(tag,j));
     end
     vv=-Lv(tag(1)):2*Lv(tag(1))/ndv1:Lv(tag(1));
     plot(vv,dd(1,:));
     vmean=sum(dd(1,:).*vv)/2;
     vth=sqrt(sum(dd(1,:).*vv.^2)/2-vmean^2);
 end
    
      
