function phase2d(phase,vmax,ndv,tag)
%plot the 2d phase-space diagram 
% the x-y-vx  
ndy=length(phase(1,:));
N=length(phase(:,1));
ndx=N/ndv;
%
if tag==0 %out put the x_vx relation which integrate in the y direction
for i=1:N
    ph(i)=sum(phase(i,:));
end
ph=reshape(ph,ndx,ndv);
ph=ph';
for i=1:ndx
    ph(:,i)=ph(:,i)/sum(ph(:,i));
end
ndr=ndx;
%
else %out put the y_vx relation which integrate in the x direction
    for i=1:ndy
        pp=reshape(phase(:,i),ndx,ndv);
        for j=1:ndv
            ph(j,i)=sum(pp(:,j));
        end
    end
  ndr=ndy;
end
%
vv=-vmax:2*vmax/(ndv-1):vmax;
xx=0:ndr-1;
[X,Y]=meshgrid(xx,vv);
pcolor(X,Y,ph);colorbar;shading flat;
