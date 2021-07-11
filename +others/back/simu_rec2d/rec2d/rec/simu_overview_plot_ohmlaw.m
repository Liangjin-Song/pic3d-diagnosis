%%to make overview plots of the Reconnection simulation results
clear all
%%
%% input the parameters
Lx=200;
Ly=100;
nx=2000;
ny=1000;
xrange=[0,200];
yrange=[-50,0];
%%
tt=26:1:100;  % time points
varname={'evb'};
norm=[0.04];
fline=1; % set 1 to plot stream superposed
dirr='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\';
outdir='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\figures\';
cd(dirr)
%%
%% to add the locations of each regions in the plot
load xline.mat
load mline.mat
load si.mat
%%=====================the loop===========================
nt=length(tt);
nvar=length(varname);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
%%--------------------load data-------------------------- 
if fline==1, 
fname=['stream_t',it,'.mat'];
if exist(fname,'file')>0,
% ss=load(['stream_t',it,'.txt']);
load(fname);
eval(['ss=stream_t',it,';']);
end
end
%%
for j=1:nvar
fname=['ohmy_t',it,'.mat'];
if exist(fname,'file')==0, continue; end
% dat=load([var,'_t',it,'.txt']);
load(fname);
eval(['ohm=ohmy_t',it,';'])
%% re-arrange the data
evb=ohm(:,1)-ohm(:,3);  %E+VeXB
evb=reshape(evb,nx,ny);
evb=evb';
%%----------make plots and output figures----------------------
plot_field(evb,Lx,Ly,norm(j));
cr=caxis;
crmin=min(abs(cr));
hold on

if fline==1&&exist('ss','var')>0,
plot_stream(ss,Lx,Ly,30);
end
%%
caxis([-crmin crmin]);
xlim(xrange)
ylim(yrange)
var=varname{j};
%%
%% to mark different regions in the plots
ind=find(time_xline==tt(i));
if isempty(ind)==0, 
    xpos=xline{ind};
    n=length(xpos);
    if n>1,
        n=n-1;
        xpos=xpos(2:end);
        for kk=1:n/2
        xmin=xpos((kk-1)*2+1);
        if xmin<0,xmin=0; end
        xmax=xpos((kk-1)*2+2);
        if xmax>Lx,xmax=Lx; end
        rectangle('position',[xmin,-30,xmax-xmin,10],'linestyle','--','Edgecolor','k','linewidth',1.);
        end
    end
end
%%
ind=find(time_mline==tt(i));
if isempty(ind)==0, 
    xpos=mline{ind};
    n=length(xpos);
    if n>1,
        n=n-1;
        xpos=xpos(2:end);
        for kk=1:n/2
        xmin=xpos((kk-1)*2+1);
        if xmin<0,xmin=0; end
        xmax=xpos((kk-1)*2+2);
        if xmax>Lx,xmax=Lx; end
        rectangle('position',[xmin,-30,xmax-xmin,10],'linestyle','--','Edgecolor','r','linewidth',1.);
        end
    end
end
%%
ind=find(time_si==tt(i));
if isempty(ind)==0, 
    xpos=si{ind};
    n=length(xpos);
    if n>1,
        n=n-1;
        xpos=xpos(2:end);
        for kk=1:n/2
        xmin=xpos((kk-1)*2+1);
        if xmin<0,xmin=0; end
        xmax=xpos((kk-1)*2+2);
        if xmax>Lx,xmax=Lx; end
        rectangle('position',[xmin,-30,xmax-xmin,10],'linestyle','--','Edgecolor','b','linewidth',1.);
        end
    end
end
   
%%%%%%%
print('-r300','-dpng',[outdir,var,'_region_t',it,'.png']);
close(gcf)
%%
end
clear ohm*
%%
end










