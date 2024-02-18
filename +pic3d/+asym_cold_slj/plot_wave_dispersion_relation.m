w0 = prm.value.wci;
di0=prm.value.di;
vA0 = prm.value.vA;

wp=16 * w0;
wg=1.1 * w0;
c = prm.value.c;


wp2 = wp .* wp;
wg2 = wg .* wg;
c2 = c .* c;


% %% linear dispersiont relation
v = 3.2;
k = -5:5;
w = v .* k;
hold on
p1 = plot(k, w, '-k', 'LineWidth', 2);
% 
% %% parallel L-mode
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
% %% parallel R-mode
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

% %% parallel whistler dispersion relation
% w = 0 : 10;
% ww=w.*w0;
% ww2=ww.*ww;
% k = 1 + wp2./(ww.*(wg - ww));
% k = k .* ww2 ./ c2;
% k = sqrt(k);
% k = real(k) .* di0;
% hold on;
% plot(k, w, '--r', 'LineWidth', 2);

%% 
k = 0.1:0.1:5;
k = k ./ di0;
k2 = k .* k;

% w = wg ./ (1 + wp2 ./ (k2 .* c2));
w = k2 .* c2 .* wg ./ wp2;

hold on
plot(k*di0, w/w0, '--k', 'LineWidth', 2);