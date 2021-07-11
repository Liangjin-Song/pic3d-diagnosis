%%to make overview plots of the Reconnection simulation results
clear all
%%
%% input the parameters
addpath('E:\Source\rec')

Lx=4800;
Ly=2400;
xrange=[0,4800];
yrange=[-1200, 1200];
%%
tt=21:1:22;  % time points
varname={'vzi'};
norm=[0.03];
fline=1; % set 1 to plot stream superposed
dirr='E:\Data\';
outdir='E:\Out\';
cd(dirr)
%%=====================the loop===========================
nt=length(tt);
nvar=length(varname);
for i=1:nt
it=num2str(tt(i),'%06.2f');
% it=[it(1:3),'_',it(5:6)];
%%--------------------load data-------------------------- 
if fline==1, 
% fname=['stream_t',it,'.mat'];
% if exist(fname,'file')>0,
ss=load(['stream_t',it,'.txt']);
% load(fname);
% eval(['ss=stream_t',it,';']);
end
% end
%%
for j=1:nvar
var=varname{j};
% fname=[var,'_t',it,'.mat'];
% if exist(fname,'file')==0, continue; end
dat=load([var,'_t',it,'.txt']);
% load(fname);
% eval(['dat=',var,'_t',it,';'])
%% 
%%----------make plots and output figures----------------------
plot_field(dat,Lx,Ly,norm(j));
color_range=caxis;
hold on

if fline==1&&exist('ss','var')>0,
plot_stream(ss,Lx,Ly,40);
caxis(color_range);
end

xlim(xrange)
ylim(yrange)
print('-r300','-dpng',[outdir,var,'_t',it,'.png']);
close(gcf)
%%
end
clear Bx* By* Bz* Ex* Ey* Ez* Dens* stream* vx* vy* vz* eleaven* flw*
%%
end



