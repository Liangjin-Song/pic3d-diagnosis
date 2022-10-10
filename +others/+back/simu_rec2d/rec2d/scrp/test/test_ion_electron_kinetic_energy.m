%% test kinetic energy of ion and electron
% writen by Liangjin Song on 20200521
clear;
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);

nt=length(tt);

tki=zeros(1,nt);
tke=zeros(1,nt);

tni=zeros(1,nt);
tne=zeros(1,nt);

tvi=zeros(1,nt);
tve=zeros(1,nt);

for t=1:nt
    cd(indir);
    tm=tt(t);

    bz=read_data('Bz',tm);
    bz=bz/c;
    
    % ion
    ni=read_data('Densi',tm);
    vix=read_data('vxi',tm);
    viy=read_data('vyi',tm);
    viz=read_data('vzi',tm);

    % electron
    ne=read_data('Dense',tm);
    vex=read_data('vxe',tm);
    vey=read_data('vye',tm);
    vez=read_data('vze',tm);

    % ion bulk kinetic energy
    ki=calc_bulk_kinetic_energy(mi,ni,vix,viy,viz);
    % electron bulk kinetic energy
    ke=calc_bulk_kinetic_energy(me,ne,vex,vey,vez);

    vi=vix.^2+viy.^2+viz.^2;
    ve=vex.^2+vey.^2+vez.^2;

    %% get a mean value of a ractangle
    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    aki=get_sub_matrix(ki,x0,y0,top,bottom,left,right);
    ake=get_sub_matrix(ke,x0,y0,top,bottom,left,right);
    
    ani=get_sub_matrix(ni,x0,y0,top,bottom,left,right);
    ane=get_sub_matrix(ne,x0,y0,top,bottom,left,right);

    avi=get_sub_matrix(vi,x0,y0,top,bottom,left,right);
    ave=get_sub_matrix(ve,x0,y0,top,bottom,left,right);

    tki(t)=sum(sum(aki));
    tke(t)=sum(sum(ake));

    tni(t)=sum(sum(ani));
    tne(t)=sum(sum(ane));

    tvi(t)=sum(sum(avi));
    tve(t)=sum(sum(ave));
end

figure;
lw=2;
xrange=[tt(1),tt(end)];

subplot(3,1,1);
plot(tt,tni,'r','LineWidth',lw); hold on
plot(tt,tne,'--b','LineWidth',lw); hold off
legend('Ni','Ne');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('Plasma Density');

subplot(3,1,2);
plot(tt,tvi,'r','LineWidth',lw); hold on
plot(tt,tve,'--b','LineWidth',lw); hold off
legend('vi^2','ve^2');
xlabel('\Omega_{ci} t');
xlim(xrange);

subplot(3,1,3);
[ax,h1,h2]=plotyy(tt,tke,tt,tki);
set(ax(1),'XColor','k','YColor','b');
set(ax(2),'XColor','k','YColor','r');
set(ax,'XLim',xrange);
% set label
set(get(ax(1),'Ylabel'),'String','K_e');
set(get(ax(2),'Ylabel'),'String','K_i');
xlabel('\Omega_{ci}t');
ylabel('Kinetic energy');
% set line
set(h1,'Color','b','LineWidth',lw);
set(h2,'Color','r','LineWidth',lw);

