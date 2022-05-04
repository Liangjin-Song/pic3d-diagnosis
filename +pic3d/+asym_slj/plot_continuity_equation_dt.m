% function plot_continuity_equation_dt
clear;
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\Tmp';
prm=slj.Parameters(indir,outdir);

dt=0.5;
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
norm=2*dt*prm.value.wci*prm.value.n0;

%% the loop
nt=length(tt);
rate=zeros(4,nt);


for t=1:nt
    %% calculation
    [~, divNV] = slj.Physics.continuity_equation(prm, name, tt(t), dt);

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

    N = prm.read(['N', name], tt(t));
    gN = N.gradient(prm);
    gN = vx*gN.x;

    %% dK/dt
    n1 = prm.read(['N', name], tt(t) - dt);
    n2 = prm.read(['N', name], tt(t) + dt);
    n2 = mean(n2.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    n1 = mean(n1.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(1, t) = (n2 - n1)*prm.value.wci;

    rate(2,t)=mean(divNV.value(iz-nz:iz+nz,ix-nx:ix+nx),'all');
    rate(3,t)=mean(gN(iz-nz:iz+nz,ix-nx:ix+nx),'all');
end
rate(4,:)=rate(2,:) + rate(3,:);
rate0=rate;

% rate(1,:)=smoothdata(rate0(1,:));
% rate(2,:)=smoothdata(rate0(2,:)); % ,'movmean',7);
% rate(3,:)=smoothdata(rate0(3,:)); % ,'movmean',7);
% rate(4,:)=smoothdata(rate0(4,:));
% rate(5,:)=smoothdata(rate0(5,:));


%% plot figure
f=figure;
plot(tt, rate(1,:)/norm, '-k', 'LineWidth', 2); hold on
plot(tt, rate(2,:)/norm, '-r', 'LineWidth', 2);
plot(tt, rate(3,:)/norm, '-b', 'LineWidth', 2);
plot(tt, rate(4,:)/norm, '--k', 'LineWidth', 2);
hold off


%% set figure
xlim(xrange);
legend('dN/dt', '-\nabla\cdot(NV)', 'v\cdot \nabla N', 'Sum', 'Location', 'Best');
xlabel('\Omega_{ci} t');
set(get(gca, 'YLabel'), 'String', ['N',sfx,'/dt']);
set(gca,'FontSize',14);

%% save figure
cd(outdir);
print('-dpng','-r300',[sfx,'_continuity_equation_dt_sum.png']);
% close(gcf);



% end
