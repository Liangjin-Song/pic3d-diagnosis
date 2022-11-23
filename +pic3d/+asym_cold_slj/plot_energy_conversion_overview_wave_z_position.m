clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=15:dt:45;
name='e';
cmpt = 't';


%% the subrange
xrange = 1201:prm.value.nx;
yrange = 415:521;

nt=length(tt);

extra=[];

normJE=prm.value.nts*prm.value.vA*prm.value.vA;
normE = prm.value.vA;

if name == 'l'
    sfx='ih';
elseif name == 'h'
    sfx='ic';
elseif name == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end

pz = zeros(nt, 1);
nx = prm.value.nx;
tJE = zeros(nt, nx);
tE = zeros(nt, nx);

for t=1:nt
    %% read data
    E=prm.read('E',tt(t));
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    if cmpt == 't'
        JE=E.dot(V);
        tit = ['J',sfx,'\cdot E'];
        stit = ['J',sfx,'_dot_E'];
    elseif cmpt == 'x'
        JE=slj.Scalar(V.x.*E.x);
        tit = ['J',sfx,'xEx'];
        stit=tit;
    elseif cmpt == 'y'
        JE=slj.Scalar(V.y.*E.y);
        tit = ['J',sfx,'yEy'];
        stit=tit;
    elseif cmpt == 'z'
        JE=slj.Scalar(V.z.*E.z);
        tit = ['J',sfx,'zEz'];
        stit=tit;
    else
        error('unknown components!');
    end
    JE=JE*N;
    if name == 'e'
        JE=slj.Scalar(-JE.value);
    end

    %% obtain the range
    rje = abs(JE.value(yrange, xrange));
    %% obtain the maximum value position
    [sje, pos] = sort(rje(:));
    [mz, mx] = ind2sub(size(rje), pos(end-2:end));
    %% the average position
    pz(t) = round(mean(mz(:)) + yrange(1) - 1);
    %% obtain the field
    tE(t, :) = E.x(pz(t), :);
    tJE(t, :) = JE.value(pz(t), :);
end

cd(outdir);
%% plot the field
f1 = figure;
slj.Plot.field2d(tJE/normJE, prm.value.lx, tt, extra);
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
caxis([-1, 1]);
title('J_e\cdot E');
set(gca,'FontSize', 14);
print(f1, '-dpng','-r300','Je_dot_E_x_t.png');

f2 = figure;
slj.Plot.field2d(tE/normE, prm.value.lx, tt, extra);
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
caxis([-1, 1]);
title('Ex');
set(gca,'FontSize', 14);
print(f2, '-dpng','-r300','Je_dot_E_x_t.png');

%% Fourier transform
fJE = fftshift(fft2(tJE));
fE = fftshift(fft2(tE));
dx = 1/40;
k = 2*pi/dx;
k = linspace(-k*0.5, k*0.5, nx);
% pdt = prm.value.fpi/prm.value.wci;
f = 1/dt;
f = linspace(-f*0.5, f*0.5, nt);
[X, Y] = meshgrid(k, f);

%% JE
f3 = figure;
p = pcolor(X, Y, abs(fJE));
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('k [2\pi/di]');
ylabel('\omega [\omega_{ci}]');
set(gca,'FontSize',14);

%% E
f4 = figure;
p = pcolor(X, Y, abs(fE));
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('k [2\pi/di]');
ylabel('\omega [\omega_{ci}]');
set(gca,'FontSize',14);