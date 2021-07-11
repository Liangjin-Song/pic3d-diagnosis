%% plot the distribution as a function of energy
endist_0=load('en_dist_t000.00.txt');
endist_1=load('en_dist_t020.00.txt');
endist_2=load('en_dist_t030.00.txt');
endist_3=load('en_dist_t040.00.txt');
norm=0.36;  %c^2
%%
energy=endist_0(:,1)/norm;
figure
loglog(energy,endist_0(:,2),'k')
hold on
loglog(energy,endist_1(:,2),'b')
loglog(energy,endist_2(:,2),'r')
loglog(energy,endist_3(:,2),'g')