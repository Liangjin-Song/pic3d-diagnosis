classdef Figures
%% writen by Liangjin Song on 20210330
% plot figures
%%
properties (Access = public)
    % the figure type
    type;
    % the number of figures
    number;
    % the figure handles
    handle;
    % the figure name and time
    name;
    time;
end
%% ======================================================================== %%
methods (Access = public)
    function obj=Figures()
        obj.type=[];
        obj.number=0;
        obj.handle=[];
        obj.name=[];
        obj.time=[];
    end
end

%% ======================================================================== %%
%% plot figures
methods (Access = public, Static)
    obj = draw(prm, fd, varargin);
end

methods (Access = public)
    %% close all figures
    obj = close(obj);
end

%% ======================================================================== %%
%% save the figure
methods (Access = public)
    printpng(obj, prm, extra);
end

%% ======================================================================== %%
methods (Access = private, Static)
    % plot the field
    field(lx, ly, fd, varargin);
end

%% ======================================================================== %%
%% plot distribution function
methods (Access = private)
    obj = distribution_function(obj, dst, range);
    png_distribution_function(obj);
end

%% ======================================================================== %%
methods (Access = private, Static)
    set_Visible(handle, extra);
    fs=set_FontSize(extra);
    [is, range]=set_range(extra, ll, name);
    label=set_label(extra,name);
    lw=set_LineWidth(extra);
    set_gca_position(gca, extra);
    [is, term]=get_term(extra, name);
    set_commom_style(extra);
    set_xyrange(extra, lx, ly);
end

%% ======================================================================== %%
%% plot 2d field
methods (Access = private)
    obj = field2d(obj, fd, prm, varargin);
end

methods (Access = public, Static)
    plot_vector(vx,vy,prm,kav,scale,color);
end

methods (Access = public, Static)
    plot_field2d(fd, norm, prm);
    plot_stream2d(fd, prm, varargin);
    obj = plot_overview2d(fd, ss, norm, prm, extra);
    obj = patch(lx, ly, value, extra);
end

%% ======================================================================== %%
%% plot line
methods (Access = public, Static)
    obj = plotyy1(lx, lhs, rhs, extra);
    obj = plotyynn(lx, lhs, rhs, extra);
    obj = line1(lx, ly, extra);
    obj = linen(lx, ly, extra);
end

%% ======================================================================== %%
end
