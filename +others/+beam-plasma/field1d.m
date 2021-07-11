function field1d(fd, Lx, it,norm)
%for plotting of field in 1d  and 2d simulation
%
ndx=size(fd,2);
%
xx=0:Lx/ndx:(Lx-Lx/ndx); 
dd=fd(it,:);
if nargin>3, dd=dd/norm;  end
%
plot(xx,dd)
axis([0 Lx -inf inf])
