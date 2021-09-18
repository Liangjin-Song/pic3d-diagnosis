function cset_gca_position(gca, extra)
%% writen by Liangjin Song on 20210408
%% set the gca position
%%
if isfield(extra,'gca_position')
    pst=extra.gca_position;
else
    pst=[.12 .17 .75 .75];
end
set(gca,'Position',pst);

