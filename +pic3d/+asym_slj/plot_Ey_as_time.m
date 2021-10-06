% function plot_Ey_as_time
clear;
%% parameters
indir='E:\Asym\NCold\data';
outdir='E:\Asym\NCold\out\Global';
prm=slj.Parameters(indir,outdir);

tt=1:199;
dt=1;
name='l';

q=prm.value.qi;
m=prm.value.mi;

norm=prm.value.vA;

% the box size
nx=4;
nz=4;

%% the loop
nt=length(tt);
rate=zeros(5,nt);

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
    rate(1,t)=mean(Ey(:));
    [vxB, divP, nvv, nvt] = slj.Physics.momentum_equation(prm, name, tt(t), dt, q, m);
    rate(2,t)=mean(vxB.y(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(3,t)=mean(divP.y(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(4,t)=mean(nvv.y(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(5,t)=mean(nvt.y(iz-nz:iz+nz,ix-nx:ix+nx),'all');
end

rate=rate/prm.value.vA;
tot=rate(2,:)+rate(3,:)+rate(4,:)+rate(5,:);
f=figure;
plot(tt,-rate(1,:),'-k','LineWidth',2); hold on
plot(tt,-rate(2,:),'-r','LineWidth',2);
plot(tt,-rate(3,:),'-g','LineWidth',2);
plot(tt,-rate(4,:),'-b','LineWidth',2);
plot(tt,-rate(5,:),'-m','LineWidth',2);
plot(tt,-tot,'--k','LineWidth',2); hold off
legend('Ey', '-V\times B', '\nabla \cdot P/qn','m/qn\nabla\cdot(nVV)','m/qn \partial nV/\partial t','Sum','Location','Best');
xlabel('\Omega_{ci}t');
ylabel('Ey');
set(gca,'FontSize',16);
cd(outdir);
% print('-dpng','-r300','MR_rate_by_Ey.png');

