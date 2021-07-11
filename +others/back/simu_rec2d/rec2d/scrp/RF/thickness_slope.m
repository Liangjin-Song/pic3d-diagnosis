%% RF thickness calculate by slope
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

thk=zeros(1,nt);

for t=1:nt
    cd(indir);
    bz=read_data('Bz',tt(t));
    [lbz,lx]=get_line_data(bz,Lx,Ly,z0,1,0);
    px=calc_partial_x(lbz,2);

    px(1:1000)=0;
    px(1800:end)=0;
    px=-px;

    [mpx,in0]=max(px);
    
    in=in0;
    pe=mpx*e1;
    while px(in)>pe
        in=in+1;
    end
    x2=lx(in);
    in=in0;
    while px(in)>pe
        in=in-1;
    end
    x1=lx(in);

    thk(t)=x2-x1;
end
plot(tt,thk,'*k','LineWidth',2);
xlabel('\Omega_{ci}t');
ylabel('\Delta X');
cd(outdir);
