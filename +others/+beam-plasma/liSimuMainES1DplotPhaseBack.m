%  liSimuMainES1Dplot02Phase.m ---to plot the phase-space distribution
%  Li Shi-you,Wuhan U. China. P.R. 2006/07/30
%  2006/09/04 lishy, revised


clear

timestep=256*0.025; 
NN=86;
file1='Ex000.dat';
file2='Ey000.dat';
%file3='Prt3_000.dat';
figure
tic
for i=0:NN
    if i<10
        file1(5)=num2str(i);
        file2(5)=num2str(i);
        %file3(8)=num2str(i);
    end
    if i>=10 & i<100
        file1(4:5)=num2str(i);
        file2(4:5)=num2str(i);
        %file3(7:8)=num2str(i);
    end
    ex=importdata(file1);
    ey=importdata(file2);
    ee=sqrt(ex.^2+ey.^2);
    %Prt3=importdata(file3);
    %Prt_e=Prt1+Prt2;
    %Prt_i=Prt3;
clf
%subplot('position',[0.1,0.53,0.85,0.35])
imagesc (ee); figure(gcf),colorbar,axis tight
title(['bump-on-tail instability, t \omega_{ce}=',num2str(i*timestep*1.0+0.01)])
xlabel('X [V_{th}/\omega_{pe}]');
ylabel('Vx, electron');
%
%subplot('position',[0.1,0.13,0.85,0.35])
%imagesc (Prt3); figure(gcf),colorbar,axis tight
%xlabel('X [V_{th}/\omega_{pe}]');
%ylabel('Vx, ion');
movieFramePhase(i+1)=getframe(gcf);
i
end
toc
movie2avi(movieFramePhase,'energy of E.avi')


