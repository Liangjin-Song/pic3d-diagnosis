function rec2d_efield
%% advance electric field using Maxwell equation
%%
global bx by bz ex ey ez ajx ajy ajz parameter

c=parameter.lightspeed;
nx=parameter.nx;
ny=parameter.ny;
%%

  ex(2:nx+1,3:ny+1)=ex(2:nx+1,3:ny+1)+c*(bz(2:nx+1,3:ny+1)-bz(2:nx+1,2:ny))...
                    -ajx(2:nx+1,3:ny+1);
  ey(2:nx+1,2:ny+1)=ey(2:nx+1,2:ny+1)+c*(bz(1:nx,2:ny+1)-bz(2:nx+1,2:ny+1))...
                    -ajy(2:nx+1,2:ny+1);
  ez(2:nx+1,3:ny+1)=ez(2:nx+1,3:ny+1)+c*(by(2:nx+1,3:ny+1)-by(1:nx,3:ny+1)...
                    -bx(2:nx+1,3:ny+1)+bx(2:nx+1,2:ny))-ajz(2:nx+1,3:ny+1);
  %%