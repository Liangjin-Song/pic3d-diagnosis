% function plot_sub_distribution_function()
%%
% @info: writen by Liangjin Song on 20210607
% @brief: plot the distribution function as the function of velocity and rx
%%
clear;
%% parameters
% directory
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Kinetic\Distribution\Cold_Ions\Separatrix\Sphere\t=20';
prm=slj.Parameters(indir, outdir);
% the file name of distribution function
% name='PVh_ts20800_x600-1400_y418-661_z0-1';
tt=50;
isprt = 1;
spn = 'h';
id = uint64(74283363);
nt=length(tt);
for t=1:nt
    name=['PV', spn, '_ts',num2str(tt(t)/prm.value.wci),'_x600-1400_y418-661_z0-1'];
    % velocity direction
    dir=1:3;
    xrange=[19.5,21];
    zrange=[0,2];
    % zrange=[0.1,1];
    
    
    yrange=[-100,100];
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
    
    nv=length(dir);
    
    %% read data
    spc=prm.read(name);
    spc=spc.subposition(xrange,yrange,zrange);
    
    E=prm.read('E', tt(t));
    B=prm.read('B', tt(t));
    spc=spc.fac(prm, E, B);
    
    if isprt == 1
        in = find(spc.value.id == id);
    end
    
    
    for i=1:nv
        vdir=dir(i);
        if vdir==1
            extra.xlabel=['V',sfx,'_{BxExB} [V_A]'];
            extra.ylabel=['V',sfx,'_B [V_A]'];
            suffix='_vy_vz';
        elseif vdir == 2
            extra.xlabel=['V',sfx,'_{ExB} [V_A]'];
            extra.ylabel=['V',sfx,'_B [V_A]'];
            suffix='_vx_vz';
        else
            extra.xlabel=['V',sfx,'_{ExB} [V_A]'];
            extra.ylabel=['V',sfx,'_{BxExB} [V_A]'];
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
            norm = prm.value.vA;
            if vdir == 1
                plot(spc.value.vy(in)/norm, spc.value.vz(in)/norm,'b*', 'LineWidth', 5);
            elseif vdir == 2
                plot(spc.value.vx(in)/norm, spc.value.vz(in)/norm,'b*', 'LineWidth', 5);
            else
                plot(spc.value.vx(in)/norm, spc.value.vy(in)/norm,'b*', 'LineWidth', 5);
            end
        end
%         f.png(prm,[name,suffix,'_sub',num2str(xrange(1)),'-',num2str(xrange(2)),...
%             '_',num2str(yrange(1)),'-',num2str(yrange(2)),...
%             '_',num2str(zrange(1)),'-',num2str(zrange(2))]);
%         f.close();
    end
end