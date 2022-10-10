% function current_sheet_thickness
% clear;
%%
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Global';
prm=slj.Parameters(indir,outdir);

tt=0:200;
nt=length(tt);

left=zeros(1,nt);
middle=zeros(1,nt);
right=zeros(1,nt);

for t=1:nt
    B=prm.read('B',tt(t));
    J=prm.read('J',tt(t));
    %% the current sheet index in z-direction
    [~,inz]=min(abs(B.x));
    %% the bz value at the current sheet
    lbz=zeros(1,prm.value.nz);
    for i=1:prm.value.nx
        lbz(i)=B.z(inz(i),i);
    end
    %% find the RF position
    [~,lrf]=max(lbz);
    [~,rrf]=min(lbz);
    %% the x-line position
    [~,ix]=min(abs(lbz(lrf:rrf)));
    ix=ix+lrf-1;
    iz=inz(ix);
    %% get the current line
    lj=J.get_line2d(prm.value.lx(ix), 1, prm, 1);
    [~,in]=min(lj.ly);
    for i=in:-1:1
        if lj.ly(i)>0
            lin=i;
            break;
        end
    end
    for i=in:length(lj.ly)
        if lj.ly(i)>0
            rin=i;
            break;
        end
    end
    left(t)=lin;
    middle(t)=in;
    right(t)=rin;
end