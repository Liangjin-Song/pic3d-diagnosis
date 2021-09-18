function value=scale(obj)
%% writen by Liangjin Song on 20210325
% set the length scale
%%
value=obj.value;
if contains(value.model,'rec3s-1harris')
    value.Lx=value.nx/value.dl;
    value.Lz=value.nz/value.dl;
    value.lx=linspace(0,value.Lx,value.nx);
    value.lz=linspace(-value.Lz/2, value.Lz/2, value.nz);
    if value.ny > 1
        value.Ly=value.ny/value.dl;
        value.ly=linspace(0, value.Ly, value.ny);
    end
end
