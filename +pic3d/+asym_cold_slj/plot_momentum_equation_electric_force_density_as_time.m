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
rate=zeros(6,nt);


for t=1:nt
    %% calculation
    [qNE, divP, pVt, NVV, qVB] = slj.Physics.momentum_equation_electric_force_density(prm, name, tt(t), dt, q, m);

    %% sum
    rate(1,t)=sum(qNE.z(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=sum(divP.z(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(3,t)=sum(pVt.z(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(4,t)=sum(NVV.z(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(5,t)=sum(qVB.z(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end
rate(6,:) = rate(2,:)+rate(3,:)+rate(4,:)+rate(5,:);
rate0=rate;
rate = rate/norm;

%% figure
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2);
hold on
plot(tt, rate(2,:), '-r', 'LineWidth', 2);
plot(tt, rate(3,:), '-g', 'LineWidth', 2);
plot(tt, rate(4,:), '-b', 'LineWidth', 2);
plot(tt, rate(5,:), '-m', 'LineWidth', 2);
plot(tt, rate(6,:), '--k', 'LineWidth', 2);
legend('qNE', '\nabla\cdot P', '\partial(mNV)/\partial t', '\nabla\cdot(mNVV)','-qNV\times B','Sum', 'Location', 'Best', 'Box', 'off');
xlim(xrange);
xlabel('\Omega_{ci}t');
ylabel(['qN_{',sfx,'}E']);
set(gca,'FontSize',14);

cd(outdir);
print('-dpng','-r300',[sfx,'_momentum_equation_electric_force_density_as_time_dt=',num2str(dt),'.png']);
