function en = Fermi_energy(obj, prm)
%% writen by Liangjin Song on 20210412
%% calculate the energy by Fermi acceleration
%%
wci=prm.value.wci;
fermi=obj.Fermi_acceleration(wci);
nt=length(fermi);
en=zeros(1, nt+1);

%% the energy
for i=2:nt+1
    en(i)=en(i-1)+fermi(i-1)*0.02/wci;
end

