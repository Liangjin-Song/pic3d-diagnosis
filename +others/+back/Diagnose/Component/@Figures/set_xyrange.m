function set_xyrange(extra, lx, ly)
%% writen by Liangjin Song on 20210409
%% set xrange and yrange
%%
%% set the xrange
[is,xrange]=Figures.set_range(extra,lx,'xrange');
if is
    xlim(xrange);
end

%% set the yrange
[is, yrange]=Figures.set_range(extra,ly, 'yrange');
if is
    ylim(yrange);
end

