clear;
%% parameters
indir='E:\Simulation\Cold2_ds1_large\data';
outdir='E:\Simulation\Cold2_ds1_large\out\Energy';
disp(outdir);
prm=slj.Parameters(indir,outdir);

dt=0.1;
tt=0:dt:70;
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
rate=zeros(5,nt);


for t=1:nt
    B=prm.read('B',tt(t));
    V=prm.read(['V',name],tt(t));
    P=prm.read(['P',name],tt(t));
    %% (P\cdot\nabla)\cdot V
    PV = pressure_work(P, V, prm);
    %% (P'\cdot\nabla)\cdot V
    p = (P.xx + P.yy + P.zz)/3;
    P1.xx = P.xx - p;
    P1.xy = P.xy;
    P1.xz = P.xz;
    P1.yy = P.yy - p;
    P1.yz = P.yz;
    P1.zz = P.zz - p;
    P1V = pressure_work(P1, V, prm);
    %% p \nabla \cdot V
    pV = V.divergence(prm);
    pV = p .* pV.value;
    %% parallel and perpendicular pressure
    pp = P.fac_tensor(B, prm);
    perp = (pp.xx + pp.yy)/2;
    para = pp.zz;
    %% magnetic unit vector
    bt = sqrt(B.x.^2 + B.y.^2 + B.z.^2);
    b.x = B.x./bt;
    b.y = B.y./bt;
    b.z = B.z./bt;
    %% (P'diag \cdot \nabla) \cdot V
    pp1 = para - p;
    pp2 = perp - p;
    diag.xx = pp1 .* b.x .* b.x + pp2 .* (1 - b.x .* b.x);
    diag.xy = pp1 .* b.x .* b.y - pp2 .* b.x .* b.y;
    diag.xz = pp1 .* b.x .* b.z - pp2 .* b.x .* b.z;
    diag.yy = pp1 .* b.y .* b.y + pp2 .* (1 - b.y .* b.y);
    diag.yz = pp1 .* b.y .* b.z - pp2 .* b.y .* b.z;
    diag.zz = pp1 .* b.z .* b.z + pp2 .* (1 - b.z .* b.z);
    P1diagV = pressure_work(diag, V, prm);
    %% (P'off-diag \cdot \nabla) \cdot V
    odiag.xx = P1.xx - diag.xx;
    odiag.xy = P1.xy - diag.xy;
    odiag.xz = P1.xz - diag.xz;
    odiag.yy = P1.yy - diag.yy;
    odiag.yz = P1.yz - diag.yz;
    odiag.zz = P1.zz - diag.zz;
    P1odiagV = pressure_work(odiag, V, prm);

    %% the sum
    rate(1,t)=sum(PV,'all');
    rate(2,t)=sum(P1V,'all');
    rate(3,t)=sum(pV,'all');
    rate(4,t)=sum(P1diagV,'all');
    rate(5,t)=sum(P1odiagV,'all');
end
rate0=rate;
rate = rate0/norm;
%% figure
f1=figure;
plot(tt, rate(1, :), '-k', 'LineWidth', 2); hold on
plot(tt, rate(2, :), '-b', 'LineWidth', 2);
plot(tt, rate(3, :), '-r', 'LineWidth', 2);
% plot(tt, rate(2, :) + rate(3,:), '--g', 'LineWidth', 2);
legend('(P\cdot\nabla)\cdot V', '(P''\cdot\nabla)\cdot V', 'p\nabla\cdot V', 'Location', 'Best','Box','off');
% xlim(xrange);
xlabel('\Omega_{ci} t');
set(gca,'FontSize',14);

f2=figure;
plot(tt, rate(2, :), '-k', 'LineWidth', 2); hold on
plot(tt, rate(4, :), '-b', 'LineWidth', 2);
plot(tt, rate(5, :), '-r', 'LineWidth', 2);
% plot(tt, rate(4, :) + rate(5,:), '--g', 'LineWidth', 2);
legend('(P''\cdot\nabla)\cdot V', '(P''_{diag}\cdot\nabla)\cdot V', '(P''_{offdiag}\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
% xlim(xrange);
xlabel('\Omega_{ci} t');
set(gca,'FontSize',14);

f3=figure;
plot(tt, -rate(1, :), '-k', 'LineWidth', 2); hold on
plot(tt, -rate(3, :), '-b', 'LineWidth', 2);
plot(tt, -rate(4, :), '-m', 'LineWidth', 2);
plot(tt, -rate(5, :), '-r', 'LineWidth', 2);
% plot(tt, rate(3, :) + rate(4,:) + rate(5,:), '--g', 'LineWidth', 2);
legend('-(P\cdot\nabla)\cdot V', '-p\nabla\cdot V', '-(P''_{diag}\cdot\nabla)\cdot V', '-(P''_{offdiag}\cdot\nabla)\cdot V', 'Location', 'Best','Box','off');
% xlim(xrange);
xlabel('\Omega_{ci} t');
set(gca,'FontSize',14);

cd(outdir);
save('pressure_work.mat', 'tt', 'rate', 'dt');
print(f1,'-dpng','-r300',[sfx,'_pressure_work1_as_time_dt=',num2str(dt),'_whole_space.png']);
print(f2,'-dpng','-r300',[sfx,'_pressure_work2_as_time_dt=',num2str(dt),'_whole_space.png']);
print(f3,'-dpng','-r300',[sfx,'_pressure_work3_as_time_dt=',num2str(dt),'_whole_space.png']);
close(f1);
close(f2);
close(f3);



function w = pressure_work(P, V, prm)
gV = slj.Scalar(V.x);
gV = gV.gradient(prm);
PV1 = P.xx .* gV.x + P.xy .* gV.y + P.xz .* gV.z;
gV = slj.Scalar(V.y);
gV = gV.gradient(prm);
PV2 = P.xy .* gV.x + P.yy .* gV.y + P.yz .* gV.z;
gV = slj.Scalar(V.z);
gV = gV.gradient(prm);
PV3 = P.xz .* gV.x + P.yz .* gV.y + P.zz .* gV.z;
w = PV1 + PV2 + PV3;
end