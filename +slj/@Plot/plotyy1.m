function plotyy1(lx, lhs, rhs, extra)
%%
% @info: writen by Liangjin Song on 20210504
% @brief: plotyy1 - two lines, two y axes
% @param: lx - the vector in x direction
% @param: lhs - the vector in left y axis
% @param: rhs - the vector in right y axis
% @param: extra - a structure containing the figure's information
%%
%% plot figure
[ax, h1, h2] = plotyy(lx, lhs, lx, rhs);
%% font size and color
fs=slj.Plot.get_term(extra, 'FontSize');
set(ax(1),'XColor','k','YColor','k','FontSize',fs);
set(ax(2),'XColor','k','YColor','r','FontSize',fs);
%% line width and color
lw=slj.Plot.get_term(extra, 'LineWidth');
set(h1,'Color','k','LineWidth',lw);
set(h2,'Color','r','LineWidth',lw);
%% set the xrange
[term, is] = slj.Plot.get_term(extra,'xrange');
if is
    set(ax,'XLim',term);
end
%% set the yrange
[term, is]=slj.Plot.get_term(extra,'yrangel');
if is
    set(ax(1),'ylim',term);
end
[term, is]=slj.Plot.get_term(extra,'yranger');
if is
    set(ax(2),'ylim',term);
end
set(ax,'XTickMode','auto');
set(ax,'YTickMode','auto');
%% label
% title
[term, is] = slj.Plot.get_term(extra,'title');
if is
    title(term);
end
% xlabel
[term, is] = slj.Plot.get_term(extra,'xlabel');
if is
    xlabel(term);
end
% left ylabel
[term, is]=slj.Plot.get_term(extra,'ylabell');
if is
    set(get(ax(1),'Ylabel'),'String',term,'FontSize',fs);
end
% right ylabel
[term, is]=slj.Plot.get_term(extra,'ylabelr');
if is
    set(get(ax(2),'Ylabel'),'String',term,'FontSize',fs);
end
%% set the font size
set(gca, 'FontSize', fs)
%% set the position
[term, is]=slj.Plot.get_term(extra,'Position');
if is
    set(gca,'Position',term);
end
end
