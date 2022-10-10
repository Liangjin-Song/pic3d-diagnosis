function filed2d(ex,dt,i,j)
%plot the electric field for 2d simulation
N=length(ex(:,1));  %the length of simulation box
inv=4;
Lt=N/inv-1;
tt=0:dt:Lt*dt;
ee=ex(i:inv:N,j);
figure
plot(tt,ee,'k')
