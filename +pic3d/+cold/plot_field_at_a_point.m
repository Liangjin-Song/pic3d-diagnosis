%% plot the electric field at a point
indir='E:\Simulation\Cold\Data';
outdir='E:\Simulation\Cold\Out\Line';
prm=slj.Parameters(indir,outdir);

%% field information
name = 'E';
norm=prm.value.vA;
tt=0:0.1:40;

%% point position
x = 50;
z = 0;

%% space
[~, nx] = min(abs(prm.value.lx - x));
[~, nz] = min(abs(prm.value.lz - z));
nt = length(tt);
tfd = zeros(1, nt);

%% loop
for t = 1:nt
    fd = prm.read(name, tt(t));
    fd = fd.y;
    tfd(t) = fd(nz, nx);
end

%% figure
figure;
plot(tt, tfd, '-k');
xlabel('\Omega_{ci}t');
ylabel('Ey');
set(gca, 'FontSize', 12);

cd(outdir);