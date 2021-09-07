% function MR_rate_flux
%%
% @info: writen by Liangjin Song on 20210907
% @brief: plot the reconnection rate 
%%
clear;
%% parameters
% directory
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Global';
prm=slj.Parameters(indir,outdir);
% time
tt=0:200;

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
    [~,ix]=min(abs(lbz(lrf:rrf)));
    ix=ix+lrf-1;
    iz=inz(ix);
    %% the magnetic flux along the current sheet
    flux(t)=sum(lbz(1:ix),'All');
end
b0=abs(prm.value.bm-prm.value.bs)/2;
nflux=flux*prm.value.fpi/b0;
plot(tt,nflux,'-k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('\Psi [B_0/\omega_{pi}]');
set(gca,'FontSize',16);
cd(outdir);
print('-dpng','-r300','magnetic_flux.png');
% end