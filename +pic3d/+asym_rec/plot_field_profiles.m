%% function plot_electric_field_line
clear;
%% parameters
indir='Z:\asym\cold5_ds1';
outdir='C:\Users\Liangjin\Pictures\Test';
prm=slj.Parameters(indir,outdir);

tt = [6, 20, 30, 35, 40, 45, 50, 60];
ct = {'6', '20', '30', '35', '40', '45', '50', '60'};
st = {'--k', '--r', '--g', '--b', '-k', '-r', '-b', '-g'};

% case 2
% tt = [70, 75, 80, 85, 90];
% ct = {'70', '75', '80', '85', '90'};
% st = {'--k', '--r', '--g', '--b', '-k'};

xz=40;
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