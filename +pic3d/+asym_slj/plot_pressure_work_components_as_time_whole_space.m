clear;
%% parameters
indir='E:\Asym\cold2v2\data';
outdir='E:\Asym\cold2v2\out\Article';
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=20:dt:60;
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
rate=zeros(4,nt);


for t=1:nt
    B=prm.read('B',tt(t));
    V=prm.read(['V',name],tt(t));
    P=prm.read(['P',name],tt(t));
    %% (P\cdot\nabla)\cdot V
    gV = slj.Scalar(V.x);
    gV = gV.gradient(prm);
    PVx = P.xx .* gV.x + P.xy .* gV.y + P.xz .* gV.z;
    gV = slj.Scalar(V.y);
    gV = gV.gradient(prm);
    PVy = P.xy .* gV.x + P.yy .* gV.y + P.yz .* gV.z;
    gV = slj.Scalar(V.z);
    gV = gV.gradient(prm);
    PVz = P.xz .* gV.x + P.yz .* gV.y + P.zz .* gV.z;
    PV = PVx + PVy + PVz;

    rate(1,t)=-sum(PVx,'all');
    rate(2,t)=-sum(PVy,'all');
    rate(3,t)=-sum(PVz,'all');
    rate(4,t)=-sum(PV,'all');
end

f=figure;
plot(tt, rate(1,:), '-r', 'LineWidth', 2);
hold on
plot(tt, rate(2,:), '-g', 'LineWidth', 2);
plot(tt, rate(3,:), '-b', 'LineWidth', 2);
plot(tt, rate(4,:), '-k', 'LineWidth', 2);
hold off
legend('-(P\cdot\nabla)_xV_x', '-(P\cdot\nabla)_yV_y', '-(P\cdot\nabla)_zV_z', '-(P\cdot\nabla)\cdot V', 'Box', 'off');
xlabel('\Omega_{ci} t');
set(gca,'FontSize',14);

cd(outdir);
% print(f,'-dpng','-r300',[sfx,'_pressure_work_components_as_time_dt=',num2str(dt),'_whole_space.png']);