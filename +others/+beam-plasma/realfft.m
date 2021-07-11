function ret = realfft(x,n)

   nn=1/n;  
   x = fft(x,n).*nn;
  
  ret(1) = real(x(1));
  ret(2) = real(x(n/2+1));

  i = 1:(n/2-1);
  i2= i*2;
  ret(i2+1) = real(x(i+1));
  ret(i2+2) = imag(x(i+1));