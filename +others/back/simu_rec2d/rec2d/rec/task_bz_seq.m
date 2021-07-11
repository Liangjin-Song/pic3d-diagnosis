%% plot Bz at several different times
Lx=120;
Ly=60;
cut=-15;
%%
color=['k','r','g','b','y','c','m'];
tt=[60,64,68,72,76,80,84];
nt=length(tt);
%%
for i=1:nt
   it=num2str(tt(i),'%06.2f');
   it=[it(1:3),'_',it(5:6)];
   tmp=load(['Bz_t',it,'.mat']);
   tmp=struct2cell(tmp); bz=tmp{1};
    %%bz1=simu_shift(bz,Lx,Ly,12.8);
   plot_line(bz,Lx,Ly,cut,0.6,0,color(i));
    hold on
end
%%

    