function line(lx, ly, extra)
%%
% @info: writen by Liangjin Song on 20210504
% @brief: line - plot one line
% @param: lx - the vector in x direction
% @param: ly - the vector in y direction
% @param: extra - a structure containing the figure's information
%%
%% plot the figure
p=plot(lx, ly, '-k');
%% set the figure
if nargin == 3
    set_line_properties(p, extra);
end
end

%% ======================================================================== %%
function set_line_properties(p, extra)
%%
% @brief: set_line_properties - set the properties of a line
% @param: p - the handle of a line, which is created the plot function
% @param: extra - a structure containing the figure's information
%%
%% line style
[term, is]=slj.Plot.get_term(extra, 'LineStyle');
if is
    set(p, 'LineStyle', term);
end
[term, is]=slj.Plot.get_term(extra, 'LineColor');
if is
    set(p, 'Color', term);
end
%% line width
term=slj.Plot.get_term(extra, 'LineWidth');
set(p, 'LineWidth', term);
%% range
[term, is] = slj.Plot.get_term(extra,'xrange');
if is
    xlim(term);
end
[term, is] = slj.Plot.get_term(extra,'yrange');
if is
    ylim(term);
end
%% label
slj.Plot.set_label(extra);
%% font size
term=slj.Plot.get_term(extra, 'FontSize');
set(gca,'FontSize', term);
end
