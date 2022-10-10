%% writen by Liangjin on 20210112
% plot particles energy
%%
clear;
%% parameter
indir='E:\PIC\Cold-Ions\data';
outdir='E:\PIC\Cold-Ions\out\trajectory\energy';
nx=1200;
ny=800;
nz=1;
di=20;
name='cold_ions_id.txt';
Lx=nx/di;
Ly=ny/di;
% norm=0.5*0.000337*0.025*0.025;
norm=0.05/71111.390625;
%% particles
cd(indir);
prt=textread(name,'%s');
np=length(prt);
%% trajectory
for i=1:1
    cd(indir);
    % name=char(prt(i));
    name='trajh_id264924994.dat';
    tj=load(name);
    h=figure;
    plot(tj(:,1),tj(:,14)/norm,'k','LineWidth',2);
    xlabel('\Omega_{ci}t');
    ylabel('Particle Energy');
    set(gca,'FontSize',14);
    %%
    cd(outdir)
    print(h,'-r300','-dpng',[name(1:end-4),'_energy.png']);
    close(h);
end
