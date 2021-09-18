
nx=410;
ny=3001;

a;      % your matrix
lim=1;

x=[];
y=[];

for i=1:nx
    for j=ny
        if a(i,j)>lim
            x=[x,i];
            y=[y,j];
        end
    end
end

plot(x,y);
