% function MR_rate_Ey
%%
% @info: writen by Liangjin Song on 20210802
% @brief: plot the reconnection rate 
%%
% clear;
%% parameters
% directory
indir='E:\Simulation\Cold2_ds1_large\data';
outdir='E:\Simulation\Cold2_ds1_large\out\Global';
prm=slj.Parameters(indir,outdir);
% time
dt=0.5;
tt=0:dt:70;
% the box size
nx=10;
nz=10;

%% the loop
nt=length(tt);
rate=zeros(1,nt);
iix=zeros(1,nt);
iiz=zeros(1,nt);
for t=1:nt
    %% read data
    B=prm.read('B',tt(t));
    E=prm.read('E',tt(t));
    Ey=E.y;
    %% the current sheet index in z-direction
    [~,inz]=min(abs(B.x));
    %% the bz value at the current sheet
%     lbz=zeros(1,prm.value.nz);
%     for i=1:prm.value.nx
%         lbz(i)=B.z(inz(i),i);
%     end
    %% find the RF position
%     [~,lrf]=max(lbz);
%     [~,rrf]=min(lbz);
    %% the x-line position
%     [~,ix]=min(abs(lbz(lrf:rrf)));
%     ix=ix+lrf-1;
    % ix=prm.value.nx/2+20;
%     iz=inz(ix);
    ix=prm.value.nx/2;
%     iz=prm.value.nz/2;
    lbx = B.x(:,ix);
    [~,iz]=min(abs(lbx));
    %% the reconnection electric field in a box
    Ey=Ey(iz-nz:iz+nz,ix-nx:ix+nx);
    rate(t)=mean(Ey(:));
end
rate=rate/prm.value.vA;
f=figure;
plot(tt,-rate,'-k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('Ey');
xlim([tt(1) tt(end)]);
set(gca,'FontSize',16);
cd(outdir);
print('-dpng','-r300','MR_rate_by_Ey.png');
% end