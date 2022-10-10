function mv_1d(file,Lx,Lv,nt)
%for the flash show of space-phase diagram of 
%1d simulation
%parameters,should input correctly!
%
%--------written by M.Zhou, at SDCC-----------
tag=length(file)-7; %assuming the format of 
%  file name is 'ABC*123*.dat'
%
for i=1:nt
   %transfer the number to string
    if i<=10,
        file(tag+3)=num2str(i-1);
    elseif i>10 & i<100
        file(tag+2:tag+3)=num2str(i-1);
    else
        file(tag+1:tag+3)=num2str(i-1);
    end
    %
   pp=importdata(file);
   ndv=size(pp,1)-1;
   ndx=size(pp,2);
   xx=0:Lx/ndx:Lx-Lx/ndx;
   vv=-Lv/2:Lv/ndv:Lv/2;
%
imagesc(xx,vv,pp); colorbar; 
mov(i)=getframe(gcf);  
end
movie2avi(mov,'Phase Space Diagram.avi','fps',4)


