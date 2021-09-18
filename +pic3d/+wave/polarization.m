% function polarization()
clear;
%% parameters
% directory
indir='E:\PIC\wave-particle\whistler\data5';
outdir='E:\PIC\wave-particle\whistler\out5';
prm=slj.Parameters(indir, outdir);
% time
tt=120:0.1:150;
% position
x0=2600;
range=[-0.01,0.01];
%% the field as the function of the position and the time
nt=length(tt);
vec=zeros(nt,2);
for t=1:nt
    %% read data
    fd=prm.read('E',tt(t));
    vec(t,1)=fd.y(x0);
    vec(t,2)=fd.z(x0);
end
f=figure;
slj.Plot.arrow(vec(:,1),vec(:,2),'number',3,'color','r','linewidth',2);
xlabel('By');
ylabel('Bz');
set(gca,'fontsize',14);
xlim(range);
ylim(range);
cd(outdir)
print('-dpng','-r300','polarization.png');
% end