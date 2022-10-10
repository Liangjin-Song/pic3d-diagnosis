function plot_traj_energy_position_from_file(obj)
%% writen by Liangjin Song on 20210408
%% plot the particle energy and position
%%
cd(obj.prm.value.indir);
%% get the file list of particle trajectory files
list=Utility.get_file_list('traj*');
nlist=length(list);

norm=obj.prm.value.tem*obj.prm.value.tle*obj.prm.value.thl/obj.prm.value.coeff;

% extra.xlabel='\Omega_{ci}t';
extra.Visible=false;
%% treatment for each file
for i=1:nlist
    name=char(list(i));
    name=name(1:end-4);
    prt=obj.prm.read_data(name);
    prt=prt.norm_energy(norm);
    prt=prt.norm_electric_field(obj.prm);
    lx=prt.value.time;

    %{
    %% trajectory and time
    extra.title='\Omega_{ci}t';
    extra.figname=[name,'_traj_time'];
    obj.plot_traj_map(prt, prt.value.time, extra);

    %% trajectory and kinetic energy
    extra.title='K_{ic}';
    extra.figname=[name,'_traj_k'];
    obj.plot_traj_map(prt, prt.value.k, extra);

    %% trajectory and kx
    extra.title='K_{ic}x';
    extra.figname=[name,'_traj_kx'];
    obj.plot_traj_map(prt, prt.value.kx, extra);

    %% trajectory and ky
    extra.title='K_{ic}y';
    extra.figname=[name,'_traj_ky'];
    obj.plot_traj_map(prt, prt.value.ky, extra);

    %% trajectory and kz
    extra.title='K_{ic}z';
    extra.figname=[name,'_traj_kz'];
    obj.plot_traj_map(prt, prt.value.kz, extra);

    %% trajectory and k_para
    extra.title='K_{para}';
    extra.figname=[name,'_traj_kpara'];
    obj.plot_traj_map(prt, prt.value.k_para, extra);

    %% trajectory and k_perp
    extra.title='K_{perp}';
    extra.figname=[name,'_traj_kperp'];
    obj.plot_traj_map(prt, prt.value.k_perp, extra);

    extra.xrange=[lx(1), lx(end)];

    %% plot kinetic energy and z position
    extra.ylabell='K_{ic}';
    extra.ylabelr='Z [c/\omega_{pi}]';
    extra.figname=[name,'_k_rz'];
    plotyy_line(prt.value.time, prt.value.k, prt.value.rz, extra, obj.prm);

    %% plot kinetic energy and z position
    extra.ylabell='K_{ic}';
    extra.ylabelr='X [c/\omega_{pi}]';
    extra.figname=[name,'_k_rx'];
    plotyy_line(prt.value.time, prt.value.k, prt.value.rx, extra, obj.prm);

    %% plot kinetic energy in three direction
    extra.ylabel='K_{ic}';
    ly.l1=prt.value.k;
    ly.l2=prt.value.kx;
    ly.l3=prt.value.ky;
    ly.l4=prt.value.kz;
    extra.LineStyle={'-', '-', '-', '-'};
    extra.LineColor={'k', 'r', 'g', 'b'};
    extra.legend={'Sum', 'Kx', 'Ky', 'Kz'};
    extra.figname=[name,'_k_kx_ky_kz'];
    plot_linen(lx, ly, extra, obj.prm);

    %% plot kinetic energy in para and perp direction
    extra.ylabel='K_{ic}';
    ly=[];
    ly.l1=prt.value.k;
    ly.l2=prt.value.k_para;
    ly.l3=prt.value.k_perp;
    extra.LineStyle={'-', '-', '-'};
    extra.LineColor={'k', 'r', 'b'};
    extra.legend={'Sum', 'K_{para}', 'K_{perp}'};
    extra.figname=[name,'_k_kpara_kperp'];
    plot_linen(lx, ly, extra, obj.prm);

    %% plot kinetic energy and magnetic moment
    extra.ylabell='K_{ic}';
    extra.ylabelr='\mu';
    extra.figname=[name,'_k_mu'];
    plotyy_line(lx, prt.value.k, prt.value.mu, extra, obj.prm);

    %% plot electric field in para and perp direction
    extra.ylabell='K_{para}';
    extra.ylabelr='E_{para}';
    extra.figname=[name,'_kpara_epara'];
    plotyy_line(lx, prt.value.k_para, prt.value.e_para, extra, obj.prm);
    %}

    extra.xrange=[lx(1), lx(end)];
    %% plot electric field in three direction
    extra.ylabell='Kx';
    extra.ylabelr='Ex';
    extra.figname=[name,'_kx_ex'];
    plotyy_line(lx, prt.value.kx, prt.value.ex, extra, obj.prm);

    extra.ylabell='Ky';
    extra.ylabelr='Ey';
    extra.figname=[name,'_ky_ey'];
    plotyy_line(lx, prt.value.ky, prt.value.ey, extra, obj.prm);

    extra.ylabell='Kz';
    extra.ylabelr='Ez';
    extra.figname=[name,'_kz_ez'];
    plotyy_line(lx, prt.value.kz, prt.value.ez, extra, obj.prm);
end
end

function plotyy_line(lx, lhs, rhs, extra, prm)
    fig=Figures.plotyy1(lx, lhs, rhs, extra);
    cd(prm.value.outdir);
    fig.printpng(extra);
    fig.close();
end

function plot_linen(lx, ly, extra, prm)
    fig=Figures.linen(lx, ly, extra);
    cd(prm.value.outdir);
    fig.printpng(extra);
    fig.close();
end
