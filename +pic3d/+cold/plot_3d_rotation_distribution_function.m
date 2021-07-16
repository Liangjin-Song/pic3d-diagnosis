% function plot_3d_rotation_distribution_function()
%%
% writen by Liangjin Song on 20210715
% Plot the the three-dimensional rotation distribution function
%% 
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Oral';
prm=slj.Parameters(indir, outdir);

%% the distribution function name
% nic='PVh_ts51300_x1980-2020_y993-1008_z0-1';
% ni='PVl_ts51300_x1980-2020_y993-1008_z0-1';
% ne='PVe_ts51300_x1980-2020_y993-1008_z0-1';
nic='PVh_ts102564_x1460-1505_y986-1015_z0-1';
ni='PVl_ts102564_x1460-1505_y986-1015_z0-1';
ne='PVe_ts102564_x1460-1505_y986-1015_z0-1';

%% 
el=10;
FrameRate=60;

%% for cold ions
name=nic;
extra.isovalue=250;
extra.presion=120;
extra.xlabel='Vic_x';
extra.ylabel='Vic_y';
extra.zlabel='Vic_z';
f1=plot_3d_distribution_function(prm, name, extra);
cd(outdir);
aviname=[name,'.avi'];
aviobj=VideoWriter(aviname);
aviobj.FrameRate=FrameRate;
open(aviobj);
for az=-45:310
    view(az,el);
    drawnow;
    currFrame=getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);

%% for ions
name=ni;
extra.isovalue=30;
extra.presion=40;
extra.xlabel='Vi_x';
extra.ylabel='Vi_y';
extra.zlabel='Vi_z';
f1=plot_3d_distribution_function(prm, name, extra);
cd(outdir);
aviname=[name,'.avi'];
aviobj=VideoWriter(aviname);
aviobj.FrameRate=FrameRate;
open(aviobj);
for az=-45:310
    view(az,el);
    drawnow;
    currFrame=getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);

%% for electrons
name=ne;
extra.isovalue=20;
extra.presion=30;
extra.xlabel='Ve_x';
extra.ylabel='Ve_y';
extra.zlabel='Ve_z';
f1=plot_3d_distribution_function(prm, name, extra);
cd(outdir);
aviname=[name,'.avi'];
aviobj=VideoWriter(aviname);
aviobj.FrameRate=FrameRate;
open(aviobj);
for az=-45:310
    view(az,el);
    drawnow;
    currFrame=getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);



function f=plot_3d_distribution_function(prm, name, extra)
dst=prm.read(name);
dst=dst.dstv(prm.value.vA, extra.presion);
value=dst.value;
for i=1:extra.presion
    value(:,:,i)=value(:,:,i)';
end
%% figure
f=slj.Plot();
f.isosurface(value, dst.ll, dst.ll, dst.ll, extra.isovalue, extra);
end
