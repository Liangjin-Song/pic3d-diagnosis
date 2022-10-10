function [is, range]=set_range(extra, ll, name)
%% writen by Liangjin Song on 20210408
%% set the range
%%
range=[];
is=false;
if isfield(extra, name)
    str=['range=','extra.',name,';'];
    eval(str);
    is=true;
else
    range=[ll(1),ll(end)];
end

