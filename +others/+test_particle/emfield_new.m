function [B,E]=emfield_new(b0,e0,r0,model,param,bw,ew,t)
%% obtain the electromagnetic field at the position r0
%% the electromagnetic field model is given by the character model,including 
%% uniform,nonuniform,harris,wave etc.
%% ---------------written by M.Zhou on July 7, 2022----------------
B=zeros(1,3);
E=zeros(1,3);
hx=param(1);
hz=param(2);
kv=param(3:5);
freq=param(6);
dphi=param(7);
%%
if strcmp(model,'uniform')==1
    B(1)=b0(1);
    B(2)=b0(2);
    B(3)=b0(3);
    E(1)=e0(1);
    E(2)=e0(2);
    E(3)=e0(3);
    
elseif strcmp(model,'harris')==1
    B(1)=b0(1)*tanh(r0(3)/hz);
    B(2)=b0(2);
    B(3)=b0(3)*r0(1)/hx;
    E(1)=e0(1);
    E(2)=e0(2);
    E(3)=e0(3);

elseif strcmp(model,'EMwave')==1
    B(1)=b0(1)+bw(1)*cos(dot(kv,r0)-2*pi*freq*t);
    B(2)=b0(2)+bw(2)*cos(dot(kv,r0)-2*pi*freq*t);
    B(3)=b0(3)+bw(3)*cos(dot(kv,r0)-2*pi*freq*t-pi/2);
    E(1)=e0(1)+ew(1)*cos(dot(kv,r0)-2*pi*freq*t);
    E(2)=e0(2)+ew(2)*cos(dot(kv,r0)-2*pi*freq*t-pi);
    E(3)=e0(3)+ew(3)*cos(dot(kv,r0)-2*pi*freq*t+pi/2);

elseif strcmp(model,'ESwave')==1
    B(1)=b0(1);
    B(2)=b0(2);
    B(3)=b0(3);
    E(1)=e0(1)+ew(1)*cos(dot(kv,r0)-2*pi*freq*t);
    E(2)=e0(2)+ew(2)*cos(dot(kv,r0)-2*pi*freq*t);
    E(3)=e0(3)+ew(3)*cos(dot(kv,r0)-2*pi*freq*t);
end



    
    
    
    
    