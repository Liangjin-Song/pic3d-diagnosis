%% function plot_density_space_time_overview
%% parameters
clear;
% input/output directory
indir='E:\Asym\Cold2\data';
outdir='E:\Asym\Cold2\out\Global';
prm=slj.Parameters(indir,outdir);
% time
tt=20:60;
% variable name
var='E';
name = 'o';
component = 'z';
% line information
dir = 1;
xz = 40;
% normalization
norm=prm.value.vA;

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
elseif name == 'o'
    name = '';
    sfx = '';
else
    error('Parameters Error!');
end


nt=length(tt);
tsview = zeros(nxz, nt);

for t = 1:nt
    %% read data
    V=prm.read([var, name], tt(t));
    %% get line
    lf=V.get_line2d(xz,dir,prm,norm);
    if component=='x'
        ln=lf.lx;
    elseif component=='y'
        ln=lf.ly;
    elseif component=='z'
        ln=lf.lz;
    end
    
    tsview(:,t)=ln(:);
end



%% figure
extra.title=[var,sfx, component,', profiles   ', pstr, ' = ', num2str(xz)];
fig=slj.Plot();
fig.field2d(tsview, tt, ll, extra);
% fig.png(prm, [var,name, component,'_space_',pstr, '=', num2str(xz),'_time']);


%% end
