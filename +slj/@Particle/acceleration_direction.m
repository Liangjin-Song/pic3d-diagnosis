function en = acceleration_direction(obj, prm)
%% writen by Liangjin Song on 20210412
%% the acceleration in three direction
%%
wci=prm.value.wci;
%% velocity
vx=obj.value.vx;
vy=obj.value.vy;
vz=obj.value.vz;

%% electric field
ex=obj.value.ex;
ey=obj.value.ey;
ez=obj.value.ez;
% ex=obj.filter1d(ex);
% ey=obj.filter1d(ey);
% ez=obj.filter1d(ez);

%% efficiency
ex=(ex.*vx)*obj.q*obj.weight;
ey=(ey.*vy)*obj.q*obj.weight;
ez=(ez.*vz)*obj.q*obj.weight;

%% energy
ex=(ex(1:end-1)+ex(2:end))./2;
ey=(ey(1:end-1)+ey(2:end))./2;
ez=(ez(1:end-1)+ez(2:end))./2;

n=length(ex);
en.x=zeros(1,n+1);
en.y=zeros(1,n+1);
en.z=zeros(1,n+1);
dt = obj.value.time(10) - obj.value.time(9);
for i=2:n+1
    en.x(i)=en.x(i-1)+ex(i-1)*dt/wci;
    en.y(i)=en.y(i-1)+ey(i-1)*dt/wci;
    en.z(i)=en.z(i-1)+ez(i-1)*dt/wci;
end

