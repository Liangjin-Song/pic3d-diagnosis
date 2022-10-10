%plot the velocity distribution in 2D rec simulation
x0=20; y0=3;  
di=40;
dr=0.1;
%
xmax=fix((x0+dr)*di);
xmin=fix((x0-dr)*di);
ymax=fix((y0+dr)*di);
ymin=fix((y0-dr)*di);
%
b0(1)=mean(mean(Bx013_60(ymin:ymax,xmin:xmax)));
b0(2)=mean(mean(By013_60(ymin:ymax,xmin:xmax)));
b0(3)=mean(mean(Bz013_60(ymin:ymax,xmin:xmax)));
plot_veldist(diste5_013_60, 1,2,0.03,b0);
plot_veldist(diste5_013_60,1,3,0.03,b0);
