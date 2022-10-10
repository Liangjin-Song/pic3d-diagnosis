clear;
%% constants
const.e=1.602176634e-19;
const.me=9.1093837015e-31;
const.c=299792458.0;
const.epsilon_0=8.8541878128e-12;

%% parameters
B0 = 34.4e-9;
ne=[5.57,2,1]*1e6;
vd=[0,-7.5e6,6.5e6];

ks=linspace(1.8e-4,5e-4,100);
f0=40;
nks=length(ks);
fs=zeros(1,nks);

%% options for fsolve
options = optimoptions('fsolve','Display','none');

%% calculation
for i=1:nks
    k=ks(i);
    f0=fsolve(@n_func, f0, options, k, ne, vd, B0, const);
    fs(i)=f0;
end

%% figure
f=figure;
plot(ks,fs);
xlim([-5e-4,5e-4]);
ylim([70,2e3]);
xlabel('k_{||} [m^{-1}]');
ylabel('f [Hz]');


%% function
function result = n_func(f, k, ne, vd, b0, const)
w=f*pi*2;
n2 = (k.^2*const.c.^2)./(w.^2);
wpe= (const.e.^2*ne/const.me/const.epsilon_0).^0.5;
wce= const.e*b0/const.me;
disp = 1-sum(wpe.^2/w.^2.*(w-k.*vd)./(w-k.*vd-wce));
result=n2-disp;
end