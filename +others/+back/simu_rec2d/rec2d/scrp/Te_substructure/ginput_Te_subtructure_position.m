%% ginput the position of the Te subtructure
% writen by Liangjin Song on 20190817
clear;
indir='/data/simulation/rec2d_M100SBg00Sx/data/';
outdir='/data/simulation/rec2d_M100SBg00Sx/out/Te_substructure/overview/';
tt=35:0.5:55;
di=40;
z0=15;
ndx=4800;
ndy=2400;
Lx=ndx/di;
Ly=ndy/di;
nt=length(tt);
for t=1:nt
    cd(indir);
    p=read_data('prese',tt(t));
    n=read_data('Dense',tt(t));
    ss=read_data('stream',tt(t));
    [pxx,~,~,pyy,~,pzz]=reshap_pressure(p,ndy,ndx);
    tp=calc_scalar_temperature(pxx,pyy,pzz,n);
    [ltp,~]=get_line_data(tp,Lx,Ly,z0,1,0);


end
