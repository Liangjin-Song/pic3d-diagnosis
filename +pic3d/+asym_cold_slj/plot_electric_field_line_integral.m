%% the integral of electric field
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Kinetic\Trajectory\X-line';
prm=slj.Parameters(indir,outdir);

%% time and position
tt=0:60;
xz=42;
dir=1;
ll = prm.value.lz;

%% normalization
norm = 0.5 * prm.value.mi * prm.value.vA*prm.value.vA;

%% upper and lower limitation of the integral
lo = -0.3;
up = 2.5;

nt = length(tt);
rate = zeros(nt, 1);
for t = 1:nt
%% read data
E=prm.read('E',tt(t));
le=E.get_line2d(xz,dir,prm,1);

le = le.lz;

%% find the index of the limitation
[~, ilo] = min(abs(ll - lo));
[~, iup] = min(abs(ll - up));

%% integration
rate(t) = sum(le(ilo:iup));
end

%% 
rate = rate * prm.value.qi / norm;

%% figure
figure;
plot(tt, rate, '-k', 'LineWidth', 2);
xlabel('\Omega_{ci}t');
ylabel(['q\int_{',num2str(lo),'}^{',num2str(up),'} Ez dz'])
set(gca, 'FontSize', 14);
cd(outdir);