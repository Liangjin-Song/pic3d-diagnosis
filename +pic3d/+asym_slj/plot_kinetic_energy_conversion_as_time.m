% function plot_kinetic_energy_conversion_as_time
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Tmp';
prm=slj.Parameters(indir,outdir);

tt=20:0.5:60;
dt=0.5;
name='h';

xrange=[tt(1)-1,tt(end)+1];

% the box and box size
nx=10;
nz=10;
xindex = [1120, prm.value.nx];
zindex = [420, 501];

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
rate=zeros(5,nt);


for t=1:nt
    %% read data
    % B=prm.read('B',tt(t));

    %% calculation
    [pKt, divKV, qVE, divPV] = slj.Physics.kinetic_energy_conversion(prm, name, tt(t), dt, q, m);

    %% the current sheet index in z-direction
%     [~,inz]=min(abs(B.x));
    %% the bz value at the current sheet
%     lbz=zeros(1,prm.value.nz);
%     for i=1:prm.value.nx
%         lbz(i)=B.z(inz(i),i);
%     end
    %% find the RF position
%     [~,lrf]=max(lbz);
%     [~,rrf]=min(lbz);
    %% the x-line position
%     [~,ix]=min(abs(lbz(lrf:rrf)));
%     ix=ix+lrf-1;
%     iz=inz(ix);
% 
%     rate(1,t)=mean(pKt.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
%     rate(2,t)=mean(divKV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
%     rate(3,t)=mean(qVE.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
%     rate(4,t)=mean(divPV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');

    

    rate(1,t)=mean(pKt.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=mean(divKV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(3,t)=mean(qVE.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(4,t)=mean(divPV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end
rate(5,:)=rate(2,:) + rate(3,:) + rate(4,:);
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
plot(tt, rate(3,:), '-m', 'LineWidth', 2);
plot(tt, rate(4,:), '-r', 'LineWidth', 2);
plot(tt, rate(5,:), '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('\partial K/\partial t', '-\nabla\cdot(KV)', 'qNV\cdot E', '- (\nabla\cdot P) \cdot V', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['\partial K',sfx,'/\partial t']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_bulk_kinetic_conversion_as_time.png']);
% close(gcf);



% end