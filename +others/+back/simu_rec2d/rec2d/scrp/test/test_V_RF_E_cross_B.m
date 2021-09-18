%% test V_RF and E cross B
%
clear
indir='/data/simulation/rec2d_M25SBg00Sx/data/';
tt=0:97;
di=20;
ndx=4000;
ndy=2000;
Lx=ndx/di;
Ly=ndy/di;
c=0.6;
mu=1/(c^2);
z0=25;
qi=0.000105;
qe=-0.000105;
wci=0.003;
divsor=1;
nt=length(tt);

vrf=zeros(1,nt-1);
vdf=zeros(1,nt-1);

for t=1:nt-1
    % previous time
    tp=tt(t);
    % next time 
    tn=tt(t+1);
    % half time 
    th=(tp+tn)/2;
    
    % read data 
    cd(indir);

    % Bx
    bxh=read_data('Bx',th);
    bxh=bxh/c;

    % By
    byh=read_data('By',th);
    byh=byh/c;

    % Bz
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzh=read_data('Bz',th);
    bzh=bzh/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    % Electric field
    exh=read_data('Ex',th);
    eyh=read_data('Ey',th);
    ezh=read_data('Ez',th);

    [lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);

    v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
    vrf(t)=v_RF;
    [vx_drf,vy_drf,vz_drf]=calc_drift_velocity(exh,eyh,ezh,bxh,byh,bzh);

    [lvx,~]=get_line_data(vx_drf,Lx,Ly,z0,1,0);
    [lbzh,~]=get_line_data(bzh,Lx,Ly,z0,1,0);
    [~,in]=max(lbzh);
    vdf(t)=lvx(in);
end
tt=tt(1)+0.5:tt(end);
%
figure
plot(tt,vrf,'r','LineWidth',2); hold on
plot(tt,vdf,'k','LineWidth',2); hold off
legend('v_{RF}','Drift Velocity');
set(get(gca, 'XLabel'), 'String', '\Omega t');
set(get(gca, 'YLabel'), 'String', 'RF Velocity');
set(gca,'FontSize',18);
