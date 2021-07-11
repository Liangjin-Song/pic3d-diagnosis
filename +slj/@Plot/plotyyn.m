function [ax, h1, h2] = plotyyn(lx, lhs, rhs, extra)
%%
% @info: writen by Liangjin Song on 20210504
% @brief: multiply lines, two y axes
% @param: lx - the vector in x direction
% @param: lhs - a structure containing the vector in left y direction
% @param: rhs - a structure containing the vector in right y direction
% @param: extra - a structure containing the figure's information
%%
%% reset the data
nx=length(lx);
nn=zeros(1,nx);
% left
name=fieldnames(lhs);
ny=length(name);
nl=zeros(ny,nx);
for j=1:ny
    cmd=['tmp=lhs.',char(name(j)),';'];
    eval(cmd);
    for i=1:nx
        nn(i)=lx(i);
        nl(j,i)=tmp(i);
    end
end
% right
name=fieldnames(rhs);
ny=length(name);
nr=zeros(ny,nx);
for j=1:ny
    cmd=['tmp=rhs.',char(name(j)),';'];
    eval(cmd);
    for i=1:nx
        nr(j,i)=tmp(i);
    end
end
%% plot figure
[ax, h1, h2] = plotyy(nn, nl, nn, nr);
%% set the y axes
fs=slj.Plot.get_term(extra, 'FontSize');
set(ax(1),'XColor','k','YColor','k','FontSize',fs);
set(ax(2),'XColor','k','YColor','r','FontSize',fs);
%% set the line width
lw=slj.Plot.get_term(extra, 'LineWidth');
set(h1,'LineWidth',lw);
set(h2,'LineWidth',lw);
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
