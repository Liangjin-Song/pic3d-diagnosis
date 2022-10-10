%% to select the range of different structures
%%
%%
clear
cd('I:\PIC simulation\island\island coalescence\mass=25\size_200_100\Bg=0.0\')
dirout='I:\DF\figures\';
%%
tt=20:100;
nx=2000;
ny=1000;
Lx=200;
Ly=100;
norm=0.04;
cut=-25;
xrange=[0 Lx];
yrange=[-30 0];
% delta_x=[5,5,5,5,5];
% delta_y=[5,5,5,5,5];
% y0=-Ly/4;
% npos=10;
%%
nt=length(tt);
si=zeros(nt,9);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
load(['Bz_t',it,'.mat']);
eval(['bz=Bz_t',it,';']);
load(['ohmy_t',it,'.mat'])
eval(['ohm=ohmy_t',it,';'])
% load(['vye_t',it,'.mat']);
% eval(['vye=vye_t',it,';']);
% % load(['vye_t',it,'.mat']);
% % eval(['vye=vye_t',it,';']);
% % load(['vye_t',it,'.mat']);
% % eval(['vye=vye_t',it,';']);
% % load(['vye_t',it,'.mat']);
% % eval(['vye=vye_t',it,';']);
load(['stream_t',it,'.mat']);
eval(['ss=stream_t',it,';'])
evb=ohm(:,1)-ohm(:,3);  %E+VeXB
evb=reshape(evb,nx,ny);
evb=evb';
evb=simu_filter2d(evb);
%%
% h1=subplot('position',[0.15,0.68,0.7,0.28]);
% plot_field(evb,Lx,Ly,0.04);
% cr=caxis;
% hold on
% plot_stream(ss,Lx,Ly,30);
% colorbar('hide')
% crmin=min(abs(cr));
% caxis([-crmin crmin])
% xlim(xrange)
% ylim(yrange)
%%
h2=subplot('position',[0.15,0.55,0.7,0.4]);
plot_line(evb,Lx,Ly,cut,0.03,0,'k');
xlim(xrange)
hold on
plot([xrange(1),xrange(2)],[0,0],'k--')
title(['time= ',num2str(tt(i),'%3.3d')],'fontsize',13)
set(gca,'xticklabel','')
%%
h3=subplot('position',[0.15,0.1,0.7,0.4]);
plot_line(bz,Lx,Ly,cut,0.6,0,'k');
xlim(xrange)
hold on
plot([xrange(1),xrange(2)],[0,0],'k--')
%%
[xx,yy]=ginput(8);
close(gcf)
if mod(length(xx),2)==1, error('you must select even number of points!'); end
si(i,:)=[tt(i),xx'];

% axes(h1)   %set h1 as the current axis
% for kk=1:npos
%     rectangle('position',[xpos(i,kk)-delta_x(kk),y0-delta_y(kk),delta_x(kk)*2,delta_y(kk)*2]);
% end
%%
% print('-r300','-dpng',[dirout,'region_select_t',it,'.png'])
% close(gcf)
clear stream* ohmy* Bz*
end
%%






