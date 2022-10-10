
function [term, is] = get_term(extra, name)
%%
% @info: writen by Liangjin Song on 20210503
% @brief: get_term - get the value in a structure,
% @param: extra - the structure
% @param: name - the name of the term
% @return: term - the value associated with the term in extra
% @return: is - the logical value, extra includes the term or not
%%
term=[];
is=false;
%% the structure has the term
if isfield(extra,name)
    str=['term=','extra.',name,';'];
    eval(str);
    is=true;
    return;
end
%% the structure doesn't has the term
if strcmp(name, 'FontSize')
    term=14;
end
if strcmp(name, 'LineWidth')
    term=2;
end
end
