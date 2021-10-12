% function figure6_2()
%%
% writen by Liangjin Song on 20210720
% the 3D distribution function at the X-line
%%
% function plot_3D_distribution_function()
%%
% plot the 3D distribution function
% writen by Liangjin Song on 20210629
%%
clear;
%% parameters
clear;
run('articles.article4.parameters.m');
%% distribution function name
nic='PVh_ts51300_x1980-2020_y993-1008_z0-1';
ni='PVl_ts51300_x1980-2020_y993-1008_z0-1';
ne='PVe_ts51300_x1980-2020_y993-1008_z0-1';

%% for cold ions
name=nic;
extra.isovalue=40;
extra.presion=80;
extra.xlabel='Vic_x';
extra.ylabel='Vic_y';
extra.zlabel='Vic_z';
f1=plot_3d_distribution_function(prm, name, extra);
% annotation(gcf,'textbox',...
%     [0.308928571428571 0.799000001915864 0.0937499977382167 0.0880952361793745],...
%     'String',{'(j)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times New Roman');
cd(outdir);
print(gcf,'-dpng','-r300','figure6-2.png');
print(gcf,'-depsc','figure6_2.eps');

%% for ions
name=ni;
extra.isovalue=30;
extra.presion=40;
extra.xlabel='Vih_x';
extra.ylabel='Vih_y';
extra.zlabel='Vih_z';
f2=plot_3d_distribution_function(prm, name, extra);
% annotation(gcf,'textbox',...
%     [0.255357142857143 0.777571430487293 0.102678568900696 0.0880952361793745],...
%     'String',{'(k)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times New Roman');

cd(outdir);
print(gcf,'-dpng','-r300','figure6-3.png');
print(gcf,'-depsc','figure6_3.eps');

%% for ions
name=ne;
extra.isovalue=20;
extra.presion=30;
extra.xlabel='Ve_x';
extra.ylabel='Ve_y';
extra.zlabel='Ve_z';
f3=plot_3d_distribution_function(prm, name, extra);
% annotation(gcf,'textbox',...
%     [0.1875 0.739476192392055 0.0937499977382167 0.0880952361793745],...
%     'String',{'(l)'},...
%     'LineStyle','none',...
%     'FontSize',18,...
%     'FontName','Times New Roman');
cd(outdir);
print(gcf,'-dpng','-r300','figure6-4.png');
print(gcf,'-depsc','figure6_4.eps');

function f=plot_3d_distribution_function(prm, name, extra)
dst=prm.read(name);
dst=dst.dstv(prm.value.vA, extra.presion);
value=dst.value;
for i=1:extra.presion
    value(:,:,i)=value(:,:,i)';
end
%% figure
f=slj.Plot();
f.isosurface(value, dst.ll, dst.ll, dst.ll, extra.isovalue, extra);
end