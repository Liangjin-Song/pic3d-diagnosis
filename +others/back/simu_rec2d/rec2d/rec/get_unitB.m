function nb=get_unitB(bx,by,bz,Lx,Ly,dr,x0,y0)
% this program is used to get unit vector of magnetic field in the given 
% location in simulation box with unit normalized
%%
%%---------------------written by M.Zhou, Oct,2010------------------------
xx=0:dr:Lx-dr;
yy=0:dr:Ly-dr;
%%
b0x=interp2(xx,yy,bx,x0,y0);
b0y=interp2(xx,yy,by,x0,y0);
b0z=interp2(xx,yy,bz,x0,y0);
b0=[b0x,b0y,b0z];
nb=b0/sqrt(dot(b0,b0));
