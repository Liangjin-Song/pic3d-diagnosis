%% plot the Bz overview to highlight the position adn geometry of the DF.
% writen by Liangjin Song on 20191223
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
bza=read_data('Bz',ta);
bza=bza/c;
ssa=read_data('stream',ta);
[lbza,~]=get_line_data(bza,Lx,Ly,z0,1,0);
[~,xa]=max(lbza);
xa=xx(xa);

vx=read_data('vxi',tb);
vz=read_data('vzi',tb);

f=figure;
lw=2;
fs=16;

thw=[0.15,0.13];
tlu=[0.10,0.03];
tlr=[0.15,0.30];

set(f,'Units','centimeter','Position',[10,10,18,23]);
ha = tight_subplot(2,1,thw,tlu,tlr);

axes(ha(1));
load('/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/article/data/upper_MR_rate.mat');
plot(tt(1:end-1),uEr,'k','LineWidth',lw);
xlim([10,60]);
xlabel('\Omega_{ci}t');
ylabel('Er');
set(gca,'FontSize',fs)
scale1=1.16;
scale2=0.8;
PN=get(ha(1),'pos');
PN(3)=PN(3)*scale1;
PN(4)=PN(4)*scale2;
set(ha(1),'pos',PN);

axes(ha(2));
map=mycolormap();
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

scale=1.4;
PN=get(ha(2),'pos');
PN(3)=PN(3)*scale;
PN(4)=PN(4)*scale;
set(ha(2),'pos',PN);

annotation(f,'textbox',...
    [0.0173913043478261 0.895751741072694 0.0818840559625972 0.0429234329412266],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0202898550724637 0.467677495133018 0.0833333312817242 0.0429234329412266],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

cd(outdir);

