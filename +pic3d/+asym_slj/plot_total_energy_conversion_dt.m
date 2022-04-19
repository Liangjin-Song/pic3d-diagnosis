%% plot the total energy conversion profiles
% written by Liangjin Song on 20220412 at Nanchang University
%%
clear;
%% parameters
indir='E:\Asym\dst1\data';
outdir='E:\Asym\dst1\out\Tmp';
prm=slj.Parameters(indir,outdir);

tt=20:0.5:60;
dt=0.5;
name='h';

xindex = [1120, prm.value.nx];
zindex = [420, 501];

xrange=[tt(1)-1,tt(end)+1];

% the box and box size
nx=80;
nz=40;


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

% norm=2*dt*prm.value.wci*prm.value.n0*tm/prm.value.coeff;
%% the loop
nt=length(tt);
rate=zeros(6,nt);


for t=1:nt
    %% calculation
    [~, divF, qVE] = slj.Physics.total_energy_conversion(prm, name, tt(t), dt, q, m);

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
    T = slj.Scalar(K.value + U.value);
    gT = T.gradient(prm);
    gT = vx*gT.x;

    %% dK/dt
    k1 = slj.Physics.kinetic_energy(m, prm.read(['N', name], tt(t) - dt), prm.read(['V', name], tt(t) - dt));
    k2 = slj.Physics.kinetic_energy(m, prm.read(['N', name], tt(t) + dt), prm.read(['V', name], tt(t) + dt));
    k2 = mean(k2.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    k1 = mean(k1.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    u2 = mean(U2.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    u1 = mean(U1.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    t2 = k2 + u2;
    t1 = k1 + u1;
    rate(1, t) = (t2 - t1)*prm.value.wci;

    rate(2,t)=mean(divF.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(3,t)=mean(qVE.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(4,t)=mean(gT(iz-nz:iz+nz,ix-nx:ix+nx),'all');
end

rate(5,:)=rate(2,:) + rate(3,:) + rate(4,:);

%% smooth
% lpTt = smoothdata(lpTt, 'movmean', 10);
% ldivF = smoothdata(ldivF, 'movmean', 13);
% lqVE = smoothdata(lqVE, 'movmean', 10);


%% plot figure
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:), '-b', 'LineWidth', 2);
plot(tt, rate(3,:), '-m', 'LineWidth', 2);
plot(tt, rate(4,:), '-r', 'LineWidth', 2);
plot(tt, rate(5,:), '--k', 'LineWidth', 2);

%% set figure
xlim(xrange);
legend('d(K+U)/dt','-\nabla \cdot (KV + Q + H)', 'qNV\cdot E', 'v\cdot \nabla(K+U)', 'Sum');
xlabel('Z [c/\omega_{pi}]');
set(get(gca, 'YLabel'), 'String', ['d(K',sfx,'+U',sfx,')/dt']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_total_energy_dt.png']);

