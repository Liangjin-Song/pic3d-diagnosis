%% RF thickness calculated by half width for asymmetric reconnection
% writen by Liangjin Song on 20190627
clear
indir='/home/simu/rec2d_B1.5T06Bs6Bg00/npc=150/';
outdir='/home/simu/rec2d_B1.5T06Bs6Bg00/out/npc=150/RF/';
rf='/home/simu/rec2d_B1.5T06Bs6Bg00/out/npc=150/RF/RF.mat';
di=40;
Lx=4800/di;
Ly=2400/di;
c=0.6;
z0=15;
e1=exp(-1);

rf=load(rf);
tt=rf.t;
zz=rf.z;
xx=rf.x;
nt=length(tt);
thk=zeros(1,nt);


for t=1:nt
    cd(indir);
    bz=read_data('Bz',tt(t));
    [~,lz]=get_line_data(bz,Lx,Ly,0,1,1);
    [lbz,lx]=get_line_data(bz,Lx,Ly,lz(zz(t)),1,0);

    in=xx(t);
    x1=lx(in);
    mbz=lbz(in);
    be=mbz*e1;
        
    while lbz(in)>be
        in=in+1;
        if in>2400
            in=in-2400;
        end
    end
    x2=lx(in);
    thk(t)=x2-x1;
end
plot(tt,thk,'*k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('\Delta X');
cd(outdir);
