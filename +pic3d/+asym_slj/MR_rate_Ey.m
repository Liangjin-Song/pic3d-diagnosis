% function MR_rate_Ey
%%
% @info: writen by Liangjin Song on 20210802
% @brief: plot the reconnection rate 
%%
clear;
%% parameters
% directory
<<<<<<< Updated upstream
indir='E:\PIC\Asym\Asym_cold\data';
outdir='E:\PIC\Asym\Asym_cold\out\Global';
=======
indir='E:\Asym\asym_cold_Nr2\data';
outdir='E:\Asym\asym_cold_Nr2\out\Global';
>>>>>>> Stashed changes
prm=slj.Parameters(indir,outdir);
% time
tt=0:200;
% the box size
nx=0;
nz=0;

%% the loop
nt=length(tt);
rate=zeros(1,nt);
for t=1:nt
    %% read data
    B=prm.read('B',tt(t));
    E=prm.read('E',tt(t));
    Ey=E.y;
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
    %% the reconnection electric field in a box
    Ey=Ey(iz-nz:iz+nz,ix-nx:ix+nx);
    rate(t)=mean(Ey(:));
end
rate=rate/prm.value.vA;
<<<<<<< Updated upstream
plot(tt,rate,'-k','LineWidth',2);
=======
f=figure;
plot(tt,-rate,'-k','LineWidth',2);
>>>>>>> Stashed changes
xlabel('\Omega_{ci}t');
ylabel('Ey');
set(gca,'FontSize',16);
cd(outdir);
<<<<<<< Updated upstream
print('-dpng','-r300','MR_rate_by_Ey.png');
=======
print('-dpng','-r300','MR_rate_Ey.png');
>>>>>>> Stashed changes
% end