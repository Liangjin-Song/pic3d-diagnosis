function fs=set_FontSize(extra)
%% writen by Liangjin Song on 20210408
%% set the fontsize
if isfield(extra, 'FontSize')
    fs=extra.FontSize;
else
    fs=16;
end
