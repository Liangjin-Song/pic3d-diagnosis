function rec2d_bfield
%%
%% advance magnetic field using Maxwell equation
global bx by bz ex ey ez parameter

c=parameter.lightspeed;
nx=parameter.nx;
ny=parameter.ny;
%%
 bx(2:nx+1,2:ny+1)=bx(2:nx+1,2:ny+1)-0.5*c*(ez(2:nx+1,3:ny+2)-ez(2:nx+1,2:ny+1));
 by(2:nx+1,2:ny+2)=by(2:nx+1,2:ny+2)+0.5*c*(ez(3:nx+2,2:ny+2)-ez(2:nx+1,2:ny+2));
 bz(2:nx+1,2:ny+1)=bz(2:nx+1,2:ny+1)+0.5*c*(ex(2:nx+1,3:ny+2)-ex(2:nx+1,2:ny+1)...
                    -ey(3:nx+2,2:ny+1)+ey(2:nx+1,2:ny+1));
  %%
