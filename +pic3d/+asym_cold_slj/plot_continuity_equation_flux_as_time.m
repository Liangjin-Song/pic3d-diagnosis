%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot the density flux as the function of time
%%
clear;
%{
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\partial_t\region1';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=20:dt:60;
name='h';

% the box and box size
xx = [30,50];
zz = [-2,0];

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
    N = prm.read(['N', name], tt(t));
    V = prm.read(['V', name], tt(t));
    NV = [];
    NV.x = -V.x .* N.value;
    NV.y = -V.y .* N.value;
    NV.z = -V.z .* N.value;
    NV = slj.Vector(NV);
    divNV = NV.divergence(prm);
    [top, bottom, left, right] = slj.Physics.integrate2d_flux(NV, xindex, zindex, prm);
    rate(1,t)=sum(divNV.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
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

legend('-\nabla \cdot (NV)', 'top', 'bottom', 'left', 'right');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('-\int NV \cdot dl');
set(gca,'FontSize',14);

%% save
cd(outdir);
% print('-dpng','-r300',[sfx,'_continuity_equation_as_dt=',num2str(dt),'_flux.png']);
