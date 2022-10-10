function phase1d(phase,lx,lv)
%for the  1d space-phase diagram
%parameters
ndx=size(phase,2);
ndv=size(phase,1)-1; 
%
xx=0:lx/ndx:(lx-lx/ndx);
vv=-lv:2*lv/ndv:lv;
imagesc(xx,vv,phase)