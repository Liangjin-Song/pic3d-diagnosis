%
%% find the magnetic reconnection region
clear;
%% parameters
indir='D:\Downloads\simulation\t2d\data';
outdir='D:\Downloads\simulation\t2d\out';
prm=slj.Parameters(indir,outdir);

tt = 157;

%% read data
B = prm.read('B', tt);


%% vector potential
ss = slj.Scalar(slj.Physics.stream2d(B.x, B.z));

%% in-plane magnetic field
Bip = sqrt(B.x.^2 + B.z.^2);

%% 1st and 2nd derivatives of ss
D1s = ss.gradient(prm);
D1sq = sqrt(D1s.x.^2 + D1s.z.^2);

D2sx = slj.Scalar(D1s.x);
D2sx = D2sx.gradient(prm);

D2sz = slj.Scalar(D1s.z);
D2sz = D2sz.gradient(prm);

%% find the neutral line
val = D1sq;
threshold = std(val(:)) * 0.01; % 0.0043;
[irow, icol] = find(val < threshold);

%% find the saddle points
np = length(irow);
imr = [];
for i = 1:np
    hessian = [D2sx.x(irow(i), icol(i)), D2sx.z(irow(i), icol(i)); ...
        D2sz.x(irow(i), icol(i)), D2sz.z(irow(i), icol(i))];
    if det(hessian) < 0
        imr = [imr, i];
    end
end
irow = irow(imr);
icol = icol(imr);
spx = prm.value.lx(icol);
spz = prm.value.lz(irow);
%}
%% obtain data
J = prm.read('J', tt);

fd = J.y;
norm = 1;
%% plot figure
f1 = figure;
slj.Plot.overview(fd, ss, prm.value.lx, prm.value.lz, norm, []);
hold on
plot(spx, spz, 'wx');
xlabel('X [c/\omega_{pe}]');
ylabel('Z [c/\omega_{pe}]');

%% obtain the region
nrg = length(icol);
dlt = 10 * prm.value.de;
for i = 1:nrg
    idx = field_range(irow(i), icol(i), dlt, prm);
    bnd = obtain_boundary(fd, idx, fd(irow(i), icol(i)), [i, irow(i), icol(i)]);
    bnd(:, 1) = bnd(:, 1) + idx.row(1) - 1;
    bnd(:, 2) = bnd(:, 2) + idx.col(1) - 1;
    %
    plot(prm.value.lx(bnd(:, 2)),...
        prm.value.lz(bnd(:, 1)), '-r', 'LineWidth', 1.5);
end

%% save figure
cd(outdir);
print('-dpng', '-r300', 'Jy.png');

%% obtain the field range
function val = field_range(row, col, delt, prm)
if row - delt < 1
    irw = 1:(row + delt);
    brw = 1;
elseif row + delt > prm.value.nz
    irw = (row - delt):prm.value.nz;
    brw = 2;
else
    irw = (row - delt):(row + delt);
    brw = 0;
end
if col - delt < 1
    icl = 1:(col + delt);
    bcl = 1;
elseif col + delt > prm.value.nx
    icl = (col - delt):prm.value.nx;
    bcl = 2;
else
    icl = (col - delt):(col + delt);
    bcl = 0;
end
val.row = irw;
val.brw = brw;
val.col = icl;
val.bcl = bcl;
end

%% obtain the boundary
function boundary = obtain_boundary(fd, range, val, ip)
v = fd(range.row, range.col);
if val < 0
v = -v;
val = -val;
end

BW = v > val/exp(1) & v < 2*val;
[B, ~] = bwboundaries(BW,'noholes');

% if ip == 1
%     boundary = B{2};
% elseif ip == 3
%     boundary = B{3};
% elseif ip == 5
%     boundary = B{4};
% else
%     boundary = B{1};
% end
nb = length(B);
ir = ip(2) - range.row(1) + 1;
ic = ip(3) - range.col(1) + 1;

for i = 1:nb
    if inpolygon(ir, ic, B{i}(:,1), B{i}(:, 2))
        boundary = B{i};
        return;
    end
end
disp(['error: ', num2str(ip(1))]);
end