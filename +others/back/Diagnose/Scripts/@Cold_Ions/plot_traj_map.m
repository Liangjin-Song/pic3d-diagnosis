function plot_traj_map(obj) % , prt, value, extra)
%% writen by Liangjin Song on 20210411
%% plot trajectory and the value, the value is indicated by map
%%
%% parameters
% particle's id
id='1219325055';

% field name and time
tt1=15;
nfd1='B';
tt2=30;
nfd2='B';

%% normalization
% the energy of cold ions
norm=obj.prm.value.tem*obj.prm.value.tle*obj.prm.value.thl/obj.prm.value.coeff;
% the field
norm1=1;
norm2=2;

%% read data
name=['trajh_id',id];
prt=obj.prm.read_data(char(name));
fd1=obj.prm.read_data(nfd1, tt1);
ss1=obj.prm.read_data('stream', tt1);
fd2=obj.prm.read_data(nfd2, tt2);
ss2=obj.prm.read_data('stream', tt2);

%% the energy normalization
prt=prt.norm_energy(norm);

%% plot field
f=figure;
extra=[];

%% the field and the time
subplot(1, 2, 1);
Figures.plot_overview2d(fd1.value.z, ss1.value, norm1, obj.prm, extra);
end
