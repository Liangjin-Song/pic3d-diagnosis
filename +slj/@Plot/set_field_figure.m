function set_field_figure(extra)
%%
% @info: writen by Liangjin Song on 20210504
% @brief: set_field_figure - set the figure of field
% @param: extra - a structure containing the figure's information
%%
%% set some information
% the label
slj.Plot.set_label(extra);
% range
[term, is] = slj.Plot.get_term(extra,'xrange');
if is
    xlim(term);
end
[term, is] = slj.Plot.get_term(extra,'yrange');
if is
    ylim(term);
end
[term, is] = slj.Plot.get_term(extra,'zrange');
if is
    zlim(term);
end
% caxis
[term, is] = slj.Plot.get_term(extra, 'caxis');
if is
    caxis(term);
end
% FontSize
term=slj.Plot.get_term(extra, 'FontSize');
set(gca,'FontSize', term);
% colormap
[term, is] = slj.Plot.get_term(extra, 'colormap');
if is
    if strcmp(term, 'sun')
        colormap(slj.Plot.mycolormap(0));
    elseif strcmp(term, 'moon')
        colormap(slj.Plot.mycolormap(1));
    else
        colormap(term);
    end
end
end
