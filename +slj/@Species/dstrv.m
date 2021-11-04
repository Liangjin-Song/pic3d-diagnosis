function fd = dstrv(obj, ri, vi, norm, prcr)
%%
% @info: writen by Liangjin Song on 20210603
% @brief: dstrv - generate the distribution as the function of position and velocity
% @param: ri - an integer, indicating the position direction
% @param: vi - an integer, indicating the velocity direction
% @param: norm - the velocity normalization
% @param: prcr - the position precision
% @return: fd - the distribution function
%%
%% the precision
if nargin < 4
    norm = 1;
    prcr=400;
elseif nargin < 5
    prcr=400;
end
prcv=30;
%% set the position vector
if ri == 1
    lr=linspace(floor(min(obj.value.rx)), ceil(max(obj.value.rx)), prcr);
elseif ri == 2
    lr=linspace(floor(min(obj.value.ry)), ceil(max(obj.value.ry)), prcr);
elseif ri == 3
    lr=linspace(floor(min(obj.value.rz)), ceil(max(obj.value.rz)), prcr);
else
    error('Parameters error!');
end
%% set the velocity vector
if vi == 1
    obj.value.vx=obj.value.vx/norm;
    lv=max(abs(obj.value.vx))+0.01;
elseif vi == 2
    obj.value.vy=obj.value.vy/norm;
    lv=max(abs(obj.value.vy))+0.01;
elseif vi ==3
    obj.value.vz=obj.value.vz/norm;
    lv=max(abs(obj.value.vz))+0.01;
else
    error('Parameters error!');
end
lv=linspace(-lv,lv,prcv);
%% get the distribution function
frv=zeros(prcv, prcr);
np=length(obj.value.id);
for i=1:np
    if ri == 1
        pr=obj.value.rx(i);
    elseif ri == 3
        pr=obj.value.rz(i);
    elseif ri == 2
        pr=obj.value.ry(i);
    end
    pr=round(slj.Physics.linear([lr(1), 1], [lr(end), length(lr)], pr));
    if vi == 1
        pv = obj.value.vx(i);
    elseif vi == 2
        pv = obj.value.vy(i);
    elseif vi ==3
        pv = obj.value.vz(i);
    end
    pv=round(slj.Physics.linear([lv(1), 1], [lv(end), length(lv)], pv));
    frv(pv, pr) = frv(pv, pr) + obj.value.weight(i);
end
ll.lr=lr;
ll.lv=lv;
%% the Distribution class
fd=slj.Distribution(obj.time, obj.range, ll, frv);
end
