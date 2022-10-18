%% add all distribution function
function dist = func_add_all_distribution_function(prm, spn, t)
%%
% @brief: add all the distribution function
% @info: writen by Liangjin Song on 20221018
%%
post1 = '_x0-400_y418-661_z0-1';
post2 = '_x400-800_y418-661_z0-1';
post3 = '_x800-1200_y418-661_z0-1';
post4 = '_x1200-1600_y418-661_z0-1';
post5 = '_x1600-2000_y418-661_z0-1';

%% read data
t = t / prm.value.wci;
spc1 = prm.read(['PV',spn,'_ts',num2str(t), post1]);
spc2 = prm.read(['PV',spn,'_ts',num2str(t), post2]);
spc3 = prm.read(['PV',spn,'_ts',num2str(t), post3]);
spc4 = prm.read(['PV',spn,'_ts',num2str(t), post4]);
spc5 = prm.read(['PV',spn,'_ts',num2str(t), post5]);

%% add data
dist = spc1.add(spc2);
dist = dist.add(spc3);
dist = dist.add(spc4);
dist = dist.add(spc5);
end