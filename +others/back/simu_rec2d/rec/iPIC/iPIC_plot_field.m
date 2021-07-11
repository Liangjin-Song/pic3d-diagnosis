function iPIC_plot_field(fd,xx,yy,norm,extras)
%plot the 2D field for the iPIC3D code.
%

%-----------written by M.Zhou on Oct/01/2015------------------------------
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
if isfield(extras,'varlb')==1,  varlb=extras.varlb;
else varlb='';    end
%%
if isfield(extras,'xrev')==1,  xrev=extras.xrev;
else xrev=1; end
%%
if isfield(extras,'yrev')==1, yrev=extras.yrev;
else yrev=0; end
%%   
    %
fd=fd./norm;
%plot the figure
[X,Y]=meshgrid(xx,yy);
if fig>0, figure; end

pcolor(X,Y,fd);colorbar;shading flat
if isfield(extras,'crange')==1, caxis(extras.crange); end
if isfield(extras,'xrange')==1, xlim(extras.xrange); end
if isfield(extras, 'yrange')==1, ylim(extras.yrange); end

title(timetitle,'fontsize',15)
xlabel(xlb,'fontsize',15)
ylabel(ylb,'fontsize',15)


posx=max(xx)+4.0;
posy=min(yy)+(max(yy)-min(yy))/2.;

%%
axis on
set(gca,'fontsize',14,'DataAspectRatio',[1 1 1],'PlotBoxAspectRatio',[1 1 1],...
    'Xminortick','on','Yminortick','on','tickdir','out')
if xrev>0, 
    set(gca,'xdir','reverse');
    posx=min(xx)-4.0;
end
if yrev>0,
    set(gca,'ydir','reverse');
end

text(posx,posy,varlb,'FontSize',15,'FontWeight','Bold','rotation',270,'HorizontalAlignment','center')



