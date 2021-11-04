function fd = dstrvv(obj, ri, vi, norm, prcr)
%%
% @info: writen by Liangjin Song on 20210607
% @brief: dstrvv - generate the 3-D distribution function as the function of position and 2-D velocity
% @param: ri - an integer, indicating the position direction
% @param: vi - an integer, the velocity direction should be excluded
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
prcv=100;
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
    obj.value.vy=obj.value.vy/norm;
    lv1=max(abs(obj.value.vy))+0.01;
    obj.value.vz=obj.value.vz/norm;
    lv2=max(abs(obj.value.vz))+0.01;
elseif vi == 2
    obj.value.vx=obj.value.vx/norm;
    lv1=max(abs(obj.value.vx))+0.01;
    obj.value.vz=obj.value.vz/norm;
    lv2=max(abs(obj.value.vz))+0.01;
elseif vi ==3
    obj.value.vx=obj.value.vx/norm;
    lv1=max(abs(obj.value.vx))+0.01;
    obj.value.vy=obj.value.vy/norm;
    lv2=max(abs(obj.value.vy))+0.01;
else
    error('Parameters error!');
end
lv1=linspace(-lv1,lv1,prcv);
lv2=linspace(-lv2,lv2,prcv);
%% get the distribution function
frv=zeros(prcv, prcr, prcv);
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
        pv1 = obj.value.vy(i);
        pv2 = obj.value.vz(i);
    elseif vi == 2
        pv1 = obj.value.vx(i);
        pv2 = obj.value.vz(i);
    elseif vi ==3
        pv1 = obj.value.vx(i);
        pv2 = obj.value.vy(i);
    end
    pv1=round(slj.Physics.linear([lv1(1), 1], [lv1(end), length(lv1)], pv1));
    pv2=round(slj.Physics.linear([lv2(1), 1], [lv2(end), length(lv2)], pv2));
    frv(pv1, pr, pv2) = frv(pv1, pr, pv2) + obj.value.weight(i);
end
ll.lr=lr;
ll.lv1=lv1;
ll.lv2=lv2;
%% the Distribution class
fd=slj.Distribution(obj.time, obj.range, ll, frv);
end
