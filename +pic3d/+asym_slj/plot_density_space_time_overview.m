%% function plot_density_space_time_overview
%% parameters
clear;
% input/output directory
indir='E:\Asym\Case2\data';
outdir='E:\Asym\Case2\out\Energy';
prm=slj.Parameters(indir,outdir);
% time
tt=0:60;
% variable name
var='N';
name = 'h';
% line information
dir = 1;
xz = 25;
% normalization
norm=1;

%%
extra=[];
if dir == 1
    ll = prm.value.lz;
    extra.ylabel='Z [c/\omega_{pi}]';
    pstr='x';
    nxz=prm.value.nz;
else
    ll = prm.value.lx;
    extra.ylabel='X [c/\omega_{pi}]';
    pstr='z';
    nxz=prm.value.nx;
end
extra.xlabel='\Omega_{ci}t';

if name == 'l'
    sfx='ih';
elseif name == 'h'
    sfx='ic';
elseif name == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end


nt=length(tt);
tsview = zeros(nxz, nt);

for t = 1:nt
    %% read data
    N=prm.read([var, name], tt(t));
    %% get line
    ln=N.get_line2d(xz,dir,prm,norm);
    tsview(:,t)=ln(:);
end



%% figure
extra.title=[var,sfx,', profiles   ', pstr, ' = ', num2str(xz)];
fig=slj.Plot();
fig.field2d(tsview, tt, ll, extra);
fig.png(prm, [var,name,'_space_',pstr, '=', num2str(xz),'_time']);


%% end