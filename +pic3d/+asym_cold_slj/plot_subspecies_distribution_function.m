%% function plot_subspecies_distribution_function
outdir='E:\Asym\dst1\out\Kinetic\Distribution\Cold_Ions\X-line\t=13\Group3';
name = 'PVh_ts17600_x600-1400_y418-661_z0-1';
dir=1:3;
precision=80;
%% the figure style
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
spc=prm.read(name);
spc=spc.subspecies(id);

nv=length(dir);
for i=1:nv
    vdir=dir(i);
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