%
%% figure 3, dispersion relationship
clear;
% directory
indir='E:\Asym\cold2_ds1\wave';
wavedir='E:\Asym\cold2_ds1\out\Wave';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper6';
prm=slj.Parameters(indir,outdir);

% load the position index of the separatrix in z direction
cd(wavedir);
load('z_position_along_separatrix.mat');
pz = pz - 400;
pt = 20:0.1:40;

% time intervals
dt = 0.05;
tt=20:dt:40;

% physics quantity
name = 'E';

% normalize
norm = prm.value.vA;
% norm = 1;

%% the variable
nt = length(tt);
nx = prm.value.nx;
tE.x = zeros(nt, nx);
tE.y = zeros(nt, nx);
tE.z = zeros(nt, nx);

%% loop
cd(indir);
for t = 1:nt
%% read data
E=prm.read(name, tt(t), 'yrange', prm.value.nx, 200, 1);
%% obtain the profile position
[~, it] = min(abs(pt - tt(t)));

%% obtain the field
tE.x(t, :) = E.x(pz(it), :);
tE.y(t, :) = E.y(pz(it), :);
tE.z(t, :) = E.z(pz(it), :);
end
%}
cd(outdir);
%% backup
E = tE;

fd=E.x/norm;
lx=prm.value.lx;
%% select the range
x1 = 33;
x2 = 42;
t1 = 20;
t2 = 40;
[~, x1] = min(abs(prm.value.lx - x1));
[~, x2] = min(abs(prm.value.lx - x2));
[~, t1] = min(abs(tt - t1));
[~, t2] = min(abs(tt - t2));
fd = fd(t1:t2, x1:x2);
lx = lx(x1:x2);
lt = tt(t1:t2);

%% plot the figure
f = figure('Position',[500,100,1200,500]);
h = slj.Plot.subplot(1,2,[0.025,0.1],[0.2,0.05],[0.1,0.05]);
fontsize=16;

axes(h(1));
slj.Plot.field2d_suitable(fd, lx, lt, []);
xlabel('X [c/\omega_{pi}]');
ylabel('\Omega_{ci}t');
% caxis([-1, 1]);
set(gca,'FontSize', 14);
caxis([-1.5,1.5]);
colormap(h(1), 'parula');

%% the fourier transform
% the sampling frequency
fx = prm.value.di;
ft = 1/dt;
% the fourier transform
[sas, hsas, ~] = slj.Physics.fft2d(fx, ft, fd);
% plot the figure
% f2 = figure;
% slj.Plot.field2d_suitable(sas.ft, sas.lk, sas.lw, []);
% xlabel('k_x [d_{i0}^{-1}]');
% ylabel('\omega [\omega_{ci0}]');

axes(h(2))
slj.Plot.field2d_suitable(hsas.ft, hsas.lk, hsas.lw, []);
xlabel('k_x [d_{i}^{-1}]');
ylabel('\omega [\omega_{ci}]');
xlim([0, 5]);
caxis([0, 0.02]);
colormap(h(2), slj.Plot.mycolormap(1));

hold on
v = 2.5;
k = -5:5;
w = v .* k;
hold on
p1 = plot(k, w, '--k', 'LineWidth', 2);
legend(p1, '\omega = c_{ia}''k',...
     'Position',[0.79041666764766 0.495142858126334 0.100833331594865 0.0739999980330469]);
set(gca, 'FontSize', fontsize);

%%
annotation(f,'textbox',...
    [0.0400000000000001 0.877000001609326 0.0470833321784934 0.0739999983906746],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.514166666666667 0.873000001609326 0.0479166654869915 0.0739999983906746],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

%%
cd(outdir);
print('-dpng', '-r300', 'figure3.png');