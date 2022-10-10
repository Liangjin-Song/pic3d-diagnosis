%% plot magnetic field
% writen by Liangjin Song on 20200221
%%
clear;
indir='E:\PIC\wave-particle\whistler\data5';
outdir='E:\PIC\wave-particle\whistler\out5';
prm=slj.Parameters(indir, outdir);
aviname=[outdir,'\electric.avi'];

%% time
%tt=[0:157,158.01:280.01,281:321,322.04:362.04,363.03:403.03,404.02:444.02,445.01:485.01,486:500];
tt=[0:232,233.01:396.01,397.02:499.02,500];

%% range
xrange=[1,prm.value.nx];
yrange=[-4,4];

nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);

for t=1:nt
    cd(indir)
    e=prm.read('E',tt(t));
    plot(1:prm.value.nx,e.x/prm.value.vA,'r'); hold on
    plot(1:prm.value.nx,e.y/prm.value.vA,'g');
    plot(1:prm.value.nx,e.z/prm.value.vA,'b'); hold off
    xlabel('X');
    ylabel('E');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t)),'    Ex:red,  Ey:green,  Ez:blue']);
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);