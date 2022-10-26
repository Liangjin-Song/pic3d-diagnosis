%% plot particle position in distribution function
% particle's ID
id = uint64(1023750328);
norm = prm.value.vA;

%% find the particle in the distribution function
in = find(spc.value.id == id);
if isempty(in)
    error('could not find the particle!');
end

%% plot the figure
f1=figure(1);
hold on
plot(spc.value.vy(in)/norm, spc.value.vz(in)/norm,'*b', 'LineWidth', 5);

f2=figure(2);
hold on
plot(spc.value.vx(in)/norm, spc.value.vz(in)/norm,'*b', 'LineWidth', 5);


f3=figure(3);
hold on
plot(spc.value.vx(in)/norm, spc.value.vy(in)/norm,'*b', 'LineWidth', 5);


%% save figure
print(f1, '-dpng', '-r300', 'tmp1.png');
print(f2, '-dpng', '-r300', 'tmp2.png');
print(f3, '-dpng', '-r300', 'tmp3.png');