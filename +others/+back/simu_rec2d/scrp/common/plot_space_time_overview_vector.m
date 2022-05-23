%% function plot_density_space_time_overview
%% parameters
clear;
% input/output directory
indir='E:\Simulation\rec2d_M100SBg00Sx\data';
outdir='E:\Simulation\rec2d_M100SBg00Sx\out\line\DF';

% time
tt=20:65;
% variable name
var='E';
name = '';
component = 'x';
% line information
dir = 0;
xz = 15;
extra.ylabel='X [c/\omega_{pi}]';
extra.xlabel='\Omega_{ci}t';
% normalization
norm=1;
norm=0.03;

%%
di = 40;
ndx = 4800;
ndy = 2400;
Lx=ndx/di;
Ly=ndy/di;

nxz = ndx;
nt=length(tt);
tsview = zeros(nxz, nt);

for t = 1:nt
    %% read data
    cd(indir);
    V=read_data([var, name, component],tt(t));
    [ln,ll]=get_line_data(V,Lx,Ly,xz,norm,dir);
    
    ln=smoothdata(ln,'movmean',20);
    tsview(:,t)=ln(:);
end



%% figure
extra.title=[var, component,', profiles   z = ', num2str(xz)];
fig=slj.Plot();
fig.field2d(tsview, tt, ll, extra);
% fig.png(prm, [var,name, component,'_space_',pstr, '=', num2str(xz),'_time']);


%% end
