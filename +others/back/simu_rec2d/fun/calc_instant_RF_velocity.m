function v_RF=calc_instant_RF_velocity(lBz1,lBz2,xpost,wci,di)
%% calculate the RF velocity
% writen by Liangjin Song on 20180710
%   lBz1 and lBz2 are two time point of Bz line at reconnection position, and the time t(Bz1)<t(Bz2)
%   xpost is the x ordianry corresponding lBz1 and lBz2
%   wci is the ion gyrofrequency
%
% output
%   v_RF is the RF velocity, which defined at half time step
%   

%%
% get the index of max Bx position
[~,i1]=max(lBz1);
[~,i2]=max(lBz2);
Lx=xpost(end);
pos1=xpost(i1);
pos2=xpost(i2);
if pos1<Lx/2
    pos1=pos1+Lx;
end
if pos2<Lx/2
    pos2=pos2+Lx;
end

% velocity
v_RF=pos2-pos1;
v_RF=v_RF*wci*di;
