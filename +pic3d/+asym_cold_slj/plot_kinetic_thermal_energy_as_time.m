%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot the kinetic energy and thermal energy as the function of time
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Energy';
prm=slj.Parameters(indir,outdir);

dt = 1;
tt=0:dt:60;
name='h';

norm=load([indir,'\energy.dat']);
norm=norm(1,5);

xrange = [tt(1), tt(end)];

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

%% the loop
nt=length(tt);
rate=zeros(3,nt);


for t=1:nt
    %% calculation
    K = slj.Physics.kinetic_energy(m, prm.read(['N',name],tt(t)), prm.read(['V',name],tt(t)));
    U = slj.Physics.thermal_energy(prm.read(['P',name],tt(t)));

    %% sum
    rate(1,t)=sum(K.value,'all');
    rate(2,t)=sum(U.value,'all');
    rate(3,t)=sum(K.value + U.value, 'all');
end
rate0=rate;
rate = rate0/norm;

%% figure
figure;
plot(tt, rate(1,:), '-b', 'LineWidth', 2);
hold on
plot(tt, rate(2,:), '-r', 'LineWidth', 2);
plot(tt, rate(3,:), '-k', 'LineWidth', 2);
legend('K', 'U', 'Sum', 'Location', 'Best','Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel(['E_{',sfx,'}']);
set(gca,'FontSize',14);

cd(outdir);
% print('-dpng','-r300',[sfx,'_kinetic_thermal_energy_as_time_dt=',num2str(dt),'.png']);
