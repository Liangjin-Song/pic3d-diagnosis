%% plot multi Bz line
% writen by Liangjin Song on 20190620 
indir='/data/simulation/M100SBg00Sx_low_vte/ppc=100/';
outdir='/data/simulation/M100SBg00Sx_low_vte/out/ppc=100/time/';

t1=33;
t2=38;
t3=43;
t4=48;
t5=53;

c=0.6;
di=60;
Lx=6000/di;
Ly=3000/di;
x0=12.5;

xrange=[Lx/2,Lx];

cd(indir);
bz1=read_data('Bz',t1);
bz2=read_data('Bz',t2);
bz3=read_data('Bz',t3);
bz4=read_data('Bz',t4);
bz5=read_data('Bz',t5);
[lb1,lx]=get_line_data(bz1,Lx,Ly,x0,c,0);
[lb2,~]=get_line_data(bz2,Lx,Ly,x0,c,0);
[lb3,~]=get_line_data(bz3,Lx,Ly,x0,c,0);
[lb4,~]=get_line_data(bz4,Lx,Ly,x0,c,0);
[lb5,~]=get_line_data(bz5,Lx,Ly,x0,c,0);

figure;
plot(lx,lb1,'r','LineWidth',2); hold on
plot(lx,lb2,'g','LineWidth',2);
plot(lx,lb3,'b','LineWidth',2);
plot(lx,lb4,'k','LineWidth',2);
plot(lx,lb5,'m','LineWidth',2); hold off
xlim(xrange);

xlabel('X[c/\omega_{pi}]');
ylabel('Bz');
legend(['\Omega_{ci}t=',num2str(t1)],['\Omega_{ci}t=',num2str(t2)],['\Omega_{ci}t=',num2str(t3)],['\Omega_{ci}t=',num2str(t4)],['\Omega_{ci}t=',num2str(t5)]);

set(gca,'FontSize',14);
cd(outdir);
