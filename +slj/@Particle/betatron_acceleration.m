function en = betatron_acceleration(obj, wci)
%% writen by Liangjin Song on 20210412
%% calculate the betatron acceleration
%%

%% magnetic field
B=sqrt(obj.value.bx.^2+obj.value.by.^2+obj.value.bz.^2);

%% dB/dt
dt = obj.value.time(10) - obj.value.time(9);
B=(B(2:end)-B(1:end-1))*wci/dt;

%% magnetic moment
en=(obj.value.mu(1:end-1)+obj.value.mu(2:end))/2;

%% betatron acceleration
en=B.*en;


