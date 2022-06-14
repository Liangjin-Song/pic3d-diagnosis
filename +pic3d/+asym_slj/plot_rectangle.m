xx = [20,30];
zz = [-1,2];
hold on
plot([xx(1),xx(2)],[zz(1), zz(1)], '-r', 'LineWidth', 2);
plot([xx(1),xx(2)],[zz(2), zz(2)], '-r', 'LineWidth', 2);
plot([xx(1),xx(1)],[zz(1), zz(2)], '-r', 'LineWidth', 2);
plot([xx(2),xx(2)],[zz(1), zz(2)], '-r', 'LineWidth', 2);