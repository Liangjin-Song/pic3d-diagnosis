%% plot Pi-D of time variation
% writen by Liangjin Song on 20191129
clear;
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/dt/';

tt=25:0.5:53;
di=60;
ndx=6000;
ndy=3000;
Lx=ndx/di; Ly=ndy/di;
z0=12.5;
c=0.6;
grids=1;

nt=length(tt);


txx=zeros(1,nt);
txy=zeros(1,nt);
txz=zeros(1,nt);
tyy=zeros(1,nt);
tyz=zeros(1,nt);
tzz=zeros(1,nt);
tot=zeros(1,nt);
tst=zeros(1,nt);

y0=2250;
top=2*di;
bottom=2*di;
left=3*di;
right=3*di;

for t=1:nt
    cd(indir);
    pp=read_data('prese',tt(t));
    vx=read_data('vxe',tt(t));
    vy=read_data('vye',tt(t));
    vz=read_data('vze',tt(t));
    bz=read_data('Bz',tt(t));

    % Pi-D
    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(pp,ndy,ndx);
    [ts,to,pdxx,pdxy,pdxz,pdyy,pdyz,pdzz]=calc_pi_D(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);

    % get the data at the front
    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    sxx=get_sub_matrix(pdxx,x0,y0,top,bottom,left,right);
    sxy=get_sub_matrix(pdxy,x0,y0,top,bottom,left,right);
    sxz=get_sub_matrix(pdxz,x0,y0,top,bottom,left,right);
    syy=get_sub_matrix(pdyy,x0,y0,top,bottom,left,right);
    syz=get_sub_matrix(pdyz,x0,y0,top,bottom,left,right);
    szz=get_sub_matrix(pdzz,x0,y0,top,bottom,left,right);
    sto=get_sub_matrix(to,x0,y0,top,bottom,left,right);

    sts=get_sub_matrix(ts,x0,y0,top,bottom,left,right);

    txx(t)=sum(sum(sxx));
    txy(t)=sum(sum(sxy));
    txz(t)=sum(sum(sxz));
    tyy(t)=sum(sum(syy));
    tyz(t)=sum(sum(syz));
    tzz(t)=sum(sum(szz));
    tot(t)=sum(sum(sto));
    tst(t)=sum(sum(sts));
end

figure;
lw=2;

plot(tt,txx,'r','LineWidth',lw); hold on
plot(tt,txy,'c','LineWidth',lw); hold on
plot(tt,txz,'m','LineWidth',lw); hold on
plot(tt,tyy,'g','LineWidth',lw); hold on
plot(tt,tyz,'y','LineWidth',lw); hold on
plot(tt,tzz,'b','LineWidth',lw); hold on

plot(tt,tot,'k','LineWidth',lw); hold on
plot(tt,tst,'--r','LineWidth',lw); hold on

plot([0,100],[0,0],'--y','LineWidth',lw); hold off
xlim([tt(1),tt(end)]);
xlabel('\Omega_{ci}t');
ylabel('Electron Pi-D');
legend('xx','xy','xz','yy','yz','zz','Sum','Pi-D','Pi-D=0');
cd(outdir);
