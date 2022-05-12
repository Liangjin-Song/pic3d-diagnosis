% function plot_kinetic_energy_conversion_as_time
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Tmp';
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=20:dt:60;
name='h';

xindex = [1120, prm.value.nx];
zindex = [420, 501];

xrange=[tt(1)-1,tt(end)+1];

% the box and box size
nx=50;
nz=10;

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
    [~, divKV, qVE, divPV] = slj.Physics.kinetic_energy_conversion(prm, name, tt(t), dt, q, m);

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

    K = slj.Physics.kinetic_energy(m, prm.read(['N', name], tt(t)), prm.read(['V', name], tt(t)));
    gK = K.gradient(prm);
    gK = vx*gK.x;

    %% dK/dt
    k1 = slj.Physics.kinetic_energy(m, prm.read(['N', name], tt(t) - dt), prm.read(['V', name], tt(t) - dt));
    k2 = slj.Physics.kinetic_energy(m, prm.read(['N', name], tt(t) + dt), prm.read(['V', name], tt(t) + dt));
    k2 = mean(k2.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    k1 = mean(k1.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(1, t) = (k2 - k1)*prm.value.wci/(2*dt);

    rate(2,t)=mean(divKV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(3,t)=mean(qVE.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(4,t)=mean(divPV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(5,t)=mean(gK(iz-nz:iz+nz,ix-nx:ix+nx),'all');
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
plot(tt, rate(1,:)/norm, '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:)/norm, '-b', 'LineWidth', 2);
plot(tt, rate(3,:)/norm, '-m', 'LineWidth', 2);
plot(tt, rate(4,:)/norm, '-r', 'LineWidth', 2);
plot(tt, rate(5,:)/norm, '-g', 'LineWidth', 2);
plot(tt, rate(6,:)/norm, '--k', 'LineWidth', 2);


%% set figure
xlim(xrange);
legend('dK/dt', '-\nabla\cdot(KV)', 'qNV\cdot E', '- (\nabla\cdot P) \cdot V', 'v\cdot \nabla K', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['dK',sfx,'/dt']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
% print('-dpng','-r300',[sfx,'_bulk_kinetic_conversion_dt.png']);
% close(gcf);



% end