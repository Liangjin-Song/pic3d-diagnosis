% center.x=0.1;
% center.y=1.2;
% bradius = 0.25;
% sradius = 0;
% id=spc.ring_particle_id(prm, 1, center, bradius, sradius);

outdir='E:\Asym\dst1\out\Kinetic\Distribution\Cold_Ions\Separatrix\Sphere\t=20';
tt=0:50;

aviname=[outdir,'\','particle_position.avi'];
aviobj=VideoWriter(aviname);
aviobj.FrameRate=10;
open(aviobj);
figure;

nt=length(tt);
for t=1:nt
    time=tt(t);
    name=['PVh_ts',num2str(time/prm.value.wci),'_x600-1400_y418-661_z0-1'];
    
%     f=figure;
    idd = slj.Plot.particle_position(prm, id, name, time);
    xlabel('X [c/\omega_{pi}]');
    ylabel('Z [c/\omega_{pi}]');
    title(['\Omega_{ci}t=',num2str(time)]);
    set(gca,'FontSize', 14);
    xlim([10,40]);
    ylim([-8,8]);
    

    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
    hold off
    
%     cd(outdir);
%     print(f,'-dpng','-r300',['particle_position_t',num2str(time,'%06.2f'),'.png']);
%     close(f);
end
close(aviobj);