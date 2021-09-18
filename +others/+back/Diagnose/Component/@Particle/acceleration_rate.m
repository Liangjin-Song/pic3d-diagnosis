function en = acceleration_rate(obj, prm)
%% writen by Liangjin Song on 20210412
%% calculate the energy acceleration rate
%%

%% smooth the electric field
obj.value.ex=obj.filter1d(obj.value.ex);
obj.value.ey=obj.filter1d(obj.value.ey);
obj.value.ez=obj.filter1d(obj.value.ez);
obj.value.e_para=obj.filter1d(obj.value.e_para);
obj.value.e_perp=obj.filter1d(obj.value.e_perp);

%% the fermi acceleration
en.fermi=obj.Fermi_energy(prm);

%% the parallel field acceleration
en.epara=obj.parallel_electric(prm);

%% the betatron acceleration
en.beta=obj.betatron_energy(prm);

%% the perpendicular acceleration
en.eperp=obj.perpendicular_energy(prm);

