%% function plot_electric_field_line
clear;
%% parameters
indir='E:\Asym\case1\data';
outdir='C:\Users\Liangjin\Pictures\Asym\case1\Test';
prm=slj.Parameters(indir,outdir);

tt = [6, 19, 32, 44, 57, 70];
ct = {'6', '19', '32', '44', '57', '70'};
st = {'-k', '-r', '-g', '-b', '--r', '--b'};


xz=30;
dir=1;
name = 'E';
cmpt='z';

norm=prm.value.vA;

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

xrange=[-5,5];

if dir == 1
    ll = prm.value.lz;
    labelx='Z [c/\omega_{pi}]';
    pstr='x';
else
    ll = prm.value.lx;
    labelx='X [c/\omega_{pi}]';
    pstr='z';
end
nt = length(tt);
lines=zeros(nt, length(ll));

for t=1:nt
    %% read data
    E=prm.read(name,tt(t));

    %% get line
    le=E.get_line2d(xz,dir,prm,norm);
    
    if cmpt == 'x'
        le = le.lx;
    elseif cmpt == 'y'
        le = le.ly;
    elseif cmpt == 'z'
        le = le.lz;
    else
        error('Parameters error!');
    end
    
    if dir == 1
        lines(t, :) = le';
    else
        lines(t, :) = le;
    end
end

%% plot figure
figure;
hold on
for t = 1:nt
    plot(ll, lines(t, :), char(st(t)), 'LineWidth', 2);
end

%% set figure
xlim(xrange);
legend(ct, 'Location', 'Best');
xlabel('Z [c/\omega_{pi}]');
ylabel([name, cmpt]);
title(['profiles  ', pstr,' = ',num2str(xz)]);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
%     print('-dpng','-r300',['E_t',num2str(tt(t)),'_line.png']);
%     close(gcf);

% end