function obj = field2d(obj, fd, prm, varargin)
%% writen by Liangjin Song on 20210401
% plot the 2d field
%%
obj.name = fd.name;
obj.time = fd.time;
if nargin == 3
    if fd.type == FieldType.Scalar
        obj.handle=figure;
        obj.type = FiguresType.Scalar;
        obj.number = 1;
        only_a_field(obj, fd.value, prm, fd.norm);
    elseif fd.type == FieldType.Vector
        obj.type = FiguresType.Vector;
        obj.number = 3;
        obj.handle.f1=figure;
        only_a_field(obj, fd.value.x, prm, fd.norm);
        obj.handle.f2=figure;
        only_a_field(obj, fd.value.y, prm, fd.norm);
        obj.handle.f3=figure;
        only_a_field(obj, fd.value.z, prm, fd.norm);
    end
elseif nargin == 4
end
end

%% ======================================================================== %%
function only_a_field(fig, fd, prm, norm)
    fd=fd/norm;
    fig.field(prm.value.lx, prm.value.lz,fd);
    xlabel('X [c/\omega_{pi}]','fontsize',14)
    ylabel('Z [c/\omega_{pi}]','fontsize',14)
    xlim([0,prm.value.Lx]);
    ylim([0,prm.value.Lz]);
end
