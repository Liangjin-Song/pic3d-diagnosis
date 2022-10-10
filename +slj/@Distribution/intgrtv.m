function fd = intgrtv(obj, dir)
%%
% @info: writen by Liangjin Song on 20210603
% @brief: get the integration of the velocity distribution
% @param: dir - the integral direction
% @return: fd - the integral result, the Distribution class
%%
ll=obj.ll;
value=sum(obj.value, dir);
value=reshape(value,length(ll),length(ll))';
fd = slj.Distribution(obj.time, obj.range, ll, value);
end
