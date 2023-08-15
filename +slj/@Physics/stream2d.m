function ss=stream2d(bx,bz)

ss=zeros(size(bx,1),size(bx,2));
for i=1:size(bx,1)
    for j=1:size(bx,2)
        ss(i,j)=sum(bx(1:i,j))-sum(bz(i,1:j));
    end
end
ss=ss-ss(1,1);
end