function iPIC_plot_vector(vx,vy,xx,yy,kav,extras)
%calculate the vector in a compressed manner and then plot
%
%---------------written by M.Zhou----------------------------------
%%--------------modified by M Zhou On Jul-10-2013-------------------
%%--------------modified by M Zhou On Oct-04-2015--------------------
if isfield(extras,'fig')==1,  fig=extras.fig;
else fig=1; end
%%
if isfield(extras,'xlb')==1,  xlb=extras.xlb;
else xlb='X(R_{E})'; end
%%
if isfield(extras,'ylb')==1,  ylb=extras.ylb;
else ylb='Y(R_{E})'; end
%%
if isfield(extras,'timetitle')==1, timetitle=extras.timetitle;
else timetitle='';  end
%%
if isfield(extras,'xrev')==1,  xrev=extras.xrev;
else xrev=1; end
%%
if isfield(extras,'yrev')==1, yrev=extras.yrev;
else yrev=0; end
%%
if isfield(extras,'color')==1, color=extras.color;
else color='w'; end
%%
if isfield(extras,'scale')==1, scale=extras.scale;
else scale=1; end

%%
ndx=size(vx,2);
ndy=size(vx,1);
nx=ndx/kav;ny=ndy/kav;
vxt=zeros(ny,nx);
vyt=zeros(ny,nx);
xxt=zeros(nx,1);
yyt=zeros(ny,1);
%obtain the compressed vx and vy
for i=1:nx
    xxt(i)=xx((i-1)*kav+floor(kav/2));
end
for j=1:ny
    yyt(j)=yy((j-1)*kav+floor(kav/2));
end
%%
for j=1:ny
   for i=1:nx
    for id1=0:kav-1
       for id2=0:kav-1
        vxt(j,i)=vxt(j,i)+vx(j*kav-id1,i*kav-id2);
        vyt(j,i)=vyt(j,i)+vy(j*kav-id1,i*kav-id2);
       end
    end
   end
end

%%
vxt=vxt./(kav*kav);
vyt=vyt./(kav*kav);
[X,Y]=meshgrid(xxt,yyt);

if fig>0, figure; end
quiver(X,Y,vxt,vyt,scale,'color',color,'linewidth',1.);
title(timetitle,'fontsize',15)
xlabel(xlb,'fontsize',15)
ylabel(ylb,'fontsize',15)
if isfield(extras,'xrange')==1, xlim(extras.xrange); end
if isfield(extras, 'yrange')==1, ylim(extras.yrange); end
%%
axis on
set(gca,'fontsize',14,'DataAspectRatio',[1 1 1],'PlotBoxAspectRatio',[1 1 1],...
    'Xminortick','on','Yminortick','on','tickdir','out')
if xrev>0, 
    set(gca,'xdir','reverse');
end
if yrev>0,
    set(gca,'ydir','reverse');
end

