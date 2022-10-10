function rec2d_ebound(tagx,tagy)
%% set the boundary condition for electric field
%%
global ex ey ez
global parameter
%%
nx=parameter.nx;
ny=parameter.ny;
%%
%% --------------set X direction----------------
if strncmp(tagx,'periodic',2)==1,
    ex(nx+2,:)=ex(2,:);
    ex(1,:)=ex(nx+1,:);
    ey(nx+2,:)=ey(2,:);
    ez(nx+2,:)=ez(2,:);
end

%% ------------set Y direction---------------------
if strncmp(tagy,'conducting',2)==1,
   %% Ex=Ez=0 at the boundary, Ey outside the boundary are set to zero.
     ex(:,2)=0;
     ex(:,ny+2)=0;
     ey(:,1)=0;
     ey(:,ny+2)=0;
     ez(:,2)=0;
     ez(:,ny+2)=0;
end

