function obj = linen(lx, ly, extra)
%% writen by Liangjin Song on 20210408
%% plot multiply lines
%%
obj=Figures();
%% set the handle
% obj.handle.f=figure;
% obj.number=1;
% obj.set_Visible(obj.handle.f, extra);

%% plot
nline=length(fieldnames(ly));
for i=1:nline
    str=['p=plot(lx, ly.l',num2str(i),'); hold on'];
    eval(str);

    %% set line style
    [is, name]=obj.get_term(extra,'LineStyle');
    if is
        set(p,'LineStyle',char(name(i)));
    end

    %% set line color
    [is, name]=obj.get_term(extra,'LineColor');
    if is
        set(p,'Color',char(name(i)));
    end

    %% set line width
    lw=obj.set_LineWidth(extra);
    set(p, 'LineWidth', lw);
end
hold off

%% set legend
[is, name]=obj.get_term(extra,'legend');
if is
    [is, ll]=obj.get_term(extra,'Location');
    if is
        legend(name, 'Location', ll);
    else
        legend(name, 'Location', 'Best');
    end
else
    legend;
end

%% set the xrange
[is,xrange]=obj.set_range(extra,lx,'xrange');
if is
    xlim(xrange);
end

%% set the yrange
[is, yrange]=obj.set_range(extra,ly, 'yrange');
if is
    ylim(yrange);
end

%% set the title
[is, name]=obj.get_term(extra, 'title');
if is
    title(name);
end

%% set the xlabel
[is, name]=obj.get_term(extra, 'xlabel');
if is
    xlabel(name);
end

%% set the ylabel
[is, name]=obj.get_term(extra, 'ylabel');
if is
    ylabel(name);
end

%% set font size
fs=obj.set_FontSize(extra);
set(gca,'FontSize', fs);
end
