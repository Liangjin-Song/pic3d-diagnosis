%{
clear;
h=0.02;
n=1500;
s(1:n)=0;
% for i=1:n
    s(1/h:3/h)=1;
    s(4.5/h:6/h)=1;
    s(7/h:8.5/h)=1;
    s(9/h:11/h)=1;
    s(12/h:13.8/h)=1;
    s((15/h):(16.4/h))=1;
    s(17/h:19.5/h)=1;
    s(20/h:22/h)=1;
    s(23.5/h:24/h)=1;
    s(24.5/h:25/h)=1;
    s(26/h:27/h)=1;
    s(27.5/h:28.2/h)=1;
    s(28.5/h:29/h)=1;
    s(29.2/h:29.8/h)=1;
% end
x=h*(1:n);
y=zeros(1,n);
plot(x,s,'r'); hold on
plot(x,y,'b'); 

fill([x fliplr(x)],[y fliplr(s)],'r');

% legend('dos');
xlabel('Time(s)');
ylabel('dos');
%}


t = 0:0.01:10;
x = sin(t);
y = sin(t+pi);
plot(t,x,'k'); hold on
plot(t,y,'b'); 
fill([t fliplr(t)],[x fliplr(y)],'r');