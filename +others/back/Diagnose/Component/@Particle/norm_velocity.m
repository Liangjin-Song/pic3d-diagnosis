function obj = norm_velocity(obj, norm)
%% the velocity normalization
%% writen by Liangjin Song on 20210412
%%
if isa(norm, 'Parameters')
    norm=norm.value.vA;
end
obj.value.vx=obj.value.vx/norm;
obj.value.vy=obj.value.vy/norm;
obj.value.vz=obj.value.vz/norm;
obj.value.v_para=obj.value.v_para/norm;
obj.value.v_perp=obj.value.v_perp/norm;
end

