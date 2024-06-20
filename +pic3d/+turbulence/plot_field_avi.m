%% create the avi file
%% parameters
indir='E:\Turbulence\run1\data';
outdir='E:\Turbulence\run1\out\avi';
prm=slj.Parameters(indir,outdir);

tt=0:125;
name='Ne';
norm=prm.value.n0;

%% create the avi file
cd(outdir);
v = VideoWriter('Ne.avi');
v.FrameRate = 5;
open(v);

%%
extra.xlabel = 'X [c/\omega_{pe}]';
extra.ylabel = 'Z [c/\omega_{pe}]';
%%
figure;
nt = length(tt);
for t = 1:nt
    cd(indir);
    %% read and calculate
    %% perpendicular magnetic field
%     fd = prm.read(name, tt(t));
%     fd = sqrt(fd.x.^2 + fd.z.^2);
%     cxs = [0, 1.5];
%     extra.title = ['B_{\perp} at t = ' num2str(tt(t), '%06.2f')];
    %% parallel magnetic field
%     fd = prm.read(name, tt(t));
%     fd = fd.y;
%     cxs = [-1.5, 0];
%     extra.title = ['B_y at t = ' num2str(tt(t), '%06.2f')];
    %% current in y component
%     fd = prm.read(name, tt(t));
%     fd = fd.y;
%     cxs = [-4, 4];
%     extra.title = ['J_y at t = ' num2str(tt(t), '%06.2f')];
    %% plasma density
    fd = prm.read(name, tt(t));
    fd = fd.value;
    cxs = [0, 1.8];
    extra.title = ['Ne at t = ' num2str(tt(t), '%06.2f')];
    %% plot figure
    slj.Plot.field2d(fd/norm, prm.value.lx, prm.value.lz, extra);
    caxis(cxs);
    %% write the frame
    writeVideo(v, getframe(gcf));
end

%% close the video
close(v);
cd(outdir);