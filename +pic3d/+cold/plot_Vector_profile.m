% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\Simulation\Cold\Data';
outdir='E:\Simulation\Cold\Out\Line';
prm=slj.Parameters(indir,outdir);
name='E';
norm=prm.value.vA;
tt=16;
xz=50;
% dn=3;
dir=1;
xrange=[-10,10];

%% read data
V=prm.read(name,tt);


%% get the line
lf=V.get_line2d(xz, dir, prm, norm);

if dir==1
    ll=prm.value.lz;
    extra.xlabel='Z [c/\omega_{pi}]';
    pstr = 'x';
%     [~, nxz] = min(abs(prm.value.lx - xz));
%     lf.lx = mean(V.x(:, nxz-dn:nxz+dn), 2)/norm;
%     lf.ly = mean(V.y(:, nxz-dn:nxz+dn), 2)/norm;
%     lf.lz = mean(V.z(:, nxz-dn:nxz+dn), 2)/norm;
else
    ll=prm.value.lx;
    extra.xlabel='X [c/\omega_{pi}]';
    pstr = 'z';
%     [~, nxz] = min(abs(prm.value.lz - xz));
%     lf.lx = mean(V.x(nxz-dn:nxz+dn, :), 2)/norm;
%     lf.ly = mean(V.y(nxz-dn:nxz+dn, :), 2)/norm;
%     lf.lz = mean(V.z(nxz-dn:nxz+dn, :), 2)/norm;
end

nn = 10;
lf.lx=smoothdata(lf.lx,'gaussian',nn);
lf.ly=smoothdata(lf.ly,'gaussian',nn);
lf.lz=smoothdata(lf.lz,'gaussian',nn);
% lf.lx=smoothdata(lf.lx);
% lf.ly=smoothdata(lf.ly);
% lf.lz=smoothdata(lf.lz);

figure;
plot(ll, lf.lx, 'r', 'LineWidth', 1.1); hold on
plot(ll, lf.ly, 'b', 'LineWidth', 1.1);
plot(ll, lf.lz, 'k', 'LineWidth', 1.1);
xlabel(extra.xlabel);
ylabel(name);
legend([name,'x'], [name,'y'],[name,'z'],'Location','best');
set(gca,'FontSize', 14);
xlim(xrange);

cd(outdir);
% print('-dpng', '-r300', [name, '_t', num2str(tt,'%06.2f'), '_', pstr, num2str(xz), '.png']);