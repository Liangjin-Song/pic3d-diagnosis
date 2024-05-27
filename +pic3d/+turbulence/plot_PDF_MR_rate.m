%% plot the possibility distribution function of reconnection rate
clear;

%% parameters
indir='E:\Turbulence\9.2\data';
outdir='E:\Turbulence\9.2\out\static';
prm=slj.Parameters(indir,outdir);
% time
tt=0:221;
nt = length(tt);

norm = prm.value.vA;

%% the reconnection rate
rate = [];
dx=0;
dy=0;

for t = 1:nt
    cd(indir);
    %% X-line position
    B = prm.read('B', tt(t));
    [icol, irow, ~] = slj.Physics.findXline_by_Hessian(B, prm);
    
    %% reconnection electric field
    E = prm.read('E', tt(t));
    V = prm.read('Ve', tt(t));
    vb = V.cross(B);
    Er = E.y + vb.y;

    %% reconnection rate
    n = length(icol);
    for i = 1:n
        rate = [rate, mean(Er(irow(i)-dx:irow(i)+dx, icol(i)-dy:icol(i)+dy), 'all')];
    end
end

rate0 = rate;
rate = rate0 / norm;

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