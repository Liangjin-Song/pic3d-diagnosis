function [ax,h1,h2]=plotyy_with_bz(lfd,lbz,xx,ylab,xrange)
%% writen by Liangjin Song on 20180908
% plot two axis figure, the left axis is the field and the right axis is bz
%
% lfd is the line data of field
% lbz is the line data of magnetic field in z direction
% Lx is the normalized size of the simulation box
% xrange is the range of x axis
% xlab and ylab are the label of X and Y axises
%%

% set font size of axis label
fontsize=16;
% set line width
linewidth=2;
% set figures position
position=[100,100,900,700];

%% show the figures or not

[ax,h1,h2]=plotyy(xx,lfd,xx,lbz);

% set axis
set(ax(1),'XColor','k','YColor','b','FontSize',fontsize);
set(ax(2),'XColor','k','YColor','r','FontSize',fontsize);
set(ax,'XLim',xrange);


% set label
set(get(ax(1),'Ylabel'),'String',ylab,'FontSize',fontsize);
set(get(ax(2),'Ylabel'),'String','Bz','FontSize',fontsize);
xlabel('X[c/\omega_{pi}]','FontSize',fontsize);

% set line
set(h1,'Color','b','LineWidth',linewidth);
set(h2,'Color','r','LineWidth',linewidth);

% set figure
set(gcf,'color','white','paperpositionmode','auto');
set(gcf,'Position',position);
set(gca,'Position',[.11 .11 .77 .84]);
