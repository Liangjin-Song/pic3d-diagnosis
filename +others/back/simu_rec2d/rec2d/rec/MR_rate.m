function MR_rate(xpoint,norm,norm2)
%calculate the Magnetic reconnection rate
%
%MR_rate(xpoint,dt,norm)
%
%input:
%    xpoint contains information of reconnection flux
%    dt is the time resolution of data recorded, in the unit
%    of proton cyclotron period
%    norm usually equals to b0*di. 
%    norm2 equals to B0*Va*dt/wci
%%
%% this new version can remove the overlapped data caused by the rerun of the simulation%%
%-------------written by M.Zhou---------------------
% -----------modified by M.Zhou ON Jan/11/2019 at NCU--------------------

%% first remove the overlapped data
 tt=xpoint(:,1);
 tmp=diff(tt);
 index=find(tmp<0);
 while isempty(index)==0,
  jd=find(tt(index(1)+1:end)==tt(index(1)));
  xpoint=xpoint([1:index(1),index(1)+jd+1:end],:);
  tt=xpoint(:,1);
  tmp=diff(tt);
  index=find(tmp<0);
end

%
flux=(xpoint(:,2)-xpoint(:,3))./norm;
Er=diff(flux)/norm2*norm;
%%-------lower X-line
figure
[ax,h1,h2]=plotyy(tt,flux,tt(1:end-1),Er);
set(get(ax(1),'Ylabel'),'String','flux','color','r','fontsize',16)
set(get(ax(2),'Ylabel'),'String','Er/(V_{A}B_{0})','color','b','fontsize',16)
set(ax(1),'Ycolor','r')
set(ax(2),'Ycolor','b')
set(h1,'color','r','linewidth',1.)
set(h2,'color','b','linewidth',0.5)
xlabel('\omega_{ci}t','fontsize',14)
title('Lower X-line','fontsize',16)
set(gca,'fontsize',14)

%%---------upper X-line
flux=(xpoint(:,6)-xpoint(:,7))./norm;
Er=diff(flux)/norm2*norm;

figure
[ax,h1,h2]=plotyy(tt,flux,tt(1:end-1),Er);
set(get(ax(1),'Ylabel'),'String','flux','color','r','fontsize',16)
set(get(ax(2),'Ylabel'),'String','Er/(V_{A}B_{0})','color','b','fontsize',16)
set(ax(1),'Ycolor','r')
set(ax(2),'Ycolor','b')
set(h1,'color','r','linewidth',1.)
set(h2,'color','b','linewidth',0.5)
xlabel('\omega_{ci}t','fontsize',14)
title('Upper X-line','fontsize',16)
set(gca,'fontsize',14)

