function lw=set_LineWidth(extra)
%% writen by Liangjin Song on 20210408
%% set the Line Width
lw=2;
if isfield(extra,'LineWidth')
    lw=extra.LineWidth;
end

