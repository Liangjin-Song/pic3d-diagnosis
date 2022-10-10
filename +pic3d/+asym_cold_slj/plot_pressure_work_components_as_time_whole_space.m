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
norm = 1;

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
    PVxx = P.xx .* gV.x;
    PVxz = P.xz .* gV.z;
    gV = slj.Scalar(V.y);
    gV = gV.gradient(prm);
    PVyx = P.xy .* gV.x;
    PVyz = P.yz .* gV.z;
    gV = slj.Scalar(V.z);
    gV = gV.gradient(prm);
    PVzx = P.xz .* gV.x;
    PVzz = P.zz .* gV.z;
    PV = PVxx + PVxz + PVyx + PVyz + PVzx + PVzz;

    rate(1,t)=-sum(PVxx,'all');
    rate(2,t)=-sum(PVxz,'all');
    rate(3,t)=-sum(PVyx,'all');
    rate(4,t)=-sum(PVyz,'all');
    rate(5,t)=-sum(PVzx,'all');
    rate(6,t)=-sum(PVzz,'all');
    rate(7,t)=-sum(PV,'all');
end

f=figure;
p1 = plot(tt, rate(1,:), '--r', 'LineWidth', 2);
hold on
p2 = plot(tt, rate(2,:), '-r', 'LineWidth', 2);
p3 = plot(tt, rate(3,:), '--g', 'LineWidth', 2);
p4 = plot(tt, rate(4,:), '-g', 'LineWidth', 2);
p5 = plot(tt, rate(5,:), '--b', 'LineWidth', 2);
p6 = plot(tt, rate(6,:), '-b', 'LineWidth', 2);
p7 = plot(tt, rate(7,:), '-k', 'LineWidth', 2);
xlim(xrange);
hold off
xlabel('\Omega_{ci} t');
set(gca,'FontSize',14);
% ylim([-0.4,0.1]);
lgd = legend([p1, p2, p3, p4], '-P_{xx}\partial V_x/\partial x', '-P_{xz}\partial V_x/\partial z',...
    '-P_{xy}\partial V_y/\partial x', '-P_{yz} \partial V_y/\partial z','Box', 'off', 'FontSize', 14);
as = axes('position',get(gca,'position'),'visible','off');
legend(as, [p5, p6, p7],'-P_{xz}\partial V_z/\partial x', '-P_{zz} \partial V_z/\partial z',...
    '-(P\cdot\nabla)\cdot V', 'Box', 'off','FontSize', 14);


cd(outdir);
save('pressure_work_components.mat', 'tt', 'rate', 'dt');
print(f,'-dpng','-r300',[sfx,'_pressure_work_components_as_time_dt=',num2str(dt),'_whole_space.png']);
close(f);