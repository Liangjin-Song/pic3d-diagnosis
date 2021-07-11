%% plot the RF velocity
%{
clear
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/RF/';
dt=1;
tt=25:dt:55;
di=40;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
c=0.6;
z0=15;
wci=0.000750;
nt=length(tt)-1;
vA=0.03;

vrf=zeros(1,nt);

for t=1:nt
    % previous time
    tp=tt(t);
    % next time 
    tn=tt(t)+dt;
    
    % read data 
    cd(indir);

    % Bz
    bzp=read_data('Bz',tp);
    bzp=bzp/c;
    bzn=read_data('Bz',tn);
    bzn=bzn/c;

    [lbzp,lx]=get_line_data(bzp,Lx,Ly,z0,1,0);
    [lbzn,~]=get_line_data(bzn,Lx,Ly,z0,1,0);

    v_RF=calc_instant_RF_velocity(lbzp,lbzn,lx,wci,di);
    vrf(t)=v_RF/vA;
end
xrange=[tt(1),tt(end)];
tt=tt(1)+0.5:tt(end);
%}
figure
plot(tt,vrf,'*k','LineWidth',2);
set(get(gca, 'XLabel'), 'String', '\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', 'v_{RF}');
set(gca,'FontSize',18);
xlim(xrange);
cd(outdir);
