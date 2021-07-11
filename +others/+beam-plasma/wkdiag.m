
nx=1024;
nt=1024;
ntime=16384*4;
dt=0.025;
rene=1;

Ex=Ex';
wk = wkfft(Ex,nx,nt,nx,nt,0);
wk = [fliplr(wk(4:2:end,1:2:(end-1))'),wk(1:2:end,1:2:(end-1))'];
wk2 = [fliplr(wk(4:2:end,1:2:(end-1))'),wk(3:2:end,1:2:(end-1))'];

  wk = wk*rene;
  wk = log10(wk);
  wk2 = log10(wk2*rene);
  
  % omega
  %isplot=prm.ntime/2;
  isdiag = ntime/nt;
  wmin = 2*pi/dt/2/(nt/2)/isdiag;
  wmax = wmin*(nt/2);
  %wmin = 2*pi/nt;
  %wmax = wmin*(nt/2-1);
  w = 0:wmin:(wmax-wmin);
  
  % wave number
  kmin = 2*pi/nx;
  kmax = kmin*(nx/2-1);
  k = [-kmax:kmin:-kmin,0,kmin:kmin:kmax];

  imagesc(k,w,wk);
  shading flat;
  set(gca,'Yscale','linear');
  xlabel('k');
  ylabel('\omega');
  
  wkmax = max(max(wk2));
  wkmin = min(min(wk2));
  caxis([wkmin, wkmax])
  
  title(sprintf('log %s (min: %5.2g, max: %5.2g)','Ex',wkmin,wkmax))
  
  wmaxplot = (wmax-wmin);
  kmaxplot = kmax;
  axis([-kmaxplot,kmaxplot,0,wmaxplot])