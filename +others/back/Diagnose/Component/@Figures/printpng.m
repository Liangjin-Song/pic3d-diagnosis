function printpng(obj, extra)
%% writen by Liangjin Song on 20210330
% save the figure as png
%%
if obj.type == FiguresType.Distribution_Function
    png_distribution_function(obj);
end

if isfield(extra,'figname')
    figname=extra.figname;
else
    figname='figure';
end
print('-dpng','-r300',[figname,'.png']);


