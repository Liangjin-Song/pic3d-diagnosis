function png_distribution_function(obj)
%% writen by Liangjin Song on 20210330
% save the distribution function figures
name=['Dst',obj.name.species,'_y-z','_t',num2str(obj.time.step),obj.name.extra,'.png'];
print(obj.handle.f1,'-dpng','-r300',name);
name=['Dst',obj.name.species,'_x-z','_t',num2str(obj.time.step),obj.name.extra,'.png'];
print(obj.handle.f2,'-dpng','-r300',name);
name=['Dst',obj.name.species,'_x-y','_t',num2str(obj.time.step),obj.name.extra,'.png'];
print(obj.handle.f3,'-dpng','-r300',name);
