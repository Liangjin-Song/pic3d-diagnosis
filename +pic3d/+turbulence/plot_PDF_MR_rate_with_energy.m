%% plot the possibility distribution function of reconnection rate
clear;

%% parameters
indir='E:\Turbulence\9.2\data';
outdir='E:\Turbulence\9.2\out\static';
prm=slj.Parameters(indir,outdir);
% time
tt=50:221;
nt = length(tt);

norm = prm.value.vA;

%% the reconnection rate
MRrate = [];
JdErate = [];
JdEdrate = [];
epthetarate = [];
epidrate = [];
ipthetarate = [];
ipidrate = [];


dx=4;
dy=4;

for t = 1:nt
    cd(indir);
    %% X-line position
%     [icol, irow, ~] = slj.Physics.findXline_by_Hessian(B, prm);
    cd('E:\Turbulence\9.2\out\static\data\X-line_index');
    load(['X-line_index_t', num2str(tt(t), '%06.2f')]);
    %% reconnection electric field
    B = prm.read('B', tt(t));
    E = prm.read('E', tt(t));
    V = prm.read('Vi', tt(t));
    vb = V.cross(B);
    Er = E.y + vb.y;
    [Er, ai, aj] = expand_field(Er);
    %% J\cdotＥ
    J = prm.read('J', tt(t));
    JdE = J.dot(E);
    [JdE, ~, ~] = expand_field(JdE);
    %% J\cdot(E+VixB)
    JdEd.x = E.x + vb.x;
    JdEd.y = E.y + vb.y;
    JdEd.z = E.z + vb.z;
    JdEd = slj.Vector(JdEd);
    JdEd = JdEd.dot(J);
    [JdEd, ~, ~] = expand_field(JdEd);
    %% electron p\nabla\cdotV
    P = prm.read('Pe', tt(t));
    V = prm.read('Ve', tt(t));
    p = (P.xx + P.yy + P.zz)/3;
    epdV = V.divergence(prm);
    epdV = p .* epdV.value;
    [epdV, ~, ~] = expand_field(epdV);
    %% electron Pi-D
    ePiD = calc_PiD(P, V, p);
    [ePiD, ~, ~] = expand_field(ePiD);
    %% ion p\nabla\cdotV
    P = prm.read('Pi', tt(t));
    V = prm.read('Vi', tt(t));
    p = (P.xx + P.yy + P.zz)/3;
    ipdV = V.divergence(prm);
    ipdV = p .* ipdV.value;
    [ipdV, ~, ~] = expand_field(ipdV);
    %% ion Pi-D
    iPiD = calc_PiD(P, V, p);
    [iPiD, ~, ~] = expand_field(iPiD);

    %% gather data
    n = length(icol);
    for i = 1:n
        MRrate = [MRrate, mean(Er(irow(i)-dx+ai:irow(i)+dx+ai, icol(i)-dy+aj:icol(i)+dy+aj), 'all')];
        JdErate = [JdErate, mean(JdE(irow(i)-dx+ai:irow(i)+dx+ai, icol(i)-dy+aj:icol(i)+dy+aj), 'all')];
        JdEdrate = [JdEdrate, mean(JdEd(irow(i)-dx+ai:irow(i)+dx+ai, icol(i)-dy+aj:icol(i)+dy+aj), 'all')];
        epthetarate = [epthetarate, mean(epdV(irow(i)-dx+ai:irow(i)+dx+ai, icol(i)-dy+aj:icol(i)+dy+aj), 'all')];
        epidrate = [epidrate, mean(ePiD(irow(i)-dx+ai:irow(i)+dx+ai, icol(i)-dy+aj:icol(i)+dy+aj), 'all')];
        ipthetarate = [ipthetarate, mean(ipdV(irow(i)-dx+ai:irow(i)+dx+ai, icol(i)-dy+aj:icol(i)+dy+aj), 'all')];
        ipidrate = [ipidrate, mean(iPiD(irow(i)-dx+ai:irow(i)+dx+ai, icol(i)-dy+aj:icol(i)+dy+aj), 'all')];
    end
end

%% save data
cd(outdir);
cd(data);
save('MR_energy_rate.mat', 'MRrate', 'JdErate', 'JdEdrate', 'epthetarate', 'epidrate', 'ipthetarate', 'ipidrate');

%% make the pdf
m1 = min(rate);
m2 = max(rate);
nbin = 100;
bin = linspace(m1, m2, nbin);
pdf = zeros(nbin);

n = length(rate);
for i = 1:n
    for j = 1:nbin-1
        if rate(i) >= bin(j) && rate(i) < bin(j+1)
            pdf(j) = pdf(j) + 1;
            break;
        end
    end
end
pdf = pdf / n;

cd(outdir);
%% plot
figure;
plot(bin, pdf, 'k-', 'LineWidth', 2);
xlabel('E_r / v_A B_0');
ylabel('PDF');
set(gca, 'FontSize', 16);

function [efd, ai, aj] = expand_field(fd)
%%
[ii, jj] = size(fd);
ai = ii * 0.5;
aj = jj * 0.5;
ei = ii + ai * 2;
ej = jj + aj * 2;
%%
efd = zeros(ei, ej);
efd(1:ai, 1:aj) = fd(end-ai+1:end, end-aj+1:end);
efd(1:ai, aj+1:aj+jj) = fd(end-ai+1:end, :);
efd(1:ai, aj+jj+1:end) = fd(end-ai+1:end, 1:aj);
efd(ai+1:ai+ii, 1:aj) = fd(:, end-aj+1:end);
efd(ai+ii+1:end, 1:aj) = fd(1:ai, end-aj+1:end);
efd(ai+ii+1:end, aj+1:aj+jj) = fd(1:ai, :);
efd(ai+ii+1:end, aj+jj+1:end) = fd(1:ai, 1:aj);
efd(ai+1:ai+ii, aj+jj+1:end) = fd(:, 1:aj);
end

function pid = calc_PiD(P, V, p)
pdxx=P.xx-p;
pdxy=P.xy;
pdxz=P.xz;
pdyy=P.yy-p;
pdyz=P.yz;
pdzz=P.zz-p;

VV=slj.Scalar(V.x);
g=VV.gradient(prm);
px=g.x.*pdxx+g.y.*pdxy+g.z.*pdxz;
VV=slj.Scalar(V.y);
g=VV.gradient(prm);
py=g.x.*pdxy+g.y.*pdyy+g.z.*pdyz;
VV=slj.Scalar(V.z);
g=VV.gradient(prm);
pz=g.x.*pdxz+g.y.*pdyz+g.z.*pdzz;

pid = px + py + pz;
pid = -pid;
end