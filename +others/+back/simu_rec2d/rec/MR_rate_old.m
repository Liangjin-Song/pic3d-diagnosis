function MR_rate_old(xpoint,dt,norm,norm2)
%calculate the Magnetic reconnection rate
%
%MR_rate(xpoint,dt,norm)
%
%input:
%    xpoint contains information of reconnection flux
%    dt is the time resolution of data recorded, in the unit
%    of proton cyclotron period
%    norm usually equals to b0*di. (some times b0 
%    equals to b0*c).
%    norm2 equals to dt/wci*di*(B0*VA).
%-------------written by M.Zhou---------------------
N=length(xpoint(:,1))-1;
%
tt=0:dt:N*dt;
flux=(xpoint(:,1)-xpoint(:,2))./norm;
Er=diff(flux)/norm2;
%%-------lower X-line
figure
[ax,h1,h2]=plotyy(tt,flux,tt(1:end-1),Er);
set(get(ax(1),'Ylabel'),'String','flux','color','r')
set(get(ax(2),'Ylabel'),'String','Er/(V_{A}B_{0})','color','b')
set(ax(1),'Ycolor','r')
set(ax(2),'Ycolor','b')
set(h1,'color','r','linewidth',1.)
set(h2,'color','b','linewidth',0.5)
%%---------upper X-line
flux=(xpoint(:,5)-xpoint(:,6))./norm;
Er=diff(flux)/norm2;

figure
[ax,h1,h2]=plotyy(tt,flux,tt(1:end-1),Er);
set(get(ax(1),'Ylabel'),'String','flux','color','r')
set(get(ax(2),'Ylabel'),'String','Er/(V_{A}B_{0})','color','b')
set(ax(1),'Ycolor','r')
set(ax(2),'Ycolor','b')
set(h1,'color','r','linewidth',1.)
set(h2,'color','b','linewidth',0.5)

