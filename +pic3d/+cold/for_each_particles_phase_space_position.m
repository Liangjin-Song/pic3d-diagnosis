%% the loop for particles id, and plot the particle's position in the distribution function
clear;
%% parameters
indir = 'E:\Asym\dst1\data';
outdir = 'E:\Asym\dst1\out\Kinetic\Trajectory\Group\Cold_Ions\Group9';
prm=slj.Parameters(indir,outdir);

%% particles' id
file = 'id.txt';

%% distribution function name
tt=30;
name=['PVh_ts',num2str(tt/prm.value.wci),'_x600-1400_y418-661_z0-1'];

%% distribution function range
xrange=[25.3,25.5];
zrange=[2,3];
yrange=[-100,100];
precision=80;

%% the figure style
range=2;
extra.colormap='moon';
extra.xrange=[-range,range];
extra.yrange=[-range,range];
extra.log=true;

%% show figure or not
show = false;

%% read the particles' id
cd(outdir);
ids = uint64(load(file));

%% species name
if name(3) == 'l'
    sfx='ih';
elseif name(3) == 'h'
    sfx='ic';
elseif name(3) == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end

%% read the distribution function
spc=prm.read(name);
spc=spc.subposition(xrange,yrange,zrange);


%% loop
nid = length(ids);
for i=1:nid
    %% read data
    id = ids(i);
    
    %% set the directory
    cd(outdir);
    slj.Utility.exist_directory(num2str(id));
    iddir=[outdir,'\', num2str(id)];
    
    %% plot figure
    for vdir=1:3
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
        dst=spc.dstv(prm.value.vA,precision);
        dst=dst.intgrtv(vdir);
        extra.title=['\Omega_{ci}t = ', num2str(dst.time)];
        %% plot figure
        %% the distribution function
        f=figure('Visible', show);
        slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
        %% the particle's position
        in = find(spc.value.id == id);
        hold on
        if vdir == 1
            plot(spc.value.vy(in)/prm.value.vA, spc.value.vz(in)/prm.value.vA, '*k', 'LineWidth', 2);
        elseif vdir == 2
            plot(spc.value.vx(in)/prm.value.vA, spc.value.vz(in)/prm.value.vA, '*k', 'LineWidth', 2);
        else
            plot(spc.value.vx(in)/prm.value.vA, spc.value.vy(in)/prm.value.vA, '*k', 'LineWidth', 2);
        end
        hold off
        %% print the figure
        cd(iddir);
        print('-dpng','-r300',[num2str(id),'_',name,suffix,'_sub',num2str(xrange(1)),'-',num2str(xrange(2)),...
            '_',num2str(yrange(1)),'-',num2str(yrange(2)),...
            '_',num2str(zrange(1)),'-',num2str(zrange(2)),'.png']);
        close(f);
    end
end
