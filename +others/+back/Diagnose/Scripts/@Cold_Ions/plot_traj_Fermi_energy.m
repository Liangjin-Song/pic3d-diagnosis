function plot_traj_Fermi_energy(obj)
%% plot the energy accelerated by Fermi acceleration
%% writen by Liangjin Song on 20210412
%% 
% particle id
id='1219325055';
% id='863723612';
name=['trajh_id',id];

%% read data
cd(obj.prm.value.indir);
prt=obj.prm.read_data(name);

%% figure
extra.xlabel='\Omega_{ci}t';
ly.l1=prt.value.k;
en=prt.acceleration_rate(obj.prm);
ly.l2=en.fermi;
ly.l3=en.beta;
ly.l4=en.epara;
ly.l5=en.fermi+en.beta+en.epara;
extra.LineStyle={'-', '-', '-', '-', '--'};
extra.LineColor={'k', 'b', 'r', 'm', 'r'};
extra.legend={'K', 'Fermi', 'Betatron', 'Epara', 'Sum'};
Figures.linen(prt.value.time, ly, extra);
end
