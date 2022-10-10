%% test Kinetic energy
% writen by Liangjin Song on 20191209
clear;

prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);

tt=25:0.5:53;
nt=length(tt);

tki=zeros(1,nt);
tke=zeros(1,nt);
tvi=zeros(1,nt);
tve=zeros(1,nt);
rk=zeros(1,nt);
rv=zeros(1,nt);


for t=1:nt
    cd(indir);
    tm=tt(t);
    bz=read_data('Bz',tm);

    % ion
    ni=read_data('Densi',tm);
    vix=read_data('vxi',tm);
    viy=read_data('vyi',tm);
    viz=read_data('vzi',tm);
    vi2=vix.^2+viy.^2+viz.^2;

    % electron
    ne=read_data('Dense',tm);
    vex=read_data('vxe',tm);
    vey=read_data('vye',tm);
    vez=read_data('vze',tm);
    ve2=vex.^2+vey.^2+vez.^2;

    ki=0.5*mi*vi2.*ni;
    ke=0.5*me*ve2.*ne;


    [lbz,~]=get_line_data(bz,Lx,Ly,z0,1,0);
    [~,x0]=max(lbz);

    ski=get_sub_matrix(ki,x0,y0,top,bottom,left,right);
    svi=get_sub_matrix(vi2,x0,y0,top,bottom,left,right);
    ske=get_sub_matrix(ke,x0,y0,top,bottom,left,right);
    sve=get_sub_matrix(ve2,x0,y0,top,bottom,left,right);

    tki(t)=sum(sum(ski));
    tvi(t)=sum(sum(svi));
    tke(t)=sum(sum(ske));
    tve(t)=sum(sum(sve));
    rk(t)=tki(t)/tke(t);
    rv(t)=tvi(t)/tve(t);
end

f1=figure;
plot(tt,tki,'r','LineWidth',2); hold on
plot(tt,tke,'k','LineWidth',2); hold off
xlabel('\Omega_{ci}t');
ylabel('K')
legend('K_i','K_e');

f2=figure;
plot(tt,tvi,'r','LineWidth',2); hold on
plot(tt,tve,'k','LineWidth',2); hold off
xlabel('\Omega_{ci}t');
ylabel('V^2')
legend('V_i^2','V_e^2');

f3=figure;
plot(tt,rk,'*k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('K_i/K_e');

f4=figure;
plot(tt,rv,'*k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('V_i^2/V_e^2');

cd(outdir);
