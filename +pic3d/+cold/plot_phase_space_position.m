% function plot_phase_space_position()
%%
% plot the particle's position in the velocity phase space
% writen by Liangjin Song on 20210628
%%
% clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Hot_ion\Island\Electron';
prm=slj.Parameters(indir,outdir);
file=[outdir,'\common.txt'];
name='PVl_ts99359_x2057-2193_y984-1009_z0-1';
%% figure properties
extra.precv=100;
extra.range=25;
extra.xrange=[-extra.range,extra.range];
extra.yrange=[-extra.range,extra.range];
extra.colormap='moon';
extra.log=true;
%% read data
cd(indir);
% id=uint64(load(file));
id=uint64(16190174);
dst=prm.read(name);
dsta=dst.dstv(prm.value.vA, extra.precv);
% id=intersect(id,dst.value.id);
nid=length(id);
%% loop
for i=1:nid
    cd(indir);
    in=find(dst.value.id==id(i));
    v.x=dst.value.vx(in)/prm.value.vA;
    v.y=dst.value.vy(in)/prm.value.vA;
    v.z=dst.value.vz(in)/prm.value.vA;
    cd(outdir);
    f=figure;
    plot_distribution_function(dsta,extra,1);
    hold on
    plot(v.y,v.z,'*g','LineWidth',5);
    print(f,'-dpng','-r300',[num2str(id(i)),'_y-z_position_',name,'.png']);
    close(f);
    f=figure; 
    plot_distribution_function(dsta,extra,2);
    hold on
    plot(v.x,v.z,'*g','LineWidth',5);
    print(f,'-dpng','-r300',[num2str(id(i)),'_x-z_position_',name,'.png']);
    close(f)
    f=figure; 
    plot_distribution_function(dsta,extra,3);
    hold on
    plot(v.x,v.y,'*g','LineWidth',5);
    print(f,'-dpng','-r300',[num2str(id(i)),'_x-y_position_',name,'.png']);
    close(f)
end

function plot_distribution_function(pv,extra,dir)
if dir==1
    extra.xlabel='Vic_y';
    extra.ylabel='Vic_z';
elseif dir == 2
    extra.xlabel='Vic_x';
    extra.ylabel='Vic_z';
else
    extra.xlabel='Vic_x';
    extra.ylabel='Vic_y';
end
dst=pv.intgrtv(dir);
extra.xrange=[-extra.range,extra.range];
extra.yrange=[-extra.range,extra.range];
slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
end