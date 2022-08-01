% function plot_sub_distribution_function()
%%
% @info: writen by Liangjin Song on 20210607
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out\Kinetic\Distribution\X-line';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
% name='PVh_ts20800_x600-1400_y418-661_z0-1';
tt=30;
is_save = 1;
isprt = 0;
spn = 'h';
id = '74283363';
nt=length(tt);
for t=1:nt
    name=['PV',spn,'_ts',num2str(tt(t)/prm.value.wci),'_x800-1200_y418-661_z0-1'];
    % name=['PV',spn,'_ts',num2str(tt(t)/prm.value.wci),'_x1600-2000_y418-661_z0-1'];
    % velocity direction
    dir=1:3;
    % position range
    xrange=[24.5,25.5];
    zrange=[0.5,4.5];
    yrange=[-100,100];
    precision=80;
    %% the figure style
    range=3;
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
    
    if isprt == 1
        prt = prm.read(['traj',spn, '_id', id]);
        prt=prt.norm_velocity(prm);
        ttp = find(prt.value.time == tt);
    end
    
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
        f=slj.Plot();
        f.field2d(dst.value, dst.ll, dst.ll,extra);
        
        if isprt == 1
            hold on
            if vdir == 1
                plot(prt.value.vy(ttp), prt.value.vz(ttp),'b*', 'LineWidth', 5);
            elseif vdir == 2
                plot(prt.value.vx(ttp), prt.value.vz(ttp),'b*', 'LineWidth', 5);
            else
                plot(prt.value.vx(ttp), prt.value.vy(ttp),'b*', 'LineWidth', 5);
            end
        end
        %% plot the particle's position
        
        if is_save == 1
            f.png(prm,[name,suffix,'_sub',num2str(xrange(1)),'-',num2str(xrange(2)),...
                '_',num2str(yrange(1)),'-',num2str(yrange(2)),...
                '_',num2str(zrange(1)),'-',num2str(zrange(2))]);
        end
        %         f.close();
    end
end