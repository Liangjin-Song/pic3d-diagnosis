%%
tt=022.00;
ndx=1280; ndy=640;
b=zeros(ndy,ndx,3);
ui=zeros(ndy,ndx,3);
jc=zeros(ndy,ndx,3);
p=zeros(ndy,ndx,5);
n=zeros(ndy,ndx);
%load data
string={'Bx','By','Bz'};
'Ex','vxi','vyi','vzi','flwxi','flwyi','flwzi',...
         'flwxe','flwye','flwze','Pxxe','Pxye','Pxze','Pyye','Pyze'};
n=size(string);
for i=1:n
   filename=[string{i},num2str(tt),'.dat'];
   load filename
end
b(:,:,1)=[string{1},num2str(tt(1:3))];
b(:,:,2)=[string{2},num2str(tt(1:3))];
b(:,:,3)=[string{3},num2str(tt(1:3))];
clear -regexp \d
%

