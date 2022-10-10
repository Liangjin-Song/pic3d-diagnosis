%% RF thickness calculated by half width
% writen by Liangjin Song on 20190627
clear
indir='/home/simu/rec2d_M100SBg00Tie2/data/';
outdir='/home/simu/rec2d_M100SBg00Tie2/out/DF/thickness/';
tt=45:70;
di=40;
Lx=4800/di;
Ly=2400/di;
c=0.6;
z0=15;
nt=length(tt);
e1=exp(-1);
% e1=0.5;

thk=zeros(1,nt);

for t=1:nt
    cd(indir);
    bz=read_data('Bz',tt(t));
    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
    [mbz,in]=max(lbz);
    x1=lx(in);
    be=mbz*e1;

    while lbz(in)>be
        in=in+1;
        if in>2400
            in=in-2400;
        end
    end
    x2=lx(in);
    if (x2-60)*(x1-60)<0
        x2=x2+120;
    end
    thk(t)=x2-x1;
end
plot(tt,thk,'*k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('\Delta X');
cd(outdir);
