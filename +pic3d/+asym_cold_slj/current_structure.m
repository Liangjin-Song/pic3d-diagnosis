% function current_structure
clear;
%% parameters
indir1='E:\Asym\Cold\data';
outdir1='E:\Asym\Cold\out\Global';
prm1=slj.Parameters(indir1,outdir1);
indir2='E:\Asym\NCold\data';
outdir2='E:\Asym\NCold\out\Global';
prm2=slj.Parameters(indir2,outdir2);

tt=100;
dir=1;

B1=prm1.read('B',tt);
B2=prm2.read('B',tt);
%% the current sheet index in z-direction
[~,inz]=min(abs(B1.x));
%% the bz value at the current sheet
lbz=zeros(1,prm1.value.nz);
for i=1:prm1.value.nx
    lbz(i)=B1.z(inz(i),i);
end
%% find the RF position
[~,lrf]=max(lbz);
[~,rrf]=min(lbz);
%% the x-line position
[~,ix1]=min(abs(lbz(lrf:rrf)));
ix1=ix1+lrf-1;
iz1=inz(ix1);

%% the current sheet index in z-direction
[~,inz]=min(abs(B2.x));
%% the bz value at the current sheet
lbz=zeros(1,prm2.value.nz);
for i=1:prm2.value.nx
    lbz(i)=B2.z(inz(i),i);
end
%% find the RF position
[~,lrf]=max(lbz);
[~,rrf]=min(lbz);
%% the x-line position
[~,ix2]=min(abs(lbz(lrf:rrf)));
ix2=ix2+lrf-1;
iz1=inz(ix2);

x1=prm1.value.lx(ix1);
x2=prm2.value.lx(ix2);

J1=prm1.read('J',tt);
J2=prm2.read('J',tt);

lj1=J1.get_line2d(x1,dir,prm1,prm1.value.qi*prm1.value.n0*prm1.value.vA);
lj2=J2.get_line2d(x2,dir,prm2,prm2.value.qi*prm2.value.n0*prm2.value.vA);
figure;
plot(prm2.value.lz,lj2.ly,'-r','LineWidth',1.5); hold on
plot(prm1.value.lz,lj1.ly,'-b','LineWidth',1.5);
xlim([-10,10]);
xlabel('\Omega_{ci}t');
ylabel('Jy');
legend('Case 2','Case 1');
set(gca,'FontSize',14);

%%
Vl1=prm1.read('Vl',tt);
Nl1=prm1.read('Nl',tt);
Vh1=prm1.read('Vh',tt);
Nh1=prm1.read('Nh',tt);
Ve1=prm1.read('Ve',tt);
Ne1=prm1.read('Ne',tt);
Jl1=slj.Scalar(Vl1.y.*Nl1.value);
Jh1=slj.Scalar(Vh1.y.*Nh1.value);
Je1=slj.Scalar(-Ve1.y.*Ne1.value);
jl1=Jl1.get_line2d(x1,dir,prm1,prm1.value.n0*prm1.value.vA);
jh1=Jh1.get_line2d(x1,dir,prm1,prm1.value.n0*prm1.value.vA);
je1=Je1.get_line2d(x1,dir,prm1,prm1.value.n0*prm1.value.vA);
figure;
plot(prm1.value.lz,lj1.ly,'-k','LineWidth',1.5); hold on
plot(prm1.value.lz,jl1,'-r','LineWidth',1.5);
plot(prm1.value.lz,je1,'-g','LineWidth',1.5);
plot(prm1.value.lz,jh1,'-b','LineWidth',1.5);
xlim([-10,10]);
xlabel('\Omega_{ci}t');
ylabel('Jy');
legend('Jy','Jih','Je','Jic');
set(gca,'FontSize',14);

%%
Vl2=prm2.read('Vl',tt);
Nl2=prm2.read('Nl',tt);
Vh2=prm2.read('Vh',tt);
Nh2=prm2.read('Nh',tt);
Ve2=prm2.read('Ve',tt);
Ne2=prm2.read('Ne',tt);
Jl2=slj.Scalar(Vl2.y.*Nl2.value);
Jh2=slj.Scalar(Vh2.y.*Nh2.value);
Je2=slj.Scalar(-Ve2.y.*Ne2.value);
jl2=Jl2.get_line2d(x2,dir,prm2,prm2.value.n0*prm2.value.vA);
jh2=Jh2.get_line2d(x2,dir,prm2,prm2.value.n0*prm2.value.vA);
je2=Je2.get_line2d(x2,dir,prm2,prm2.value.n0*prm2.value.vA);
figure;
plot(prm2.value.lz,lj2.ly,'-k','LineWidth',1.5); hold on
plot(prm2.value.lz,jl2,'-r','LineWidth',1.5);
plot(prm2.value.lz,je2,'-g','LineWidth',1.5);
plot(prm2.value.lz,jh2,'-b','LineWidth',1.5);
xlim([-10,10]);
xlabel('\Omega_{ci}t');
ylabel('Jy');
legend('Jy','Jih','Je','Jic');
set(gca,'FontSize',14);