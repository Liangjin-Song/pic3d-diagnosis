function obj = close(obj)
%% writen by Liangjin Song on 20210330
% close all figures
%%
for i=1:obj.number
    close(gcf);
end
obj.number=0;
obj.handle=[];

