%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot the density flux as the function of time
%%
clear;
%{
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\partial_t\region5';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=20:dt:60;
name='h';

% the box and box size
xx = [38,48];
zz = [-3,1];
% xindex = [1201, prm.value.nx];
% zindex = [441, 501];
% xindex = [881, 1120];
% zindex = [441, 621];
% xindex = [1, 321];
% zindex = [441, 621];

xrange=[tt(1),tt(end)];
[~, a] = min(abs(prm.value.lx - xx(1)));
[~, b] = min(abs(prm.value.lx - xx(2)));
xindex = [a, b];
[~, a] = min(abs(prm.value.lz - zz(1)));
[~, b] = min(abs(prm.value.lz - zz(2)));
zindex = [a, b];


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
%}
pic3d.asym_slj.energy_equation_parameters;
% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
% norm=2*dt*prm.value.wci*prm.value.n0;
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(5,nt);


for t=1:nt
    %% calculation
    V = prm.read(['V', name], tt(t));
    P = prm.read(['P', name], tt(t));
    enp = [];
    %% -\nabla\cdot(U\vec{v} + \vec{\vec{P}}\cdot\vec{v})
    U = slj.Physics.thermal_energy(P);
    enp11=U.value.*V.x;
    enp12=U.value.*V.y;
    enp13=U.value.*V.z;
    % P dot V
    enp21=P.xx.*V.x+P.xy.*V.y+P.xz.*V.z;
    enp22=P.xy.*V.x+P.yy.*V.y+P.yz.*V.z;
    enp23=P.xz.*V.x+P.yz.*V.y+P.zz.*V.z;
    % enthalpy
    enp.x=-enp11-enp21;
    enp.y=-enp12-enp22;
    enp.z=-enp13-enp23;
    enp = slj.Vector(enp);
    divH = enp.divergence(prm);
    [top, bottom, left, right] = slj.Physics.integrate2d_flux(enp, xindex, zindex, prm);
    rate(1,t)=sum(divH.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=top;
    rate(3,t)=bottom;
    rate(4,t)=left;
    rate(5,t)=right;
end

%% figure
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2);
hold on
plot(tt, rate(2,:), '-r', 'LineWidth', 2);
plot(tt, rate(3,:), '-g', 'LineWidth', 2);
plot(tt, rate(4,:), '-b', 'LineWidth', 2);
plot(tt, rate(5,:), '-m', 'LineWidth', 2);
hold off

legend('-\nabla \cdot (UV + P\cdot V)', 'top', 'bottom', 'left', 'right','Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('-\int (UV + P\cdot V) \cdot dl');
set(gca,'FontSize',14);

%% save
cd(outdir);
print('-dpng','-r300',[sfx,'_thermal_energy_conversion_as_time_dt=',num2str(dt),'_flux.png']);

