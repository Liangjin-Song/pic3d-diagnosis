%% plot the thermal velocity of all ions (including cold ions and hot ions) in a range
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

%% time 
tt = 0:0.5:60;

%% the subrange
xrange = 1201:prm.value.nx;
yrange = 415:521;

%%
nt = length(tt);
vith = zeros(1, nt);

%%
for t = 1:nt
    %% read data
    Pih = prm.read('Pl', tt(t));
    Pic = prm.read('Ph', tt(t));
    Nih = prm.read('Nl', tt(t));
    Nic = prm.read('Nh', tt(t));
    %% calculate
    Pih = Pih.scalar();
    Pic = Pic.scalar();
    Pi = Pic.value + Pih.value;
    Ni = Nih.value + Nic.value;
    %% integral
    Pi = sum(Pi(yrange, xrange), 'all');
    Ni = sum(Ni(yrange, xrange), 'all');
    Ti = Pi./Ni;
    vith(t) = sqrt(Ti./prm.value.mi);
end

%% normalization
vith0 = vith;
norm = prm.value.vhth;
vith = vith0 / norm;

%% plot figure
figure;
plot(tt, vith, '-k', 'LineWidth', 1.5);
xlabel('\Omega_{ci}t');
ylabel('Vi_{th}');
set(gca,'FontSize', 16);

%% save
cd(outdir);