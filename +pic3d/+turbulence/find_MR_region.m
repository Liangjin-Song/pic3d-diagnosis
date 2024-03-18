%
%% find the magnetic reconnection region
clear;
%% parameters
indir='Y:\goon\turbulence9.0';
outdir='C:\Users\Liangjin\Pictures\Turbulence';
prm=slj.Parameters(indir,outdir);

tt = 157;

%% read data
B = prm.read('B', tt);

[icol, irow, ss] = slj.Physics.findXline_by_Hessian(B, prm);
 %{
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
% irow = [irow; 673];
% icol = [icol; 1059];
%}
spx = prm.value.lx(icol);
spz = prm.value.lz(irow);
%% obtain data
J = prm.read('J', tt);

fd = J.y;
norm = prm.value.qi*prm.value.n0*prm.value.vA;
%% plot figure
f1 = figure;
slj.Plot.overview(fd, ss, prm.value.lx, prm.value.lz, norm, []);
hold on
plot(spx, spz, 'rx');
xlabel('X [c/\omega_{pe}]');
ylabel('Z [c/\omega_{pe}]');

%% obtain the region
nrg = length(icol);
dlt = 10 * prm.value.de;
BW = zeros(prm.value.nz, prm.value.nx);
for i = 1:nrg
    idx = field_range(irow(i), icol(i), dlt, prm);
    [bnd, bw] = obtain_boundary(fd, idx, fd(irow(i), icol(i)), [i, irow(i), icol(i)]);
    bnd(:, 1) = bnd(:, 1) + idx.row(1) - 1;
    bnd(:, 2) = bnd(:, 2) + idx.col(1) - 1;
    % the union
    BW(idx.row, idx.col) = BW(idx.row, idx.col) | bw;
end

%% plot figure
[B, ~] = bwboundaries(BW,'noholes');
nb = length(B);
for i = 1:nb
    plot(prm.value.lx(B{i}(:, 2)),...
        prm.value.lz(B{i}(:, 1)), '-w', 'LineWidth', 1);
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
function [boundary, BW] = obtain_boundary(fd, range, val, ip)
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
    boundary = [];
    if inpolygon(ir, ic, B{i}(:,1), B{i}(:, 2))
        boundary = B{i};
        break;
    end
end
if isempty(boundary) == 1
    error(['error: ', num2str(ip(1))]);
end

[nr, nc] = size(BW);
BW = zeros(nr, nc);
for i = 1:nr
    for j = 1:nc
        if inpolygon(i, j, boundary(:, 1), boundary(:, 2))
            BW(i, j) = 1;
        end
    end
end
end