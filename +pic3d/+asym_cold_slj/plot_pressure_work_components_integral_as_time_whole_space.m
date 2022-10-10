clear;
%% parameters
indir='E:\Simulation\Cold2_ds1_large\data';
outdir='E:\Simulation\Cold2_ds1_large\out\Energy';
disp(outdir);
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=0:dt:70;
xrange=[0,70];
name='h';

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
elseif name == 'h'
    sfx='ic';
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
rate=zeros(7,nt);


for t=1:nt
    B=prm.read('B',tt(t));
    V=prm.read(['V',name],tt(t));
    P=prm.read(['P',name],tt(t));
    %% (P\cdot\nabla)\cdot V
    gV = slj.Scalar(V.x);
    gV = gV.gradient(prm);
    PVxx = - P.xx .* gV.x;
    PVxz = - P.xz .* gV.z;
    gV = slj.Scalar(V.y);
    gV = gV.gradient(prm);
    PVyx = - P.xy .* gV.x;
    PVyz = - P.yz .* gV.z;
    gV = slj.Scalar(V.z);
    gV = gV.gradient(prm);
    PVzx = - P.xz .* gV.x;
    PVzz = - P.zz .* gV.z;
    PV = PVxx + PVxz + PVyx + PVyz + PVzx + PVzz;


    ddt = dt./prm.value.wci;
    PVxx=sum(PVxx,'all')*ddt;
    PVxz=sum(PVxz,'all')*ddt;
    PVyx=sum(PVyx,'all')*ddt;
    PVyz=sum(PVyz,'all')*ddt;
    PVzx=sum(PVzx,'all')*ddt;
    PVzz=sum(PVzz,'all')*ddt;
    PV  =sum(PV, 'all')*ddt;

    if t == 1
        r1=0;
        r2=0;
        r3=0;
        r4=0;
        r5=0;
        r6=0;
        r7=0;
    else
        r1=rate(1, t-1);
        r2=rate(2, t-1);
        r3=rate(3, t-1);
        r4=rate(4, t-1);
        r5=rate(5, t-1);
        r6=rate(6, t-1);
        r7=rate(7, t-1);
    end

    rate(1,t)=r1 + PVxx;
    rate(2,t)=r2 + PVxz;
    rate(3,t)=r3 + PVyx;
    rate(4,t)=r4 + PVyz;
    rate(5,t)=r5 + PVzx;
    rate(6,t)=r6 + PVzz;
    rate(7,t)=r7 + PV;
end

rate0 = rate;
rate = rate0/norm;


f=figure;
p1 = plot(tt, rate(1,:), '--r', 'LineWidth', 2);
hold on
p2 = plot(tt, rate(2,:), '-r', 'LineWidth', 2);
p3 = plot(tt, rate(3,:), '--g', 'LineWidth', 2);
p4 = plot(tt, rate(4,:), '-g', 'LineWidth', 2);
p5 = plot(tt, rate(5,:), '--b', 'LineWidth', 2);
p6 = plot(tt, rate(6,:), '-b', 'LineWidth', 2);
p7 = plot(tt, rate(7,:), '-k', 'LineWidth', 2);
hold off
xlim(xrange);
xlabel('\Omega_{ci} t');
set(gca,'FontSize',12);
lgd = legend([p1, p2, p3, p4], '\int_0^t -P_{xx}\partial V_x/\partial x dt', '\int_0^t -P_{xz}\partial V_x/\partial z dt',...
    '\int_0^t -P_{xy}\partial V_y/\partial x dt', '\int_0^t -P_{yz} \partial V_y/\partial z dt',...
    'Box', 'off', 'FontSize', 11);
as = axes('position',get(gca,'position'),'visible','off');
legend(as, [p5, p6, p7], '\int_0^t -P_{xz}\partial V_z/\partial x dt', '\int_0^t -P_{zz} \partial V_z/\partial z dt',...
    '\int_0^t -(P\cdot\nabla)\cdot V dt', 'Box', 'off', 'FontSize', 11);
xlabel('\Omega_{ci} t');
set(gca,'FontSize',12);

cd(outdir);
save('pressure_work_components_integral.mat', 'tt', 'rate', 'dt');
print(f,'-dpng','-r300',[sfx,'_pressure_work_components_integral_as_time_dt=',num2str(dt),'_whole_space.png']);
close(f);