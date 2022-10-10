% plot multi-Bz
% writen by Liangjin Song on 20200703

prmfile='/home/liangjin/Documents/MATLAB/scrp/article/parameters.m';
run(prmfile);

%% figure 1a, Bz line of five moments
t1=30;
t2=30.5;
t3=31;
t4=31.5;
t5=32;

cd(indir);
bz1=read_data('Bz',t1);
bz2=read_data('Bz',t2);
bz3=read_data('Bz',t3);
bz4=read_data('Bz',t4);
bz5=read_data('Bz',t5);
[lb1,lx]=get_line_data(bz1,Lx,Ly,z0,c,0);
[lb2,~]=get_line_data(bz2,Lx,Ly,z0,c,0);
[lb3,~]=get_line_data(bz3,Lx,Ly,z0,c,0);
[lb4,~]=get_line_data(bz4,Lx,Ly,z0,c,0);
[lb5,~]=get_line_data(bz5,Lx,Ly,z0,c,0);

lw=2;
plot(lx,lb1,'r','LineWidth',lw); hold on
plot(lx,lb2,'g','LineWidth',lw);
plot(lx,lb3,'b','LineWidth',lw);
plot(lx,lb4,'k','LineWidth',lw);
plot(lx,lb5,'m','LineWidth',lw);
xlim([57,93]);
xlabel('X[c/\omega_{pi}]');
ylabel('Bz');
l1=legend(['\Omega_{ci}t=',num2str(t1)],['\Omega_{ci}t=',num2str(t2)],['\Omega_{ci}t=',num2str(t3)],['\Omega_{ci}t=',num2str(t4)],['\Omega_{ci}t=',num2str(t5)]);

set(gca,'FontSize',14);
