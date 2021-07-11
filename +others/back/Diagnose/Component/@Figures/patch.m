function obj = patch(lx, ly, value, extra)
%% writen by Liangjin Song on 20210409
%% plot field and line
%%
obj=Figures();
%% set the handle
obj.handle.f=figure;
obj.number=1;
obj.set_Visible(obj.handle.f, extra);
value(end)=NaN;
%% plot figure
p=patch(lx,ly,value,value,'edgecolor','flat','facecolor','none');
colorbar;
%% set the Line Width
lw=obj.set_LineWidth(extra);
set(p,'LineWidth',lw);

obj.set_xyrange(extra,lx,ly);
obj.set_commom_style(extra);
