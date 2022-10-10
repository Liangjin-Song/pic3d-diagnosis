function [is, term]=get_term(extra, name)
%% writen by Liangjin Song on 20210408
%% get the term value from extra
term=[];
is=false;
if isfield(extra,name)
    str=['term=','extra.',name,';'];
    eval(str);
    is=true;
end

