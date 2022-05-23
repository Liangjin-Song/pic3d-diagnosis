% function plot_temperature_energy_density_conversion_as_time
clear;
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Energy\RF';
prm=slj.Parameters(indir,outdir);

dt=1;
tt=1:dt:48;

name='e';

xrange=[tt(1),tt(end)];
range = [1, prm.value.nx/2];

% the box and box size
iz = prm.value.nz/2;
nx=120;
nz=60;

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tem*prm.value.tle;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tem*prm.value.tle*prm.value.thl;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.tem;
else
    error('Parameters Error!');
end

% norm=prm.value.wci*tm/(prm.value.coeff * 2 * dt);
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(7,nt);


for t=1:nt
    %% calculation
    [~, divQ, PddivV, pdivV, VdivT] = slj.Physics.energy_density_conversion(prm, name, tt(t), dt);

    %% The velocity
    ix1 = pic3d.cold.RF_Position(prm, tt(t) - dt, range);
    ix2 = pic3d.cold.RF_Position(prm, tt(t) + dt, range);
    % vx = (prm.value.lx(ix2) - prm.value.lx(ix1))*prm.value.wci/(2*dt);
    vx = (ix2 - ix1)*prm.value.wci/(2*dt);
    ix = pic3d.cold.RF_Position(prm, tt(t), range);

    %% convection term
    T = slj.Physics.temperature(prm.read(['P', name], tt(t)), prm.read(['N', name], tt(t)));
    gT = T.gradient(prm);
    gT = vx*gT.x;

    %% dT/dt
    T1 = slj.Physics.temperature(prm.read(['P', name], tt(t) - dt), prm.read(['N', name], tt(t) - dt));
    T2 = slj.Physics.temperature(prm.read(['P', name], tt(t) + dt), prm.read(['N', name], tt(t) + dt));
    t2 = mean(T2.value(iz-nz:iz+nz,ix2-nx:ix2+nx),'all');
    t1 = mean(T1.value(iz-nz:iz+nz,ix1-nx:ix1+nx),'all');
    rate(1, t) = (t2 - t1)*prm.value.wci/(2*dt);

    rate(2,t)=mean(divQ.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(3,t)=mean(PddivV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(4,t)=mean(pdivV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(5,t)=mean(VdivT.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(6,t)=mean(gT(iz-nz:iz+nz,ix-nx:ix+nx),'all');
end
rate(7,:)=rate(2,:) + rate(3,:) + rate(4,:) + rate(5,:) + rate(6,:);
rate0=rate;

% rate(1,:)=smoothdata(rate0(1,:));
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:));
% rate(5,:)=smoothdata(rate0(5,:));
rate=rate/norm;

%% plot figure
f=figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-r', 'LineWidth', 2);
plot(tt, rate(4,:), '-m', 'LineWidth', 2);
plot(tt, rate(5,:), '-g', 'LineWidth', 2);
plot(tt, rate(6,:), '--g', 'LineWidth', 2);
plot(tt, rate(7,:), '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('dT/dt', '-2\nabla\cdot Q/3N', '- 2(P'' \cdot \nabla) \cdot V/3N', '-2p\nabla\cdot V/3N', ...
    '-V\cdot\nabla T', 'v\cdot \nabla T', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['dT',sfx,'/dt']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_temperature_energy_density_conversion_dt=',num2str(dt),'.png']);
% close(gcf);



% end
