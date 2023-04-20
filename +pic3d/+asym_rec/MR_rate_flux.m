% function MR_rate_flux
%%
% @info: writen by Liangjin Song on 20210907
% @brief: plot the reconnection rate 
%%
clear;
%% parameters
% directory
indir='E:\Asym\case1\data';
outdir='E:\Asym\case1\out\Global';
prm=slj.Parameters(indir,outdir);
% time
dt=1;
% tt=[0:dt:36, 37:dt:100];
tt = 0:dt:100;

%% the loop
nt=length(tt);
flux=zeros(1,nt);
for t=1:nt
    %% read data
    B=prm.read('B',tt(t));
    %% the current sheet index in z-direction
    [~,inz]=min(abs(B.x));
    %% the bz value at the current sheet
    lbz=zeros(1,prm.value.nz);
    for i=1:prm.value.nx
        lbz(i)=B.z(inz(i),i);
    end
    %% find the RF position
    [~,lrf]=max(lbz);
    [~,rrf]=min(lbz);
    %% the x-line position
%     [~,ix]=min(abs(lbz(lrf:rrf)));
%     ix=ix+lrf-1;
    % ix=prm.value.nx/2+20;
    ix = prm.value.nx/2;
    iz=inz(ix);
    %% the magnetic flux along the current sheet
    flux(t)=sum(lbz(1:ix),'All');
end
b0=abs(prm.value.bm-prm.value.bs)/2;
nflux=flux*prm.value.fpi/b0;
f1=figure;
plot(tt,nflux,'-k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('\Psi [B_0/\omega_{pi}]');
xlim([tt(1) tt(end)]);
set(gca,'FontSize',16);
cd(outdir);
print(f1,'-dpng','-r300','magnetic_flux.png');

rate=flux(2:end)-flux(1:end-1);
nrate=rate/(prm.value.vA*dt/prm.value.wci);
f2=figure;
plot(tt(1:end-1),nrate,'-r','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('E_R');
xlim([tt(1) tt(end)-1]);
set(gca,'FontSize',14);
cd(outdir);
print(f2,'-dpng','-r300','MR_rate_by_flux.png');
% end