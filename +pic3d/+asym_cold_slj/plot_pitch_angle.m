%% plot the pitch angle from the species

tt = 50;
%% the pitch angle
B=prm.read('B', tt);
[pth, lp] = spc.pitch(prm, B, 200);

%% figure
figure;
plot(lp, pth,'-k', 'LineWidth', 2);
xlabel('\theta');
ylabel('f_{ic}');
xlim([lp(1), lp(end)]);
set(gca,'FontSize',14);