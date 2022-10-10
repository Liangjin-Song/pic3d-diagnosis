%% function plot_two_group_distribution_function
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Distribution\Cold_Ions\X-line\t=13\Group1&3';
prm=slj.Parameters(indir, outdir);

%% the particles' id of the two-group
gid1='E:\Asym\dst1\out\Kinetic\Distribution\Cold_Ions\X-line\t=13\Group1\id.mat';
gid2='E:\Asym\dst1\out\Kinetic\Distribution\Cold_Ions\X-line\t=13\Group3\id.mat';

%% distribution function
name = 'PVh_ts16000_x600-1400_y418-661_z0-1';
precision=100;

%% figure style
range=2;
extra.colormap='moon';
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;

if name(3) == 'l'
    sfx='ih';
elseif name(3) == 'h'
    sfx='ic';
elseif name(3) == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end

%% read data
gid1=importdata(gid1);
gid2=importdata(gid2);
spcs=prm.read(name);

%% subspecies
spc1=spcs.subspecies(gid1);
spc2=spcs.subspecies(gid2);
spc = spc1.add(spc2);

for vdir = 1:3
    if vdir==1
        extra.xlabel=['V',sfx,'_y [V_A]'];
        extra.ylabel=['V',sfx,'_z [V_A]'];
        suffix='_vy_vz';
    elseif vdir == 2
        extra.xlabel=['V',sfx,'_x [V_A]'];
        extra.ylabel=['V',sfx,'_z [V_A]'];
        suffix='_vx_vz';
    else
        extra.xlabel=['V',sfx,'_x [V_A]'];
        extra.ylabel=['V',sfx,'_y [V_A]'];
        suffix='_vx_vy';
    end
    
    %% distribution
    dst=spc.dstv(prm.value.vA,precision);
    dst=dst.intgrtv(vdir);
    extra.title=['\Omega_{ci}t = ', num2str(dst.time)];
    %% plot figure
    cd(outdir);
    f=figure;
    slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
    print('-dpng','-r300',[name,suffix,'_subspecies.png']);
    close(f); 
end