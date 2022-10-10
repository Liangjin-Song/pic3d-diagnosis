function en = betatron_acceleration(obj, wci)
%% writen by Liangjin Song on 20210412
%% calculate the betatron acceleration
%%

%% magnetic field
B=sqrt(obj.value.bx.^2+obj.value.by.^2+obj.value.bz.^2);

%% dB/dt
B=(B(2:end)-B(1:end-1))*wci/0.02;

%% magnetic moment
en=(obj.value.mu(1:end-1)+obj.value.mu(2:end))/2;

%% betatron acceleration
en=B.*en;


