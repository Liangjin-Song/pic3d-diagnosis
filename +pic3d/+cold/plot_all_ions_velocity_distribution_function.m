%% plot all ions velocity distribution function
clear;
%% parameters
% directory
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Distribution_Function\Diagnose\DF\Other';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
% name1='PVl_ts51300_x1980-2020_y993-1008_z0-1';
% name2='PVh_ts51300_x1980-2020_y993-1008_z0-1';
name1='PVh_ts102564_x1460-1505_y986-1015_z0-1';
name2='PVl_ts102564_x1460-1505_y986-1015_z0-1';
% velocity direction
vdir=1;
%% the figure style
range=5;
extra.colormap='moon';
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;
% extra.caxis=[0,4000];
if vdir==1
    extra.xlabel='Vi_y [V_A]';
    extra.ylabel='Vi_z [V_A]';
    suffix='_vx_vx';
elseif vdir == 2
    extra.xlabel='Vi_x [V_A]';
    extra.ylabel='Vi_z [V_A]';
    suffix='_vx_vy';
else
    extra.xlabel='Vi_x [V_A]';
    extra.ylabel='Vi_y [V_A]';
    suffix='_vx_vz';
end
%% read data
spc1=prm.read(name1);
spc2=prm.read(name2);

%% merge
% the number of particles
n1=length(spc1.value.id);
n2=length(spc2.value.id);
nn=n1+n2;

% value
name=[name1(1:2),'i',name1(4:end)];
time=spc1.time;
range=spc1.range;
% value.id=zeros(1,nn);
% value.vx=zeros(1,nn);
% value.vy=zeros(1,nn);
% value.vz=zeros(1,nn);
% value.rx=zeros(1,nn);
% value.ry=zeros(1,nn);
% value.rz=zeros(1,nn);
% set value
value.id=[spc1.value.id, spc2.value.id];
value.vx=[spc1.value.vx, spc2.value.vx];
value.vy=[spc1.value.vy, spc2.value.vy];
value.vz=[spc1.value.vz, spc2.value.vz];
value.rx=[spc1.value.rx, spc2.value.rx];
value.ry=[spc1.value.ry, spc2.value.ry];
value.rz=[spc1.value.rz, spc2.value.rz];

spc=slj.Species(name, time, range, value);

dst=spc.dstv(prm.value.vA);
dst=dst.intgrtv(vdir);

%% plot figure
% f=slj.Plot();
slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
% f.png(prm,[name,suffix]);