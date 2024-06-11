clear;
indir='Z:\Simulation\Zhong\moon\run4';
outdir='Z:\Simulation\Zhong\moon\run4\out\global';
%% plot energy
h1=figure;
en=load([indir,'\energy.dat']);
tt=0.1*(0:size(en,1)-1);
plot(tt,en(:,1),'y','LineWidth',2); hold on
plot(tt,en(:,2),'g','LineWidth',2);
plot(tt,en(:,3),'b','LineWidth',2);
plot(tt,en(:,4),'r','LineWidth',2);
plot(tt,en(:,5),'m','LineWidth',2);
hold off
% plot([9333,9333],[0,5e4],'--r','LineWidth',1); hold off
xlim([0,tt(end)]);
% legend('Electric Field Energy','Magnetic Field Energy','Electron Energy','Ions Energy','Electrons Energy(c)','Cold Ions Energy','Total Energy');
legend('Electric Field Energy','Magnetic Field Energy','Electron Energy','Ion Energy','Total Energy');
xlabel('\Omega_{cl}t');
ylabel('Energy');
set(gca,'FontSize',14);
cd(outdir);
print(h1,'-dpng','-r300','energy.png');

%% plot energy rate
h2=figure;
tot=en(:,5);
nt=length(tot);
rate=zeros(nt,5);

for t=1:nt
    rate(t, 1) = (en(t, 1) - en(1, 1));
    rate(t, 2) = (en(t, 2) - en(1, 2));
    rate(t, 3) = (en(t, 3) - en(1, 3));
    rate(t, 4) = (en(t, 4) - en(1, 4));
    rate(t, 5) = (en(t, 5) - en(1, 5));
end

plot(tt,rate(:, 5)/en(1, 5), '-k', 'LineWidth',2);
xlabel('\Omega_{cl}t');
ylabel('(E(t)-E(1))/E(1)');
xlim([0,tt(end)]);
set(gca,'FontSize',14);
cd(outdir)
print(h2, '-dpng','-r300','energy_rate.png');

h3 = figure;
plot(tt, rate(:, 1), '-g', 'LineWidth', 2);
hold on
plot(tt, rate(:, 2), '-k', 'LineWidth', 2);
plot(tt, rate(:, 3), '-r', 'LineWidth', 2);
plot(tt, rate(:, 4), '-b', 'LineWidth', 2);
xlabel('\Omega_{cl}t');
ylabel('E(t) - E(0)');
legend('E', 'B', 'Electron', 'Ion', 'Location', 'Best', 'Box', 'off');
xlim([0,tt(end)]);
set(gca,'FontSize', 14);
cd(outdir);
print(h3, '-dpng','-r300','energy_change.png');