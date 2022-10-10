function fw=wk1d(ex,dt,i1,i2)
% do the fourier analysis for 1d field
%
%  form: fw=wk1d(ex,i1,i2,dt)
%input:
%  ex is the array containing the information of field
%  dt is the time resolution or spatial resolution
%  i1 and i2 denote the array interval
%output:
%   fw is the fourier coefficient
%
%the ex must be a 1d array
%-----------written by M.Zhou,2006,at SDCC-------------------------
if nargin>2,ex=ex(i1:i2);end
n=length(ex);
fw=zeros(n/2+1,1);
%
ff=realfft(ex,n);
fw(1)=abs(ff(1));
for i=2:n/2
    fw(i)=sqrt(ff((i-1)*2+1)^2+ff((i-1)*2+2)^2);
end
fw(n/2+1)=abs(ff(2));
fw=fw*2*n*dt;
%
dw=2*pi/(dt*n);
ww=0:dw:dw*n/2;
plot(ww,fw,'k')

