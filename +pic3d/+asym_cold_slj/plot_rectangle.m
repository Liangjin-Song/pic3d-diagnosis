% colormap(slj.Plot.mycolormap(0))
% caxis([-3,3])
xx = [41,42];

zz = [-0.36,0.28];
hold on
plot([xx(1),xx(2)],[zz(1), zz(1)], '-r', 'LineWidth', 2);
plot([xx(1),xx(2)],[zz(2), zz(2)], '-r', 'LineWidth', 2);
plot([xx(1),xx(1)],[zz(1), zz(2)], '-r', 'LineWidth', 2);
plot([xx(2),xx(2)],[zz(1), zz(2)], '-r', 'LineWidth', 2);