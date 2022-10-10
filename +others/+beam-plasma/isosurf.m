function isosurf(phase,ndv,c)
%plot the isosurface in the phase-space diagram
N=length(phase(:,1));
M=length(phase(1,:));
ndx=N/ndv;
pp=zeros(N,M);
ph=zeros(ndv,ndx,M);
r=zeros(40000,3);
%
for k=1:M
    pp=phase(:,k);
    pt=reshape(pp,ndx,ndv);
    ph(:,:,k)=pt';
end
cn=0;
for k=1:M
    for j=1:ndx
        for i=1:ndv
            if ph(i,j,k)>=c&&ph(i,j,k)<c+1
                cn=cn+1;
                r(cn,1)=j;
                r(cn,2)=k;
                r(cn,3)=i;
            end 
            end 
        end
    end
  %plot the results
  plot3(r(1:cn,1),r(1:cn,2),r(1:cn,3),'r.')