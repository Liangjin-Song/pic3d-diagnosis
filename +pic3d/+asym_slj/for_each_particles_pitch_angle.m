%% the loop for particles id, and plot the particle's pitchangle
clear;
%% parameters
indir = 'E:\Asym\dst1\data';
outdir = 'E:\Asym\dst1\out\Kinetic\Trajectory\Group\Cold_Ions\Group9';
prm=slj.Parameters(indir,outdir);

%% particles' id
file = 'id.txt';

%% show figure or not
show = true;

%% read the particles' id
cd(outdir);
ids = uint64(load(file));
ids = uint64(503918375);

%% loop
nid = length(ids);
for i=1:nid
    %% read data
    id = ids(i);
    [name, ~] = get_particle_name(id);
    prt = prm.read(name);
    
    %% set the directory
    cd(outdir);
    slj.Utility.exist_directory(num2str(id));
    iddir=[outdir,'\', num2str(id)];
    
    %% plot figure
    cd(iddir);
    f=figure('Visible', show);
    plot(prt.value.time, prt.value.pitch, '-k', 'LineWidth', 2);
    hold on
    plot([prt.value.time(1), prt.value.time(end)], [90, 90], '--b', 'LineWidth', 1);
    xlabel('\Omega_{ci}t');
    ylabel('\theta');
    xlim([prt.value.time(1), prt.value.time(end)]);
    ylim([0, 180]);
    set(gca,'FontSize', 14);
    print('-dpng', '-r300', [num2str(id), '_pitch_angle.png']);
    close(f);
end

%%  ================================================================================  %%
%% get the file name according to the particle's id
function [name, spc] = get_particle_name(id)
spcs={'e','l','h'};
ns=length(spcs);
for s=1:ns
    spc=char(spcs(s));
    name=['traj',spc,'_id',num2str(id)];
    if exist([name,'.dat'],'file')~=0
        break;
    end
end
end