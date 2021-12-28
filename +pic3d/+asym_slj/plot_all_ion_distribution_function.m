%% function plot_two_group_distribution_function
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Distribution\Ions\Sphere';
prm=slj.Parameters(indir, outdir);

%% the particles' distribution function name
tt=20;
name1=['PVl_ts',num2str(tt/prm.value.wci),'_x600-1400_y418-661_z0-1'];
name2=['PVl_ts',num2str(tt/prm.value.wci),'_x600-1400_y418-661_z0-1'];
name='PVi';
%% position
xrange=[24.5,25.5];
zrange=[-3,-2];
yrange=[-100,100];
precision=80;

%% figure style
range=8;
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
elseif name(3) == 'i'
    sfx = 'i';
else
    error('Parameters Error!');
end

%% read data
spc1=prm.read(name1);
spc2=prm.read(name2);

%% subspecies
spc1=spc1.subposition(xrange,yrange,zrange);
spc2=spc2.subposition(xrange,yrange,zrange);
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
%     print('-dpng','-r300',[name,suffix,'_subspecies.png']);
%     close(f); 
end