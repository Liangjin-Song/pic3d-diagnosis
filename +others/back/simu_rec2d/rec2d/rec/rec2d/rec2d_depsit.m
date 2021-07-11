function rec2d_depsit(x1,y1,x0,y0,q,w)
%% deposit each particle's motion current to the surrounding grid
%%
global ajx ajy ajz

%%
	i=floor(0.5*(x1+x0));
    j=floor(0.5*(y1+y0));
    dx=0.5*(x1+x0)-i;
    dy=0.5*(y1+y0)-j;
 %%   
    qx=q*(x1-x0);
    qy=q*(y1-y0);
	qz=q*w;
	delt=0.08333333*qx*(y1-y0)*w;
%%  deposit the current to the surrouding grids
	ajx(i,j+1)=ajx(i,j+1)+qx*dy;
	ajx(i,j)=ajx(i,j)+qx*(1.0-dy);
	
    ajy(i+1,j)=ajy(i+1,j)+qy*dx;
   	ajy(i,j)=ajy(i,j)+qy*(1.0-dx);
    
	ajz(i,j)=ajz(i,j)+qz*(1.0-dx)*(1.0-dy)+delt;
	ajz(i+1,j)=ajz(i+1,j)+qz*dx*(1.0-dy)-delt;
	ajz(i,j+1)=ajz(i,j+1)+qz*(1.0-dx)*dy-delt;
	ajz(i+1,j+1)=ajz(i+1,j+1)+qz*dx*dy+delt;
    
    return
end