%% plot the particle's vz as the function of the time
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\X-line\common';
file=[outdir,'\15-16-common_particle.txt'];

%% read data
cd(indir);
prm=Parameters(indir,outdir);
id=uint64(load(file));
nid=length(id);

%% loop
for i=1:nid
    cd(indir);
    prt=prm.read_data(['trajh_id',num2str(id(i))]);
    f=figure;
    vz=prt.value.vz/prm.value.vA;
    plot(prt.value.time,vz,'-k','LineWidth',2);
    xlabel('\Omega_{ci}t');
    ylabel('Vic_z [v_A]');
    set(gca,'FontSize',14);
    xlim([14,20]);
    cd(outdir);
    print(f,'-dpng','-r300',['trajh_id',num2str(id(i)),'_time_vz.png']);
    close(f);
end