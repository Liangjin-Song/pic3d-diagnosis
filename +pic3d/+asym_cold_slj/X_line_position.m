% function X_line_position
clear;
%% parameters
indir='E:\Asym\Cold\data';
outdir='E:\Asym\Cold\out\Global';
prm=slj.Parameters(indir,outdir);

tt=0:200;
nt=length(tt);

px=zeros(nt,1);
pz=zeros(nt,1);

for t=1:nt
    B=prm.read('B',tt(t));
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
    px(t)=ix;
    pz(t)=iz;
end

extra=[];
extra.xlabel='\Omega_{ci}t';
extra.ylabell='X [c/\omega_{pi}]';
extra.ylabelr='Z [c/\omega_{pi}]';
f=slj.Plot();
f.plotyy1(tt, prm.value.lx(px), prm.value.lz(pz), extra);
pos=get(gca,'Position');
pos(1)=pos(1)+0.01;
pos(2)=pos(2)+0.05;
pos(3)=pos(3)-0.05;
set(gca,'Position',pos);
f.png(prm,'X-line_position');