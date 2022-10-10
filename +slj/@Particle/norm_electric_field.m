function obj = norm_electric_field(obj, norm)
%% writen by Liangjin Song on 20210408
%% electric field normalization
%%
if isa(norm, 'slj.Parameters')
    norm=norm.value.vA;
end
obj.value.ex=obj.value.ex/norm;
obj.value.ey=obj.value.ey/norm;
obj.value.ez=obj.value.ez/norm;
obj.value.e_para=obj.value.e_para/norm;
obj.value.e_perp=obj.value.e_perp/norm;
end

