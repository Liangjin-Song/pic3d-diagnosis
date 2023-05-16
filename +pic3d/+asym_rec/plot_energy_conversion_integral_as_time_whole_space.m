clear;
%% parameters
indir='Z:\ion_deceleration\case2';
outdir='C:\Users\Liangjin\Pictures\Asym\case2\out\Test';
prm=slj.Parameters(indir,outdir);

dt=0.5;
tt=0:dt:100;
name='e';
xrange=[0,100];

if name == 'i'
    sfx='i';
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
% norm = 1;
norm=load([indir,'\energy.dat']);
norm=norm(1,5);

%% the loop
nt=length(tt);
rate=zeros(4,nt);


for t=1:nt
    E=prm.read('E',tt(t));
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    %% components
    JEx = q*(N.value.*V.x.*E.x);
    JEy = q*(N.value.*V.y.*E.y);
    JEz = q*(N.value.*V.z.*E.z);
    JE = JEx + JEy + JEz;

    %% the sum
    ddt = dt./prm.value.wci;
    JEx=sum(JEx,'all')*ddt;
    JEy=sum(JEy,'all')*ddt;
    JEz=sum(JEz,'all')*ddt;
    JE=sum(JE,'all')*ddt;

    if t == 1
        r1=0;
        r2=0;
        r3=0;
        r4=0;
        r5=0;
    else
        r1=rate(1, t-1);
        r2=rate(2, t-1);
        r3=rate(3, t-1);
        r4=rate(4, t-1);
    end

    rate(1,t)=r1 + JEx;
    rate(2,t)=r2 + JEy;
    rate(3,t)=r3 + JEz;
    rate(4,t)=r4 + JE;
end

rate0=rate;
rate = rate0/norm;

%% figure
f1=figure;
plot(tt, rate(1, :), '-r', 'LineWidth', 2); hold on
plot(tt, rate(2, :), '-g', 'LineWidth', 2); hold on
plot(tt, rate(3, :), '-b', 'LineWidth', 2);
plot(tt, rate(4, :), '-k', 'LineWidth', 2);
legend('\int_0^t qNVxEx dt', '\int_0^t qNVyEy dt', '\int_0^t qNVzEz dt', '\int_0^t qNV\cdot E dt', 'Location', 'Best','Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel('\Delta E_{ic}');
set(gca,'FontSize',14);

cd(outdir);
save('electric_work_integral.mat', 'tt', 'rate', 'rate0', 'dt','sfx');
print('-dpng','-r300',[sfx,'_energy_conversion_integral_as_time_dt=',num2str(dt),'_whole_space.png']);
close(gcf);