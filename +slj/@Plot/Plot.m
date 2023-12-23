classdef Plot
%%
% @info: writen by Liangjin Song on 20210503
% @brief: this class plotting the figures, all of the functions are static
%%
properties (SetAccess = private)
    fig;
end
%% ======================================================================== %%
%% constructor
methods (Access = public)
    function obj = Plot(extra)
        obj.fig=figure;
        if nargin == 1
            [term, is]=obj.get_term(extra,'Visible');
            if is
                set(obj.fig,'Visible',term);
            end
            [term, is]=obj.get_term(extra,'Position');
            if is
                set(obj.fig, 'Position', term);
            end
        end
    end
end

%% ======================================================================== %%
%% the figure operation
methods (Access = public)
    function png(obj, prm, name)
        cd(prm.outdir);
        print(obj.fig, '-dpng','-r300',[name,'.png']);
    end
    function obj = close(obj)
        close(obj.fig);
        obj.fig=[];
    end
end

%% ======================================================================== %%
%% set some information
methods (Access = private, Static)
    [term, is] = get_term(extra, name);
    set_label(extra);
end

%% ======================================================================== %%
%% plot the 2-D figures
methods (Access = public, Static)
    h=field2d(fd, lx, ly, extra);
    h=field2d_suitable(fd, lx, ly, extra);
    stream(fd, lx, ly, number, color);
    h=overview(fd, ss, lx, ly, norm, extra);
    set_field_figure(extra);
    plot_vector(vx,vy,Lx,Ly,kav,scale,color);
end

%% ======================================================================== %%
%% plot the 3-D figures
methods (Access = public, Static)
    field3d(fd, lx, ly, lz, sx, sy, sz, extra);
    isosurface(fd, lx, ly, lz, isovalue, extra);
end

%% ======================================================================== %%
%% plot the line
methods (Access = public, Static)
    line(lx, ly, extra);
    h=linen(lx, ly, extra);
    plotyy1(lx, lhs, rhs, extra);
    [ax, h1, h2] = plotyyn(lx, lhs, rhs, extra);
    H = arrow(X, Y, varargin);
end

%% ======================================================================== %%
%% the color map
methods (Access = public, Static)
    map = mycolormap(type);
    c = othercolor(n,m);
    colorList=slanCM(type,num);
end

%% ======================================================================== %%
%% the subplot
methods (Access = public, Static)
    ha = subplot(Nh, Nw, gap, marg_h, marg_w);
end

%% ======================================================================== %%
%% the figure associated with particles
methods (Access = public, Static)
    id = particle_position(prm, id, dstname, time);
end

%% ======================================================================== %%
end