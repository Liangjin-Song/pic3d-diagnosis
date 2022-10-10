%% plot current sheet bz
% writen by Liangjin Song on 20191025
clear;
indir='/data/simulation/zhong/M100B01Bg035/data';
outdir='/data/simulation/zhong/M100B01Bg035/out';
tt=26;
wci=0.00075;
di=40;
ndx=600;
Lx=1200/di;
Ly=1200/di;
c=0.6;
vA=di*wci;
nt=length(tt);
for t=1:nt
    cd(indir);
    bz=read_datat('Bz',tt(t));
    bx=read_datat('Bx',tt(t));

    index=get_current_sheet_index(bx,0);
    lbz=zeros(1,ndx);
    for i=1:ndx
        lbz(i)=bz(index(i),i);
    end
end
plot(lbz);
