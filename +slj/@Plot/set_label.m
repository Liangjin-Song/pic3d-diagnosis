function set_label(extra)
%%
% @info: writen by Liangjin Song on 20210503
% @brief: set_label - set some label
% @param: extra - the structure containing the information
%%
%% title
[term, is] = slj.Plot.get_term(extra,'title');
if is
    title(term);
end
%% xlabel
[term, is] = slj.Plot.get_term(extra,'xlabel');
if is
    xlabel(term);
end
%% ylabel
[term, is] = slj.Plot.get_term(extra,'ylabel');
if is
    ylabel(term);
end
%% zlabel
[term, is] = slj.Plot.get_term(extra,'zlabel');
if is
    zlabel(term);
end
end
