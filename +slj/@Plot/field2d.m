function h=field2d(fd, lx, ly, extra)
%%
% @info: writen by Liangjin Song on 20210503
% @brief: field - plot the 2-D field diagram
% @param: fd - the array containing the field information
% @param: lx - the vector in x direction
% @param: ly - the vector in y direction
% @param: extra - a structure containing the figure's information
% @return: h - the handle of the colorbar
%%
% set the colorbar
[term, is] = slj.Plot.get_term(extra, 'log');
if is
    if term
        fd=log10(fd+1);
    end
end
%% plot figure
% the coordinate metrix
[X, Y] = meshgrid(lx, ly);
% plot figure
p=pcolor(X, Y, fd);
shading flat;
% axis on;
p.FaceColor = 'interp';
[bterm, bis] = slj.Plot.get_term(extra, 'ColorbarPosition');
if bis
    if isa(bterm,'char')
        h=colorbar(bterm);
    else
        h=colorbar;
        set(h,'Position',bterm);
    end
else
    h=colorbar;
end
axis([lx(1) lx(end) ly(1) ly(end)])
% set the colorbar
if is
    if term
    set(h,'YTick',[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]','YTicklabel',{'10^1','10^2','10^3','10^4','10^5','10^6','10^7','10^8','10^9','10^{10}','10^{11}','10^{12}','10^{13}','10^{14}','10^{15}'});
    end
end
axis on
% set(gca,'fontsize',14,'DataAspectRatio',[1 1 1],'PlotBoxAspectRatio',[1 1 1],...
    % 'Xminortick','on','Yminortick','on','tickdir','out')
% set the figure
if nargin == 4
    slj.Plot.set_field_figure(extra);
end
end
