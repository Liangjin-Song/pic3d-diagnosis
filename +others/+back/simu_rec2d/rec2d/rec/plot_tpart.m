function plot_tpart(part,varname,norm,dt,t1,t2)
%%
switch varname
    case 'x',  f=part(:,2);  title='X/di';
    case 'z',  f=part(:,3);  title='Z/di';
    case 'vx', f=part(:,4);  title='v_{x}/v_{A}';
    case 'vy', f=part(:,5);  title='v_{y}/v_{A}';
    case 'vz', f=part(:,6);  title='v_{z}/v_{A}';
    case 'energy',f=part(:,7); title='wk/m_{e}c^{2}';
    case 'bx', f=part(:,8);    title='b_{x}/b0';
    case 'by', f=part(:,9);    title='b_{y}/b0';
    case 'bz', f=part(:,10);   title='b_{z}/b0';
    case 'ex', f=part(:,11);   title='e_{x}/(v_{A}b0)';
    case 'ey', f=part(:,12);   title='e_{y}/(v_{A}b0)';
    case 'ez', f=part(:,13);   title='e_{z}/(v_{A}b0)';
end
%%
f=f/norm;
N=length(f);
%%
tt=dt:dt:(N-1)*dt;
if nargin>4,    % clip a time range to plot
  n1=floor(t1/dt)+1;
  n2=floor(t2/dt);
  if n2>N, n=N; end
  f=f(n1:n2);
  tt=n1*dt:dt:n2*dt;
end
%%
figure
plot(tt,f,'k','linewidth',2)
set(gca,'fontsize',14,'linewidth',1.5)
xlabel('t\omega_{ci}','fontsize',15)
ylabel(title,'fontsize',15)







