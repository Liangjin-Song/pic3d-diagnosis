% function plot_Vector_profiles
%% plot the cold ions density profiles
clear;
%% parameters 
indir='E:\Simulation\Rec\Data';
outdir='E:\Simulation\Rec\Out\Line';
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

% fac
B=prm.read('B', tt);
[Vpara, Vperp]=V.fac_vector(B);
lpara = slj.Scalar(sqrt(Vpara.x.^2 + Vpara.y.^2 + Vpara.z.^2));
lperp = slj.Scalar(sqrt(Vperp.x.^2 + Vperp.y.^2 + Vperp.z.^2));

%% get the line
lpara=lpara.get_line2d(xz, dir, prm, norm);
lperp=lperp.get_line2d(xz, dir, prm, norm);

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
lpara=smoothdata(lpara,'gaussian',nn);
lperp=smoothdata(lperp,'gaussian',nn);

figure;
plot(ll, lpara, 'r', 'LineWidth', 2); hold on
plot(ll, lperp, 'g', 'LineWidth', 2);
xlabel(extra.xlabel);
ylabel(name);
legend([name,'_{para}'], [name,'_{perp}'],'Location','best');
set(gca,'FontSize', 14);
xlim(xrange);

cd(outdir);
print('-dpng', '-r300', [name, '_t', num2str(tt,'%06.2f'), '_', pstr, num2str(xz), '_fac.png']);