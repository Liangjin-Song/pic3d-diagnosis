function obj = line1(lx, ly, extra)
%% writen by Liangjin Song on 20210408
%% plot only one line
%%
obj=Figures();
% set the handle
% obj.handle.f=figure;
% obj.number=1;
% obj.set_Visible(obj.handle.f, extra);

%% plot
obj.handle.p=plot(lx,ly,'-k');
 
%% set the Line Width
lw=obj.set_LineWidth(extra);
set(gca,'LineWidth',lw);

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
