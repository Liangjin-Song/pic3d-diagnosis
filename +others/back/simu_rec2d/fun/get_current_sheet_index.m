function index=get_current_sheet_index(bx,dirt)
%% writen by Liangjin Song on 20181116
% get the position where Bx=0 in Z direction.
% 
% if dirt=1, meaning the uper plane, if dirt=0, meaning the lower plane.
%%

nx=size(bx,2);
ny=size(bx,1);
hny=ny/2;
% bx=bx/c;
index=zeros(1,nx);

if dirt>0
    hbx=bx(hny+1:ny,:);
else
    hbx=bx(1:hny,:);
end

for i=1:nx
    line=hbx(:,i);
    line=abs(line);
    [~,in]=min(line);
    if dirt>0
    in=in+hny;
    end
    index(i)=in;
end
