function ff=simu_filter2d(f0)
%%
ny=size(f0,1);
nx=size(f0,2);

%%
ff=f0;
for j=2:ny-1
    for i=2:nx-1
      ff(j,i)=0.25*f0(j,i)+0.125*(f0(j-1,i)+f0(j+1,i)+f0(j,i+1)+f0(j,i-1))+...
            0.0625*(f0(j-1,i-1)+f0(j-1,i+1)+f0(j+1,i-1)+f0(j+1,i+1));
    end
end
%%
