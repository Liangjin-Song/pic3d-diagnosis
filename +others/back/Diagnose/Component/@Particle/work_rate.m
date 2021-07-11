function row = work_rate(en, wci)
%% writen by Liangjin Song on 20210412
%% calculate the rate of work
%%
row=(en(2:end)-en(1:end-1))*wci/0.2;

