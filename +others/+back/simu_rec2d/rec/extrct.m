function ee=extrct(epar,potent,v)
%extract the data from the diagram
ndx=length(epar(1,:));
ndy=length(epar(:,1));
[ix,iy]=rec_index(potent,v);
N=length(ix);
ee=zeros(N,1);
%calculate the extracted data in a vector
for m=1:N
    i=fix(ix(m));
    j=fix(iy(m));
    i1=i+1;
    j1=j+1;
    if i1>ndx
        i1=1;
    end
    if j1>ndy
        j1=1;
    end
    sx=ix(m)-i;
    sy=iy(m)-j;
    %
    ee(m)=epar(j,i)*(1-sx)*(1-sy)+epar(j,i1)*sx*(1-sy)+...
          epar(j1,i1)*sx*sy+epar(j1,i)*(1-sx)*sy;
end
figure
plot(ee)
    
    