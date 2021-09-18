function lfd=get_current_sheet_field(cs,fd)
%% get the field at the current sheet
% writen by Liangjin Song on 20191217
%
% cs is the current sheet index in z direction
% fd is the field
%
% lfd is the field at the current sheet
%%
nx=length(cs);
lfd=zeros(1,nx);

for i=1:nx
    lfd(i)=fd(cs(i),i);
end
