classdef Cold_Ions
%% writen by Liangjin Song on 20210408
% the diagnose of cold ions
%%
properties
    prm;
end

%% ======================================================================== %%
methods (Access = public)
    function obj=Cold_Ions(indir, outdir)
        obj.prm=Parameters(indir,outdir);
    end
end

%% ======================================================================== %%
methods (Access = public)
    %% the particle trajectory
    plot_traj_energy_position_from_file(obj);
    %% move the trajectory figures
    move_trajectory_figures(obj);
    %% trajectory analysis for one particle
    trajectory_analysis(obj);
    trajectory_survey(obj, name);
    trajectory_stream_avi(obj, name)
    trajectory_overview(obj);
    plot_traj_Fermi_energy(obj);
    plot_traj_map(obj); % , prt, value, extra);
    %% plot fluid velocity vector
    plot_velocity_vector(obj);
end

%% ======================================================================== %%
%% plot overview
methods (Access = public, Static)
    plot_temperature_overview();
end

%% ======================================================================== %%
end
