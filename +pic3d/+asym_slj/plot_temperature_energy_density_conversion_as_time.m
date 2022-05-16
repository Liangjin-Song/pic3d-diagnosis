% function plot_temperature_energy_density_conversion_as_time
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\partial_t\region3';
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=20:dt:60;
name='h';

xrange=[tt(1)-1,tt(end)+1];

% the box and box size
% xindex = [1201, prm.value.nx];
% zindex = [441, 501];
% xindex = [881, 1120];
% zindex = [441, 621];
xindex = [1, 321];
zindex = [441, 621];

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
else
    error('Parameters Error!');
end

% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(6,nt);


for t=1:nt
    %% calculation
    [pTt, divQ, PddivV, pdivV, VdivT] = slj.Physics.energy_density_conversion(prm, name, tt(t), dt);

    rate(1,t)=sum(pTt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=sum(divQ.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(3,t)=sum(PddivV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(4,t)=sum(pdivV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(5,t)=sum(VdivT.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end
rate(6,:)=rate(2,:) + rate(3,:) + rate(4,:) + rate(5,:);
rate0=rate;
rate = rate/norm;

% rate(1,:)=smoothdata(rate0(1,:));
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:));
% rate(5,:)=smoothdata(rate0(5,:));


%% plot figure
f=figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-r', 'LineWidth', 2);
plot(tt, rate(4,:), '-m', 'LineWidth', 2);
plot(tt, rate(5,:), '-g', 'LineWidth', 2);
plot(tt, rate(6,:), '--k', 'LineWidth', 2);


%% set figure
legend('\partial T/\partial t', '-2\nabla\cdot Q/3N', '- 2(P'' \cdot \nabla) \cdot V/3N', '-2p\nabla\cdot V/3N', ...
    '-V\cdot\nabla T', 'Sum', 'Location', 'Best');
xlim(xrange);
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial T',sfx,'/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_temperature_energy_density_conversion_as_time_dt=',num2str(dt),'.png']);
% close(gcf);



% end
