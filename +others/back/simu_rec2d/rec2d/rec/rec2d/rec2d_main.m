%% a two-dimensioanl electromagnetic PIC simulation code for 
%% reconnection study
%% this is a Matlab version that as a test bed
%%
%% --------------written by Meng Zhou-----------------------------
% rec2d_main
%%
clear all

global parameter

% global ex ey ez bx by bz
% global x y vx vy vz
% global ajx,ajy,ajz

tic
%% input and initialization
parameter=rec2d_input_symmetry;
rec2d_initial;
ntime=floor(parameter.tlast/parameter.wci)+1;

m1=1;
m2=1;
m3=1;
for i=1:ntime
     disp(['time step = ',num2str(i)]);
%     [bx,by,bz]=bfield(bx,by,bz,ex,ey,ez);
%     [bx,by,bz]=bbound(bx,by,bz);
%     [x,y,vx,vy,vz]=mover(x,y,vx,vy,vz,bx,by,bz,ex,ey,ez);
%     [bx,by,bz]=bfield(bx,by,bz,ex,ey,ez);
%     [bx,by,bz]=bbound(bx,by,bz);
%     [ex,ey,ez]=efield(ex,ey,ez,bx,by,bz,ajx,ajy,ajz);
%     [ex,ey,ez]=ebound(ex,ey,ez);
     rec2d_bfield;
     rec2d_bbound('periodic','conduct');
     rec2d_mover('ion');
     rec2d_mover('ele');
     rec2d_ptbound('periodic','reflect');
     rec2d_bfield;
     rec2d_bbound('periodic','conduct');
     rec2d_current;
     rec2d_efield;
     rec2d_ebound('periodic','conduct');
     
    %%
       m1=rec2d_diag_field(i,m1);
       m2=rec2d_diag_plasma(i,m2);
       m3=rec2d_diag_energy(i,m3);
       
end

toc
%%

    
    
    
    
    