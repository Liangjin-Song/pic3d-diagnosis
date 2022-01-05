function en = betatron_energy(obj, prm)
%% writen by Liangjin Song on 20210412
%% the increase energy by betatron acceleration
%% 

wci=prm.value.wci;
beta=obj.betatron_acceleration(wci);
nt=length(beta);
en=zeros(1, nt+1);

%% the energy
dt=1/1000;
for i=2:nt+1
    en(i)=en(i-1)+beta(i-1)*dt/wci;
end

