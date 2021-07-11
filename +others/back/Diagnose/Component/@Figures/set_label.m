function label=set_label(extra,name)
%% writen by Liangjin Song on 20210408
%% set the label, the default is empty
%%
label=[];
if isfield(extra, name)
    str=['label=','extra.',name,';'];
    eval(str);
end

