function set_Visible(handle, extra)
%% writen by Liangjin Song on 20210408
%% set the figure visible or not
%%
if isfield(extra, 'Visible')
    v=extra.Visible;
else
    v=true;
end

if v
    set(handle, 'Visible', 'On');
else
    set(handle, 'Visible', 'Off');
end

