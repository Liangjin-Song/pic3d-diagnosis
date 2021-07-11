% test the Pi-D and Pi-D in field aligned coordinate system
% writen by Liangjin Song on 20200512


%{
prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);

normpi=(3/2*n0*Ti);
normpe=(3/2*n0*Te);
normp=normpe;

tt=30:dt:45;
nt=length(tt);

tot=zeros(1,nt); % calculate directory
tpd=zeros(1,nt); % Pi-D
tfa=zeros(1,nt); % Pi-D for field aligned coordinate system

for t=1:nt
    cd(indir);
    tm=tt(t);

    p=read_data('prese',tm);

    vx=read_data('vxe',tm);
    vy=read_data('vye',tm);
    vz=read_data('vze',tm);

    bx=read_data('Bx',tm);
    bx=bx/c;
    by=read_data('By',tm);
    by=by/c;
    bz=read_data('Bz',tm);
    bz=bz/c;


    [pxx,pxy,pxz,pyy,pyz,pzz]=reshap_pressure(p,ndy,ndx);
    [ts,pd,~,~,~,~,~,~]=calc_pi_D(pxx,pxy,pxz,pyy,pyz,pzz,vx,vy,vz,grids);
    [fa, ~, ~]=calc_pi_D_fac(p,vx,vy,vz,bx,by,bz,grids);

    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    sts=get_sub_matrix(ts,x0,y0,top,bottom,left,right);
    spd=get_sub_matrix(pd,x0,y0,top,bottom,left,right);
    sfa=get_sub_matrix(fa,x0,y0,top,bottom,left,right);

    tot(t)=sum(sum(sts))/normp;
    tpd(t)=sum(sum(spd))/normp;
    tfa(t)=sum(sum(sfa))/normp;
end
%}

lw=2;
figure;
plot(tt,tot,'k','LineWidth',lw); hold on
plot(tt,tpd,'--r','LineWidth',lw);
plot(tt,tfa,':b','LineWidth',lw); hold off
legend('(P'' \cdot \nabla)\cdot V','Pi-D','Fac');
