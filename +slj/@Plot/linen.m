function h=linen(lx, ly, extra)
%%
% @info: writen by Liangjin Song on 20210504
% @brief: linen - plot multiply lines
% @param: lx - the vector in x direction
% @param: ly - a structure containing the vector in y direction
% @param: extra - a structure containing the figure's information
%%
if nargin < 3
    extra=[];
end
%% the data information
ll=fieldnames(ly);
nl=length(ll);
for i=1:nl
    cmd=['p=plot(lx, ly.',char(ll(i)),'); hold on'];
    eval(cmd);
    set_line_properties(p, i, extra);
end
hold off
%% set legend
[name, is]=slj.Plot.get_term(extra, 'legend');
if is
    [term, is]=slj.Plot.get_term(extra,'Location');
    if is
        h=legend(name, 'Location', term);
    else
        h=legend(name, 'Location', 'Best');
    end
else
    h=legend;
end
%% range
[term, is] = slj.Plot.get_term(extra,'xrange');
if is
    xlim(term);
else
    xlim([lx(1), lx(end)]);
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

%% ======================================================================== %%
function set_line_properties(p, n, extra)
%%
% @brief: set_line_properties - set the line
% @param: p - the handle of a line, which is created the plot function
% @param: n - the serial number of lines
% @param: extra - a structure containing the figure's information
%%
%% line style
[term, is]=slj.Plot.get_term(extra, 'LineStyle');
if is
    set(p, 'LineStyle', char(term(n)));
end
[term, is]=slj.Plot.get_term(extra, 'LineColor');
if is
    set(p, 'Color', char(term(n)));
end
%% line width
term=slj.Plot.get_term(extra, 'LineWidth');
set(p, 'LineWidth', term);
end
