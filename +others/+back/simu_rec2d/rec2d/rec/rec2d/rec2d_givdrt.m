function rec2d_givdrt
%% derive the drift speed of ions and electrons
%%
global bx by bz
global x y bx by bz
c=parameter.lightspeed;
ions=parameter.ions;
%%
rjx=zeros(nx+3,ny+3);
rjy=zeros(nx+3,ny+3);
rjz=zeros(nx+3,ny+3);
%% compute the current density
rjx(2:nx+2,2:ny+2)=0.5*c^2*(bz(1:nx+1,2:ny+2)+bz(2:nx+2,2:ny+2)...
                   -bz(1:nx+1,1:ny+1)-bz(2:nx+2,1:ny+1));
rjy(2:nx+2,2:ny+2)=0.5*c^2*(bz(1:nx+1,2:ny+2)+bz(1:nx+1,1:ny+1)...
                   -bz(2:nx+2,2:ny+2)-bz(2:nx+2,1:ny+1));
rjz(2:nx+2,2:ny+2)=c^2*(by(2:nx+2,2:ny+2)-by(1:nx+1,2:ny+2)...
                   -bx(2:nx+2,2:ny+2)+bx(2:nx+2,1:ny+1));

%% calculate the number density 
rho=zeros(nx+3,ny+3);
for n=1:ions
%%
	i=floor(x(n));
	j=floor(y(n));
    dx=x(n)-i;
	dy=y(n)-j;
    w11=(1.-dx)*(1.-dy);
	w12=(1.-dx)*dy;
	w22=dx*dy;
	w21=dx*(1.-dy);
%%
    rho(i,j)=rho(i,j)+w11;
	rho(i+1,j)=rho(i+1,j)+w21;
	rho(i+1,j+1)=rho(i+1,j+1)+w22;
	rho(i,j+1)=rho(i,j+1)+w12;
end
c
	call addlay1e(rho,mx,my,3,my-2)
	call copylay1e(rho,mx,my,my-2,3)
	call fdadd1e(rho,mx,my,3,mx-2)
	call fdcopy1e(rho,mx,my,mx-2,3)
c      call fdcopy1e(rho,mx,my,mx-2,3)
c      call fdcopy1e(rho,mx,my,2,mx-3)
c	call filter(rho,mx,my)
c   deposit the velocity to the grid 
c      vdxmax=-1.e20
c      vdxmin=1.e20
c      vdymax=-1.e20
c      vdymin=1.e20
c      vdzmax=-1.e20
c      vdzmin=1.e20
c      rhomax=-1.e20
c	rhomin=1.e20
	do 3 j=3,my-2
      do 3 i=3,mx-2
c      rhomin=min(rhomin,rho(i,j))
c	rhomax=max(rhomax,rho(i,j))
	if(rho(i,j).le.5.) then
        vdx(i,j)=0.
        vdy(i,j)=0.
        vdz(i,j)=0.
      else
        vdx(i,j)=rjx(i,j)/rho(i,j)/qi
        vdy(i,j)=rjy(i,j)/rho(i,j)/qi
	  vdz(i,j)=rjz(i,j)/rho(i,j)/qi
        end if
c      vdxmax=max(vdxmax,vdx(i,j))
c      vdxmin=min(vdxmin,vdx(i,j))
c      vdymax=max(vdymax,vdy(i,j))
c      vdymin=min(vdymin,vdy(i,j))
c      vdzmax=max(vdzmax,vdz(i,j))
c      vdzmin=min(vdzmin,vdz(i,j))
   3  continue
c      call addlayer(vdx,vdy,vdz,mx,my,my-2,3)      
c	call fdcopy(vdx,vdy,vdz,mx,my,mx-2,3)
c      write(*, 1000) rhomin,rhomax
c1000    format(/,5x,'minimum of density = ',f10.4,
c     *         /,5x,'maximum of density = ',f10.4)
c	write(*, 2000) vdxmin,vdxmax
c2000    format(/,5x,'minimum drift speed in x for ions = ',f10.4,
c     *         /,5x,'maximum drift speed in x for ions = ',f10.4)
c        write(*, 3000) vdymin,vdymax
c3000    format(/,5x,'minimum drift speed in y for ions = ',f8.4,
c     *         /,5x,'maximum drift speed in y for ions = ',f8.4)
c        write(*, 4000) vdzmin,vdzmax
c4000     format(/,5x,'minimum drift speed in z for ions = ',f8.4,
c     *         /,5x,'maximum drift speed in z for ions = ',f8.4)
c
      do 4 n=1,npc
c     add drift velocity to harris sheet type particles
      if (itag(n).gt.0) then	
c
	i=x(n)
	j=y(n)
	i1=i+1
	j1=j+1
      dx=x(n)-i
	dy=y(n)-j
      w11=(1.-dx)*(1.-dy)
	w12=(1.-dx)*dy
	w22=dx*dy
	w21=dx*(1.-dy)
c
      uz=w(n)+vdk*(vdz(i,j)*w11+vdz(i1,j)*w21
     &         +vdz(i1,j1)*w22+vdz(i,j1)*w12)
      ux=u(n)+vdk*(vdx(i,j)*w11+vdx(i1,j)*w21
     &         +vdx(i1,j1)*w22+vdx(i,j1)*w12)
	uy=v(n)+vdk*(vdy(i,j)*w11+vdy(i1,j)*w21
     &         +vdy(i1,j1)*w22+vdy(i,j1)*w12)
      g=c/sqrt(c**2+ux**2+uy**2+uz**2)
	u(n)=ux*g
	v(n)=uy*g
	w(n)=uz*g
c
      uz=w(maxhlf+n)-(1.0-vdk)*(vdz(i,j)*w11+vdz(i1,j)*w21
     &         +vdz(i1,j1)*w22+vdz(i,j1)*w12)
      ux=u(maxhlf+n)-(1.0-vdk)*(vdx(i,j)*w11+vdx(i1,j)*w21
     &         +vdx(i1,j1)*w22+vdx(i,j1)*w12)
	uy=v(maxhlf+n)-(1.0-vdk)*(vdy(i,j)*w11+vdy(i1,j)*w21
     &         +vdy(i1,j1)*w22+vdy(i,j1)*w12)
      g=c/sqrt(c**2+ux**2+uy**2+uz**2)
	u(maxhlf+n)=ux*g
	v(maxhlf+n)=uy*g
	w(maxhlf+n)=uz*g
	endif
c
   4  continue            