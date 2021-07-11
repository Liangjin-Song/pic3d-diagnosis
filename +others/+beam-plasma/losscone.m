function losscone(delta,beta)
%delta=0.8;
%beta=0.25;
vt=3.;
dv=0.5;
vpar=-20:dv:20;
vper=-20:dv:20;
%
%delta=0.5;
%beta=0.2;
G=delta*exp(-vper.^2/2/vt^2)+(1-delta)/(1-beta)...
*(exp(-vper.^2/2/vt^2)-exp(-vper.^2/beta/2/vt^2));
%
fv=1/vt^3*G'*exp(-vpar.^2/2/vt^2);
N=length(fv(:,1));
for i=1:N
ff(i)=sum(fv(i,:))*dv;
end
    plot(vper,ff)