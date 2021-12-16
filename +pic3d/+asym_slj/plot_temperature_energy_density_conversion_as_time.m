% function plot_temperature_energy_density_conversion_as_time
clear;
%% parameters
indir='E:\Asym\Cold1\data';
outdir='E:\Asym\Cold1\out\Energy\Cold';
prm=slj.Parameters(indir,outdir);

tt=1:60;
dt=1;
name='h';

xrange=[tt(1)-1,tt(end)+1];

% the box and box size
nx=40;
nz=20;

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

%% the loop
nt=length(tt);
rate=zeros(6,nt);


for t=1:nt
    %% read data
    B=prm.read('B',tt(t));

    %% calculation
    [pTt, divQ, PddivV, pdivV, VdivT] = slj.Physics.energy_density_conversion(prm, name, tt(t), dt);

    %% the current sheet index in z-direction
    [~,inz]=min(abs(B.x));
    %% the bz value at the current sheet
    lbz=zeros(1,prm.value.nz);
    for i=1:prm.value.nx
        lbz(i)=B.z(inz(i),i);
    end
    %% find the RF position
    [~,lrf]=max(lbz);
    [~,rrf]=min(lbz);
    %% the x-line position
    [~,ix]=min(abs(lbz(lrf:rrf)));
    ix=ix+lrf-1;
    iz=inz(ix);
    
    ix=prm.value.nx/2;
    iz=prm.value.nz/2;

    rate(1,t)=mean(pTt.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(2,t)=mean(divQ.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(3,t)=mean(PddivV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(4,t)=mean(pdivV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(5,t)=mean(VdivT.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
end
rate(6,:)=rate(2,:) + rate(3,:) + rate(4,:) + rate(5,:);
rate0=rate;

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
xlim(xrange);
legend('\partial T/\partial t', '-2\nabla\cdot Q/3N', '- 2(P'' \cdot \nabla) \cdot V/3N', '-2p\nabla\cdot V/3N', ...
    '-V\cdot\nabla T', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial T',sfx,'/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
% print('-dpng','-r300',[sfx,'_temperature_energy_density_conversion_as_time.png']);
% close(gcf);



% end
