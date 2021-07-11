function rec2d_bbound(tagx,tagy)
%% set the boundary condition for magnetic field
%% 
global bx by bz
global parameter
%%
nx=parameter.nx;
ny=parameter.ny;

%% -----------------X boundary------------------------
if strncmp(tagx,'periodic',2)==1,
    bx(nx+2,:)=bx(2,:);
    by(nx+2,:)=by(2,:);
    by(1,:)=by(nx+1,:);
    bz(nx+2,:)=bz(2,:);
    bz(1,:)=bz(nx+1,:);
end

%% -------------------Y boundary---------------------
if strncmp(tagy,'conducting',2)==1,
    %% dbx/dy=0, dbz/dy=0, by is derived from Faraday's law
     bx(:,1)=bx(:,2);
     bx(:,ny+2)=bx(:,ny+1);
     bz(:,1)=bz(:,2);
     bz(:,ny+2)=bz(:,ny+1);
end

return
end
     
     
    