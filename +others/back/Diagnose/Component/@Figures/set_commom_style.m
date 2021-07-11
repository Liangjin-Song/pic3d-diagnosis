function set_commom_style(extra)
%% writen by Liangjin Song on 20210409
%% set style
%%

%% set the title
[is, name]=Figures.get_term(extra, 'title');
if is
    title(name);
end

%% set the xlabel
[is, name]=Figures.get_term(extra, 'xlabel');
if is
    xlabel(name);
end

%% set the ylabel
[is, name]=Figures.get_term(extra, 'ylabel');
if is
    ylabel(name);
end

%% set font size
fs=Figures.set_FontSize(extra);
set(gca,'FontSize', fs);
