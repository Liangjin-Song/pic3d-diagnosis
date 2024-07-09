% w0 = prm.value.wci;
% di0=prm.value.di;
% vA0 = prm.value.vA;
% 
% c = prm.value.c;
% c2 = c .* c;
% 
% wge = 114.11 * w0;
% wpe = 160 * w0;
% 
% wgi = 1.1 * w0;
% wpic = 7.1 * w0;
% wpih = 14.3 * w0;
% wpi = 16 * w0;
% 
% wp= wpic;
% wg= wgi;
% 
% wp2 = wp .^ 2;
% wg2 = wg .^ 2;
%% linear dispersiont relation
v = 2.5;
k = -5:5;
w = v .* k;
hold on
p1 = plot(k, w, '--b', 'LineWidth', 2);
legend(p1, '\omega = c_{ia}''k');

%% grouth rate of ion-acoustic wave
k=0:0.01:5;
mei = 0.01;
cs = 0.7;
ve0=2.2;
tau = 0.32;

w = sqrt(pi./8) .* k .* cs .* (sqrt(mei) .* (ve0 ./ cs - 1) - tau.^(3/2) .* exp(-tau./2));
hold on;
p2 = plot(k, 100*w, '--r', 'LineWidth', 2);

disp(ve0 - cs .* (1 + 10 .* tau.^(3/2) .* exp(-tau./2)));

% 
%% parallel L-mode
% w = 0 : 100;
% ww=w.*w0;
% ww2=ww.*ww;
% k = 1 - wp2 ./(ww .* (ww + wg));
% k = k .* ww2 ./ c2;
% k = real(sqrt(k)) * di0;
% k(k == 0) = nan;
% 
% hold on;
% p2 = plot(k, w, '--r', 'LineWidth', 2);
% 
%% parallel R-mode
% k = 1 - wp2 ./(ww .* (ww - wg));
% k = k .* ww2 ./ c2;
% k = real(sqrt(k)) * di0;
% k(k == 0) = nan;
% 
% hold on;
% p3 = plot(k, w, '--k', 'LineWidth', 2);
% 
% %% upper-hybrid waves
% v=sqrt(wp2./(1+wp2./wg2))./vA0;
% disp(v);

%% parallel whistler dispersion relation
% w = 0 : 10;
% ww=w.*w0;
% ww2=ww.*ww;
% k = 1 + wp2./(ww.*(wg - ww));
% k = k .* ww2 ./ c2;
% k = sqrt(k);
% k = real(k) .* di0;
% hold on;
% plot(k, w, '--r', 'LineWidth', 2);

%% electron whistler
% k = 0.1:0.1:5;
% k = k ./ di0;
% k2 = k .* k;
% 
% % w = wg ./ (1 + wp2 ./ (k2 .* c2));
% w = k2 .* c2 .* wg ./ wp2;
% 
% hold on
% p2=plot(k*di0, w/w0, '--b', 'LineWidth', 2);

%% R-mode of whistler
% k = 0.01:0.01:5;
% k = k ./ di0;
% k2 = k .^ 2;
% w = wge/2;
% w = w ./ (1 + (wpe .^ 2) ./ (k2 .* c2));
% w = w .* (sqrt(1 + 4 .* (wpi .^ 2) ./ (k2 .* c2)) + 1);
% hold on
% plot(k*di0, w/w0, '--r', 'LineWidth', 2);

%% L-mode of whistler
% k = 0.01:0.01:5;
% k = k ./ di0;
% k2 = k .* k;
% w = wgi/2;
% w = w ./ (1 + (wpe .^ 2) ./ (k2 .* c2));
% w = w .* (sqrt(1 + 4 .* (wpe .^ 2) ./ (k2 .* c2)) - 1);
% hold on
% plot(k*di0, w/w0, '--r', 'LineWidth', 2);

%% R-mode of whistler
% dw = 0.001;
% w = dw:dw:10;
% w = w .* w0;
% k2 = w.^2 - (w .* wpe.^2)./(w - wge);
% k2 = k2 - (w .* wpic.^2)./(w + wgi);
% k2 = k2 - (w .* wpih.^2)./(w + wgi);
% k2 = k2 ./ c2;
% k = sqrt(k2);
% hold on
% plot(k*di0, w/w0, '--r', 'LineWidth', 2);

%% parallel whistler eq. 10.164
% dw = 0.001;
% w = dw:dw:10;
% w = w .* w0;
% k2 = 1 + wpe.^2 ./ (w .* (wge - w));
% k2 = k2 .* w.^2;
% k = sqrt(k2 ./ c2);
% hold on
% plot(k*di0, w/w0, '--r', 'LineWidth', 2);

%% parallel whistler custom
% wp2 = wpic.^2;
% wg = wgi;
% wg2 = wg.^2;
% dw = 0.001;
% w = dw:dw:10;
% w = w .* w0;
% k2 = w.^2 - (w.^2 .* wp2)./(w.^2 - wg2);
% k2 = k2 + (w .* wg .* wp2)./(w.^2 - wg2);
% k2 = k2 ./ c2;
% k = sqrt(k2);
% hold on
% plot(k*di0, w/w0, '--r', 'LineWidth', 2);