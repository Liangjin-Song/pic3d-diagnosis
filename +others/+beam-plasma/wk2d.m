function wk=wk2d(ex,i,i1,i2,j1,j2,tag)
% do the fourier analysis of 2d ex field
% the data format are suited for the program of Es2d
% inv=4;
% dt=0.2;
inv=1;
dt=0.02;
dr=1.;
m=i2-i1+1;
n=j2-j1+1;
ff=zeros(n,m);
wk=zeros(n/2,m/2,2);
if tag==0 % the w-k relation
   et=ex(j1*inv+i:inv:j2*inv+i,i1:i2);
   dw=2*pi/dt/n;
   dk=2*pi/dr/m;
   xx=0:dk:dk*m/2-dk;
   yy=0:dw:dw*n/2-dw;
else  % the kx-ky relation
   et=ex(j1:j2,i1:i2);
   dkx=2*pi/dr/m;
   dky=2*pi/dr/n;
   xx=0:dkx:dkx*m/2-dkx;
   yy=0:dky:dky*n/2-dky;
end
%
for jj=1:n
  ff(jj,:)=realfft(et(jj,:),m);
  %ff(jj,:)=wrk';
end
  ff(:,1:2)=ff(:,1:2).*0.5;
%
for ii=1:m
  ff(:,ii)=realfft(ff(:,ii),n);
end
  ff(1:2,:)=ff(1:2,:).*0.5;
%
      for iy=2:n/2
         for ix=2:m/2 
            ii=2*ix-1;
            jj=2*iy-1;
            i1=ii+1;
            j1=jj+1;
      %
            cc=ff(jj,ii);
            cs=ff(jj,i1);
            sc=ff(j1,ii);
            ss=ff(j1,i1);
      %
            a1=sqrt((cs-sc)^2+(cc+ss)^2);
            a2=sqrt((cs+sc)^2+(cc-ss)^2);
            wk(iy,ix,1)=a1;
            wk(iy,ix,2)=a2;
         end
      end
    %DC componets
      wk(1,1,:)=ff(1,1);
   %
      for ix=2:m/2
         ii=2*ix-1;
         i1=ii+1;
        %
         cc=ff(1,ii);
         cs=ff(1,i1);
         a1=sqrt(cs^2+cc^2);
         wk(1,ix,:)=a1;
      end
   %
      for iy=2:n/2
         jj=2*iy-1;
         j1=jj+1;
   %
         cc=ff(jj,1);
         sc=ff(j1,1);
         a1=sqrt(sc^2+cc^2);
         wk(iy,1,:)=a1;
      end
      %out put the result
      figure
      contourf(xx,yy,wk(:,:,1),'k');
      %hold on
      %wl=sqrt(1+3.*xx.^2);
      %wu=sqrt(2-0.025^2/101./(0.025^2+xx.^2));
      %plot(xx,wu,'k')
      %wb=xx.*5;
      %plot(xx,wb,'k')
      figure
      contourf(xx,yy,wk(:,:,2),'k');
      %hold on
      %plot(xx,wl,'k')
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
 
      