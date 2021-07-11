%% plot the Bz overview to highlight the position adn geometry of the DF.
% writen by Liangjin Song on 20191223
%{
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);
ta=35;
tb=35;

xx=0:Lx/ndx:Lx-Lx/ndx;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;
left=left/di;
right=right/di;
top=top/di;
bottom=bottom/di;

cd(indir);
%% panel a
bza=read_data('Bz',ta);
bza=bza/c;
ssa=read_data('stream',ta);
[lbza,~]=get_line_data(bza,Lx,Ly,z0,1,0);
[~,xa]=max(lbza);
xa=xx(xa);

%% panel b
vx=read_data('vxi',tb);
vz=read_data('vzi',tb);
% bz=read_data('Bz',tb);
% ss=read_data('stream',tb);
%}

f=figure;
lw=2;
fs=16;
% thw=[0.008,0.12];
% tlu=[0.20,0.1];
% tlr=[0.1,0.05];

% set(f,'Units','centimeter','Position',[10,10,30,12]);
% ha = tight_subplot(1,2,thw,tlu,tlr);

% map=mycolormap();
% axes(ha(1));
plot_overview(bza,ssa,1,Lx,Ly); hold on
colormap(map);
plot_vector(vx,vz,Lx,Ly,60,2,'b');
plot([xa-left,xa+right],[z0-bottom,z0-bottom],'-r','LineWidth',3);
plot([xa+right,xa+right],[z0-bottom,z0+top],'-r','LineWidth',3);
plot([xa+right,xa-left],[z0+top,z0+top],'-r','LineWidth',3);
plot([xa-left,xa-left],[z0+top,z0-bottom],'-r','LineWidth',3); hold off
xlim([60,90]);
ylim([5,20]);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',fs);
% title(['\Omega_{ci}t=',num2str(ta)],'FontWeight','normal','FontSize',fs+2,'FontName','Times New Roman');

%{
axes(ha(2));
plot_overview(bz,ss,c,Lx,Ly); hold on
plot_vector(vx,vz,Lx,Ly,60,4,'r');
xlim([60,90]);
ylim([5,20]);
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
set(gca,'FontSize',fs);
% title(['\Omega_{ci}t=',num2str(tb)],'FontWeight','normal','FontSize',fs+2,'FontName','Times New Roman');
%}

%{
annotation(f,'textbox',...
    [0.0240909090909091 0.703932737230185 0.0493881106767413 0.0829596394514289],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',fs+2,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.505734265734266 0.703933992835566 0.0502622365248162 0.0829596394514289],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',fs+2,...
    'FontName','Times New Roman');

cd(outdir);
%}

