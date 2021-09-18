function data=read_data(var,t)
%% writen by Liangjin Song on 20190121
% read 2D PIC simulation data
%
% var is the variable name, which is a string
% t is the time, which is a integer
%
% data is the simulation data, which is a metrix
%%

%%
% change to a string
t=num2str(t,'%06.2f');
% data file is mat-file
data=importdata([var,'_t',t,'.mat']);
% data=load([var,'_t',t,'.txt']);
