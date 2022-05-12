% function plot_thermal_energy_conversion_dt
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Tmp';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=20:dt:60;
name='h';

xindex = [1201, prm.value.nx];
zindex = [420, 501];

xrange=[tt(1)-1,tt(end)+1];

% the box and box size
%% 1
% nx = 50;
% nz = 10;

%% 2
nx = 120;
nz = 20;

%% 3
% nx = 80;
% nz = 20;

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tlm;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.thm;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.tem;
else
    error('Parameters Error!');
end

% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
norm=prm.value.wci*prm.value.n0*tm/(prm.value.coeff*2*dt);

%% the loop
nt=length(tt);
rate=zeros(6,nt);


for t=1:nt
    %% calculation
    [~, divPV, divQ, divH]= slj.Physics.thermal_energy_conversion(prm, name, tt(t), dt);
    %% The velocity
    U1 = slj.Physics.thermal_energy(prm.read(['P', name], tt(t) - dt));
    U2 = slj.Physics.thermal_energy(prm.read(['P', name], tt(t) + dt));
    [vx, vz] = pic3d.asym_slj.calc_structure_velocity(U2.value, U1.value, prm.value.di, prm.value.wci, xindex, zindex);

    %% convection term
    U = slj.Physics.thermal_energy(prm.read(['P', name], tt(t)));
    subU = U.value(zindex(1):zindex(2), xindex(1):xindex(2));
    M = max(max(subU));
    [iz, ix] = find(subU == M);
    iz = iz + zindex(1) - 1;
    ix = ix + xindex(1) - 1;

    gU = U.gradient(prm);
    gU = vx*gU.x;

    %% du/dt
    u2 = mean(U2.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    u1 = mean(U1.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(1, t) = (u2 - u1)*prm.value.wci/(2*dt);

    %% get the average value
    rate(2,t)=mean(divPV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(3,t)=mean(divQ.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(4,t)=mean(divH.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(5,t)=mean(gU(iz-nz:iz+nz,ix-nx:ix+nx),'all');
end

rate0 = rate;

% rate(1,:)=smoothdata(rate0(1,:), 'movmean', 1);
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:), 'movmean', 1);
% rate(5,:)=smoothdata(rate0(5,:));

rate(6,:)=rate(2,:) + rate(3,:) + rate(4,:) + rate(5,:);

%% plot figure
f=figure;
plot(tt, rate(1,:)/norm, '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:)/norm, '-b', 'LineWidth', 2);
plot(tt, rate(3,:)/norm, '-m', 'LineWidth', 2);
plot(tt, rate(4,:)/norm, '-r', 'LineWidth', 2);
plot(tt, rate(5,:)/norm, '-g', 'LineWidth', 2);
plot(tt, rate(6,:)/norm, '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('dU/dt', '(\nabla\cdot P) \cdot V', '-\nabla\cdot q', '-\nabla\cdot(UV + P\cdot V)', 'v\cdot \nabla U', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['dU',sfx,'/dt']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
% print('-dpng','-r300',[sfx,'_thermal_energy_conversion_as_dt=',num2str(dt),'.png']);
% close(gcf);



% end
