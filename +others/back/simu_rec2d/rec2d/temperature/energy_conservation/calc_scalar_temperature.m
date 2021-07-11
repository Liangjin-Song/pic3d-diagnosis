function tp=calc_scalar_temperature(pxx,pyy,pzz,n)
%% calculate the average/scalar temperature
% writen by Liangjin Song on 20190810
% pxx, pyy, and pzz are the diagonal terms of the full pressure tensor
% n is the number density
% 
% tp is the average/scalar temperature
%%
tp=(pxx+pyy+pzz)/3;
tp=tp./n;
