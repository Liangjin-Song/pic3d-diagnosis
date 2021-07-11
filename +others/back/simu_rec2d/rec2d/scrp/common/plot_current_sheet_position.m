%% plot the Bz overview and the current sheet
% writen by Liangjin Song on 20191217
indir='/data/simulation/M25SBg00Sx_low_vte/data/';
outdir='/data/simulation/M25SBg00Sx_low_vte/out/overview/';

ndx=6000;
ndy=3000;
di=40;
Lx=ndx/di;
Ly=ndy/di;
yy=-Ly/2:Ly/ndy:Ly/2-Ly/ndy;

c=0.6;
tt=35:0.5:65;
nt=length(tt);
pcs=zeros(1,nt);
for t=1:nt
    cd(indir);
    bx=read_data('Bx',tt(t));
    bx=bx/c;
    bz=read_data('Bz',tt(t));
    bz=bz/c;

    % get the current sheet index
    cs=get_current_sheet_index(bx,1);
    lbz=get_current_sheet_field(cs,bz);
    [~,mbz]=max(lbz);
    pcs(t)=yy(cs(mbz));
end
cd(outdir);
