function obj=filter2d(obj, n)
%%
% @info: writen by Liangjin Song on 20210521
% @brief: filter2d - smoothing the 2d field
% @param: obj - the Scalar object
% @param: n - the smoothing times
% @return obj - smoothed field
%%
if nargin == 1
    n=1;
end
ff=obj.value;
for i=1:n
    ff=smooth(ff);
end
obj=slj.Scalar(ff);
end

%% ======================================================================== %%
function ff=smooth(f0)
%%
% @brief: smooth - smoothing the 2d field
% @param: f0 - the 2d field
% @return: ff - smoothed field
%%
ny=size(f0,1);
nx=size(f0,2);
% ff=zeros(ny,nx);
ff=f0;
for j=2:ny-1
    for i=2:nx-1
      ff(j,i)=0.25*f0(j,i)+0.125*(f0(j-1,i)+f0(j+1,i)+f0(j,i+1)+f0(j,i-1))+0.0625*(f0(j-1,i-1)+f0(j-1,i+1)+f0(j+1,i-1)+f0(j+1,i+1));
    end
end
end
