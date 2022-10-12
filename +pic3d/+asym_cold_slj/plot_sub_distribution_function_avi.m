% function plot_sub_distribution_function()
%%
% @info: writen by Liangjin Song on 20210607
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
% name='PVh_ts20800_x600-1400_y418-661_z0-1';
tt=0:60;
spn = 'h';
dir=1;

% position range
xrange=[24.5,25.5];
zrange=[1,4];
yrange=[-100,100];
s = 3;

aviname = [outdir,'\PV',spn,'_',num2str(dir),'_sub',num2str(xrange(1)),'-',num2str(xrange(2)),...
                '_',num2str(yrange(1)),'-',num2str(yrange(2)),...
                '_',num2str(zrange(1)),'-',num2str(zrange(2)), '.avi'];
aviobj=VideoWriter(aviname);
aviobj.FrameRate=5;
open(aviobj);
nt=length(tt);
figure;
for t=1:nt
    if s == 1
        %% x = [0,10] di
        name=['PV',spn,'_ts',num2str(tt(t)/prm.value.wci),'_x0-400_y418-661_z0-1'];
    elseif s == 2
        %% x= [10, 20] di
        name=['PV',spn,'_ts',num2str(tt(t)/prm.value.wci),'_x400-800_y418-661_z0-1'];
    elseif s == 3
        %% x = [20, 30] di
        name=['PV',spn,'_ts',num2str(tt(t)/prm.value.wci),'_x800-1200_y418-661_z0-1'];
    elseif s == 4
        %% x = [30, 40] di
        name=['PV',spn,'_ts',num2str(tt(t)/prm.value.wci),'_x1200-1600_y418-661_z0-1'];
    else
        %% x = [40, 50] di
        name=['PV',spn,'_ts',num2str(tt(t)/prm.value.wci),'_x1600-2000_y418-661_z0-1'];
    end
    % velocity direction
    %% the figure style
    range=3;
    precision=80;
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
    
    nv=length(dir);
    
    %% read data
    spc=prm.read(name);
    spc=spc.subposition(xrange,yrange,zrange);
    
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
        dst=spc.dstv(prm.value.vA,precision);
        dst=dst.intgrtv(vdir);
        extra.title=['\Omega_{ci}t = ', num2str(dst.time)];
        %% plot figure
        slj.Plot.field2d(dst.value, dst.ll, dst.ll,extra);
        caxis([0,3]);
    end

    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
end
close(aviobj);
close(gcf);