clear;
h = 0.001;


figure;
hold on

%% 
trange=90:120;
nt = length(trange);
area(trange*h, zeros(1, nt)+7, 'EdgeColor', [0.9, 0.9, 0.9], 'FaceColor', [0.9, 0.9, 0.9]);
center=105*h;
plot(center, 6, '^r', 'LineWidth', 5);
plot(center, 4, '^r', 'LineWidth', 5);
plot(center, 2, '^r', 'LineWidth', 5);

center=570*h;
trange=500:640;
nt = length(trange);
area(trange*h, zeros(1, nt)+7, 'EdgeColor', [0.9, 0.9, 0.9], 'FaceColor', [0.9, 0.9, 0.9]);
plot(center, 6, '^r', 'LineWidth', 5);
plot(center, 4, '^r', 'LineWidth', 5);
plot(center, 2, '^r', 'LineWidth', 5);


center=(1000+1040)*0.5*h;
trange=1000:1040;
nt = length(trange);
area(trange*h, zeros(1, nt)+7, 'EdgeColor', [0.9, 0.9, 0.9], 'FaceColor', [0.9, 0.9, 0.9]);
plot(center, 6, '^r', 'LineWidth', 5);
plot(center, 4, '^r', 'LineWidth', 5);
plot(center, 2, '^r', 'LineWidth', 5);


%% 
trange=1200:1260;
nt = length(trange);
area(trange*h, zeros(1, nt)+7, 'EdgeColor', [0.9, 0.9, 0.9], 'FaceColor', [0.9, 0.9, 0.9]);
center=(1200+1260)*0.5*h;
plot(center, 3, '^c', 'LineWidth', 5);
plot(center, 5, '^c', 'LineWidth', 5);

center=(1560+1650)*0.5*h;
trange=1560:1650;
nt = length(trange);
area(trange*h, zeros(1, nt)+7, 'EdgeColor', [0.9, 0.9, 0.9], 'FaceColor', [0.9, 0.9, 0.9]);
plot(center, 3, '^c', 'LineWidth', 5);
plot(center, 5, '^c', 'LineWidth', 5);

center=(1980+2050)*0.5*h;
trange=1980:2050;
nt = length(trange);
area(trange*h, zeros(1, nt)+7, 'EdgeColor', [0.9, 0.9, 0.9], 'FaceColor', [0.9, 0.9, 0.9]);
plot(center, 3, '^c', 'LineWidth', 5);
plot(center, 5, '^c', 'LineWidth', 5);


%% 
center=(2200+2250)*0.5*h;
trange=2200:2250;
nt = length(trange);
area(trange*h, zeros(1, nt)+7, 'EdgeColor', [0.9, 0.9, 0.9], 'FaceColor', [0.9, 0.9, 0.9]);
plot(center, 1, '^g', 'LineWidth', 5);
plot(center, 2, '^g', 'LineWidth', 5);

center=(3850+3950)*0.5*h;
trange=3850:3950;
nt = length(trange);
area(trange*h, zeros(1, nt)+7, 'EdgeColor', [0.9, 0.9, 0.9], 'FaceColor', [0.9, 0.9, 0.9]);
plot(center, 1, '^g', 'LineWidth', 5);
plot(center, 2, '^g', 'LineWidth', 5);

%%
plot([0,5], [0, 0], '-k');

%%
xlim([0,5]);
ylim([0,7]);

%%
