clear

%% make a stackplot for Bz
%%
tt=20:4:100;
nx=2000;
ny=1000;
Lx=200;
Ly=100;
%%
xrange=[0 200];
cut=-25;
increment=1.2;
% yrange=[-50 0];
%%
dirr='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\';
dirout='H:\island\island coalescence\mass=25\size_200_100\Bg=0.0\figures\';
cd(dirr)
%%
figure
nt=length(tt);
for i=1:nt
it=num2str(tt(i),'%06.2f');
it=[it(1:3),'_',it(5:6)];
tmp=load(['Bz_t',it,'.mat']); tmp=struct2cell(tmp); bz=tmp{1};
%%
bz=bz+increment*(i-1);
plot_line(bz,Lx,Ly,cut,0.6,0,'k');
hold on
end
%%
xlim(xrange)


