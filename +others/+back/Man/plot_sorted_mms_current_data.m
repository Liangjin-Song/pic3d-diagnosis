%% plot figure of the mms data
% writen by Liangjin Song on 20200718
%
clear;
indir='E:\Download\Man';
outdir='E:\Download\Man';
filename='mms1_step_4_jp.txt';

% read and check data
cd(indir);
data=read_mms_current_data(filename);
err=check_mms_current_data(data);
if length(err) ~= 0
    error('The data has errors!');
end

% categorize the data
[ppi,ppe,pn,np]=sort_mms_current_data(data);

% fontsize
fs=10;

% for the first type
pp=[ppi;ppe];
s=sort_by_frequency(pp(:,1),pp(:,2));

f1=figure;
x3str={'','','0~0.5','','0.5~0.67','','0.67~1','','1~1.5','','1.5~2','','>2','',''};
s=[length(np),0,s(1),0,s(2),0,s(3),0,s(4),0,s(5),0,s(6),0,length(pn)];
bar(s,1,'b');
ylim([0,2400])
xtb = get(gca,'XTickLabel');
xt = get(gca,'XTick');
yt = get(gca,'YTick');
xtextp=xt;
ytextp=-0.08*yt(3)*ones(1,length(xt));
text(xtextp,ytextp,x3str,'FontSize',fs,'HorizontalAlignment','center','rotation',0)
set(gca,'XTickLabel',[]);

for i=1:2:length(s)
    text(i,s(i),num2str(s(i)),'FontSize',fs,'VerticalAlignment','bottom','HorizontalAlignment','center');
end
set(gca,'FontSize',fs);

