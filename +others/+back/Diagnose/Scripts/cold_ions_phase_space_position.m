%% plot the particle's vz as the function of the time
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\Island\common';
file=[outdir,'\common.txt'];
name='PVh_ts96200_x1513-1560_y986-1015_z0-1';
%% read data
cd(indir);
prm=Parameters(indir,outdir);
id=uint64(load(file));
dst=prm.read_data(name);
dsta=dst.distribution_function(prm);
% id=intersect(id,dst.value.id);
nid=length(id);
extra.range=1.5;
%% loop
for i=1:nid
    cd(indir);
    in=find(dst.value.id==id(i));
    v.x=dst.value.vx(in)/prm.value.vA;
    v.y=dst.value.vy(in)/prm.value.vA;
    v.z=dst.value.vz(in)/prm.value.vA;
    fig=Figures.draw(prm, dsta, extra);
    cd(outdir);
    f=figure(1); hold on
    plot(v.y,v.z,'*k','LineWidth',5);
    print(f,'-dpng','-r300',[num2str(id(i)),'_y-z_position.png']);
    close(f);
    f=figure(2); hold on
    plot(v.x,v.z,'*k','LineWidth',5);
    print(f,'-dpng','-r300',[num2str(id(i)),'_x-z_position.png']);
    close(f)
    f=figure(3); hold on
    plot(v.x,v.y,'*k','LineWidth',5);
    print(f,'-dpng','-r300',[num2str(id(i)),'_x-y_position.png']);
    close(f)
end