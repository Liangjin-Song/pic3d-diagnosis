%% plot magnetic field
% writen by Liangjin Song on 20200221
%%
clear;
indir='E:\PIC\wave-particle\whistler\data5';
outdir='E:\PIC\wave-particle\whistler\out5';
prm=slj.Parameters(indir, outdir);
aviname=[outdir,'\magnetic.avi'];

%% time
% tt=[0:157,158.01:280.01,281:321,322.04:362.04,363.03:403.03,404.02:444.02,445.01:485.01,486:500];
tt=[0:232,233.01:396.01,397.02:499.02];

%% range
xrange=[1,prm.value.nx];
yrange=[-0.02,0.02];

nt=length(tt);

aviobj=VideoWriter(aviname);
open(aviobj);

for t=1:nt
    cd(indir)
    b=prm.read('B',tt(t));
    plot(1:prm.value.nx,b.x,'r'); hold on
    plot(1:prm.value.nx,b.y,'g');
    plot(1:prm.value.nx,b.z,'b'); hold off
    xlabel('X');
    ylabel('B');
    xlim(xrange);
    ylim(yrange);
    title(['t = ',num2str(tt(t)),'    Bx:red,  By:green,  Bz:blue']);
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
end
close(aviobj);