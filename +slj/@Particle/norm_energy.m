function obj = norm_energy(obj, norm)
%% writen by Liangjin Song on 20210408
%% the energy normalization
%%
if isa(norm, 'slj.Parameters')
    norm=0.5*norm.value.mi*norm.value.vA*norm.value.vA;
end
obj.value.k=obj.value.k/norm;
obj.value.kx=obj.value.kx/norm;
obj.value.ky=obj.value.ky/norm;
obj.value.kz=obj.value.kz/norm;
obj.value.k_para=obj.value.k_para/norm;
obj.value.k_perp=obj.value.k_perp/norm;
obj.value.mu=obj.value.mu/norm;
end
