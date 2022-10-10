%%
% integral for hall electric field Ez
%%
clear;
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

%% time
tt = 0:60;

%% line
xz=41;
dir=1;
ll = prm.value.lz;

%% lower limit of integral
[~, a] = min(abs(ll + 10));
nt = length(tt);

%% space
deltE = zeros(1, nt);

for t = 1:nt
    %% read data
E=prm.read('E',tt(t));
B=prm.read('B',tt(t));

%% obtain line
le=E.get_line2d(xz,dir,prm,1);
lb=B.get_line2d(xz,dir,prm,1);

%% upper limit of integral
[~, b] = min(abs(lb.lx));

%% integral
deltE(t) = prm.value.qi*sum(le.lz(a:b));
end

norm = 0.5 * prm.value.mi * prm.value.vA * prm.value.vA;
deltE = deltE/norm;

%% figure;
figure;
plot(tt, deltE, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('\DeltaE  [0.5*m_i*V_A^2]');
set(gca,'FontSize', 14);


figure;
plot(tt, sqrt(deltE), '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel('V [V_A]');
set(gca,'FontSize', 14);

cd(outdir);
