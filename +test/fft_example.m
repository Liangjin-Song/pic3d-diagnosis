clear;
%% =============================================================== %%
%% 一维情况
Fs = 1000;            % 采样频率
T = 1/Fs;             % 采样周期
L = 5000;             % 信号长度   由此知，频率分辨率为 0.2hz
t = (0:L-1)*T;        % 时间向量
S = 0.7*sin(2*pi*50*t+pi/4) + 0.8*sin(2*pi*150*t-pi/2) + 0.5;   % 原始函数

%% 傅里叶变换
Y = fft(S);
P2 = abs(Y/L);  % 每个量除以数列长度 L
P1 = P2(1:L/2+1);  % 取交流部分
P1(2:end-1) = 2*P1(2:end-1); % 交流部分模值乘以2
f = Fs*(0:(L/2))/L;

%% 绘图
% 原始信号
figure;
plot(t, S, '-k', 'LineWidth', 1.5);
title('原始信号');
xlabel('时间 (t)');
ylabel('幅值');

figure;
plot(f,P1, '-k', 'LineWidth', 1.5);
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('频率 (Hz)');
% ylabel('|P1(f)|');
ylabel('幅值');

%% 相位
f1=Y(1:L/2+1);
f1=atan2(imag(f1),real(f1))+pi/2;
% 需要将fft的结果加上pi/2才是真实的值，实验出来的
% 可能是matlab内置fft默认使用余弦，而实验信号是正弦
theta = [f1(51) f1(151)];
disp(theta);
%}
%% =============================================================== %%
%% 二维情况
% 时间分量
Ft = 150;               % 时间采样频率
T = 1/Ft;              % 时间采样周期
Lt = 300;              % 时间信号长度   由此知，频率分辨率为 0.5hz
t = (0:Lt-1)*T;        % 时间向量
% 空间分量
Fl = 100;            % 空间采样频率
L = 1/Fl;             % 空间采样周期
Ll = 200;            % 空间信号长度
l = (0:Ll-1)*L;       % 空间向量

[Cl, Ct] = meshgrid(l, t);
S = zeros(Lt, Ll)+1;
for i=1:10
    S = S + 2*sin(2*pi*5*Cl*i+2*pi*10*Ct*i);
end
% S = 10*sin(2*pi*50*Ct-2*pi*30*Cl+pi/4) + 8*sin(2*pi*150*Ct-2*pi*100*Cl-pi/2) + 0.5;   % 原始函数

%% 傅里叶变换
Y = fft2(S);
P2 = abs(Y/(Lt * Ll));  % 每个量除以数列长度 L
P1 = P2(1:Lt/2+1, 1:Ll/2+1);  % 取交流部分
P1(2:end-1, 2:end-1) = 2*P1(2:end-1, 2:end-1); % 交流部分模值乘以2
f = Ft*(0:(Lt/2))/Lt;
k = Fl*(0:(Ll/2))/Ll;

%% 绘图
% 原始信号
figure;
pcolor(Cl, Ct, S);
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('x (m)');
ylabel('t (s)');
title('Original Signal');
set(gca,'FontSize',14);

% 谱空间信号
[Ck, Cf] = meshgrid(k, f);
figure;
pcolor(Ck, Cf, P1);
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('k (m^{-1})');
ylabel('f (Hz)');
title('一半谱空间信号');
set(gca,'FontSize',14);

%%
f = linspace(-Ft/2, Ft/2, Lt);
k = linspace(-Fl/2, Fl/2, Ll);
[Ck, Cf] = meshgrid(k, f);
figure;
pcolor(Ck, Cf, abs(fftshift(Y))/(Lt*Ll));
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('k (m^{-1})');
ylabel('f (Hz)');
title('谱空间信号shift');
set(gca,'FontSize',14);

%%
f = linspace(0, Ft, Lt);
k = linspace(0, Fl, Ll);
[Ck, Cf] = meshgrid(k, f);
figure;
pcolor(Ck, Cf, P2);
shading flat;
p.FaceColor = 'interp';
colorbar;
xlabel('k (m^{-1})');
ylabel('f (Hz)');
title('全谱空间信号');
set(gca,'FontSize',14);


%% =============================================================== %%
%% my fft test
[sas, hsas, oft] = slj.Physics.fft2d(Fl, Ft, S);

figure;
slj.Plot.field2d_suitable(sas.ft, sas.lk, sas.lw, []);
xlabel('k (m^{-1})');
ylabel('f (Hz)');
title('shift fft signal');
set(gca,'FontSize',14);

figure;
slj.Plot.field2d_suitable(hsas.ft, hsas.lk, hsas.lw, []);
xlabel('k (m^{-1})');
ylabel('f (Hz)');
title('fft signal');
set(gca,'FontSize',14);