function obj = plotyy1(lx, lhs, rhs, extra)
%% writen by Liangjin Song on 20210408
%% plotyy, only have two lines
%%
obj=Figures();

%% set the handle
% obj.handle.f=figure;
% obj.number=1;
% obj.set_Visible(obj.handle.f, extra);

%% plot
[ax,h1,h2]=plotyy(lx,lhs,lx,rhs);

%% set font size
fs=obj.set_FontSize(extra);
set(ax(1),'XColor','k','YColor','k','FontSize',fs);
set(ax(2),'XColor','k','YColor','r','FontSize',fs);

%% set the xrange
[is,xrange]=obj.set_range(extra,lx,'xrange');
if is
    set(ax,'XLim',xrange);
end

%% set the yrange
[is, yrangel]=obj.set_range(extra,lhs, 'yrangel');
if is
    set(ax(1),'ylim',yrangel);
end
[is, yranger]=obj.set_range(extra,rhs, 'yranger');
if is
    set(ax(2),'ylim',yranger);
end
set(ax,'YTickMode','auto');

%% set the lable
label=obj.set_label(extra,'xlabel');
xlabel(label,'FontSize',fs);
ylabell=obj.set_label(extra,'ylabell');
ylabelr=obj.set_label(extra,'ylabelr');
set(get(ax(1),'Ylabel'),'String',ylabell,'FontSize',fs);
set(get(ax(2),'Ylabel'),'String',ylabelr,'FontSize',fs);

%% set the Line Width
lw=obj.set_LineWidth(extra);
set(h1,'Color','k','LineWidth',lw);
set(h2,'Color','r','LineWidth',lw);

%% set the title
[is, name]=obj.get_term(extra, 'title');
if is
    title(name);
end

%% set the position
% obj.set_gca_position(gca, extra);

%% set the font size
set(gca, 'FontSize', fs)
