% colormap(slj.Plot.mycolormap(0))
% caxis([-3,3])
xx = [30,50];

zz = [-2.14,0.51];
hold on
cr = '-r';
plot([xx(1),xx(2)],[zz(1), zz(1)], cr, 'LineWidth', 2);
plot([xx(1),xx(2)],[zz(2), zz(2)], cr, 'LineWidth', 2);
plot([xx(1),xx(1)],[zz(1), zz(2)], cr, 'LineWidth', 2);
plot([xx(2),xx(2)],[zz(1), zz(2)], cr, 'LineWidth', 2);