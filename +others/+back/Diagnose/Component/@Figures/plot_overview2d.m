function obj = plot_overview2d(fd, ss, norm, prm, extra)
%% writen by Liangjin Song on 20210409
%% plot field and stream
obj=Figures();
%% set the handle
% obj.handle.f=figure;
% obj.number=1;
% obj.set_Visible(obj.handle.f, extra);

%% plot field
Figures.plot_field2d(fd, norm, prm);
[is, name]=obj.get_term(extra, 'caxis');
if is
    color_range=name;
else
    color_range=caxis;
end
hold on
Figures.plot_stream2d(ss, prm);
caxis(color_range);

%% set the xrange
[is,xrange]=obj.set_range(extra,prm.value.lx,'xrange');
if is
    xlim(xrange);
end

%% set the yrange
[is, yrange]=obj.set_range(extra,prm.value.lz, 'yrange');
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
