% center.x=0.1;
% center.y=1.2;
% bradius = 0.25;
% sradius = 0;
% id=spc.ring_particle_id(prm, 1, center, bradius, sradius);

outdir='E:\Asym\cold2_ds1\out\Kinetic\Distribution';
tt=0:60;

prefix = 'PVh_';
postfix = '_x800-1200_y418-661_z0-1';

id = idf;

aviname=[outdir,'\','particle_position.avi'];
aviobj=VideoWriter(aviname);
aviobj.FrameRate=10;
open(aviobj);
figure;

nt=length(tt);
for t=1:nt
    time=tt(t);
    spcs = pic3d.asym_cold_slj.func_add_all_distribution_function(prm, 'h', time);
    in = find(ismember(spcs.value.id, id) == 1);
    %     f=figure;
    %     idd = slj.Plot.particle_position(prm, id, name, time);
    ss = prm.read('stream', time);
    slj.Plot.stream(ss, prm.value.lx, prm.value.lz, 20);
    hold on
    plot(spcs.value.rx(in), spcs.value.rz(in), '*r');
    
    xlabel('X [c/\omega_{pi}]');
    ylabel('Z [c/\omega_{pi}]');
    title(['\Omega_{ci}t=',num2str(time)]);
    set(gca,'FontSize', 14);
    xlim([0,50]);
    ylim([-10,10]);
    
    
    currFrame = getframe(gcf);
    writeVideo(aviobj,currFrame);
    
    hold off
    
    %     cd(outdir);
    %     print(f,'-dpng','-r300',['particle_position_t',num2str(time,'%06.2f'),'.png']);
    %     close(f);
end
close(aviobj);