dv=0.005;
vv=-0.5:dv:0.5;
vt=0.05;
f=1/sqrt(2*3.141926)/vt.*exp(-vv.^2./2/vt^2)*dv;
ff=sum(f)
plot(vv,f)