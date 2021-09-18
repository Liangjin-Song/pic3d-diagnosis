%% for batch process of particle distribution in simulation
Lx=102.4;
Lz=102.4;
dr=0.08;
norm=0.04;
shift=30;
%%
x0=[11.8,13.2,11.0];
z0=[76.8,76.2,77.5];
pnumber=[2,4,5];
tt=46;
species='e';
%%
dirr_dist='H:\island coalescence\Bg=0.5new\dist\';
dirr_mag='H:\island coalescence\Bg=0.5\';
outdir='F:\lab ppt\manucript\Zhou_JGR_2013b\';
%%
np=length(x0);
nt=length(tt);
for j=1:nt
    cd(dirr_mag)
%     bx=load(['Bx_t',num2str(tt(j),'%3.3d'),'.00.txt']);
%     by=load(['By_t',num2str(tt(j),'%3.3d'),'.00.txt']);
%     bz=load(['Bz_t',num2str(tt(j),'%3.3d'),'.00.txt']);
      load(['Bx_t',num2str(tt(j),'%3.3d'),'_00.mat']);
      eval(['bx=Bx_t',num2str(tt(j),'%3.3d'),'_00;'])
      load(['By_t',num2str(tt(j),'%3.3d'),'_00.mat']);
      eval(['by=By_t',num2str(tt(j),'%3.3d'),'_00;'])
      load(['Bz_t',num2str(tt(j),'%3.3d'),'_00.mat']);
      eval(['bz=Bz_t',num2str(tt(j),'%3.3d'),'_00;'])
    %%
    cd(dirr_dist)
    for i=1:np
     nb=get_unitB(bx,by,bz,Lx,Lz,dr,x0(i),z0(i));
     dist=load(['dist',species,num2str(pnumber(i),'%1.1d'),'_t',num2str(tt(j),'%3.3d'),'.00.txt']);
     if isempty(dist)==0
     [h1,h2]=plot_veldist4(dist,norm,nb); 
     %%
%      text(-0.5,20,['x=',num2str(x0(i),'%4.3d'),',z=',num2str(z0(i),'%4.3d'),...
%          ',t\omega_{ci}=',num2str(tt(j),'%3.3d')],'fontsize',13);
     x11=x0(i)+shift;
     z11=z0(i)-51.2;
     title(h1,['x=',num2str(x11,'%4.1f'),',z=',num2str(z11,'%4.1f'),...
         [',t\omega_{ci}=',num2str(tt(j),'%3.3d')]],'fontsize',13)
     fname=['dist',species,num2str(pnumber(i),'%1.1d'),'_t',num2str(tt(j),'%3.3d'),'_00'];
     print('-r300','-dpsc',[outdir,fname])
     close(gcf)
     end
    end
end


