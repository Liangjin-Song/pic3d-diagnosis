function en = parallel_electric(obj, prm)
%% calculate the parallel electric field acceleration
%% writen by Liangjin Song on 20210412
%%
wci=prm.value.wci;
e_para=obj.value.e_para;
v_para=obj.value.v_para;
e_para=obj.q*v_para.*e_para;
e_para=(e_para(1:end-1)+e_para(2:end))/2;
nt=length(e_para);
en=zeros(1, nt+1);

%% the energy
dt = obj.value.time(10) - obj.value.time(9);
for i=2:nt+1
    en(i)=en(i-1)+e_para(i-1)*dt/wci;
end

