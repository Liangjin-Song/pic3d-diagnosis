function obj = distribution_function(obj, dst, range)
%% writen by Liangjin Song on 20210330
% plot the distribution function
% integrate in the other direction
%%
obj.number=3;
obj.type=FiguresType.Distribution_Function;
obj.time=dst.time;

if dst.species == SpeciesType.Electron
    obj.name.species='e';
elseif dst.species == SpeciesType.Ion
    obj.name.species='i';
elseif dst.species == SpeciesType.Heavy_Ion
    obj.name.species='ic';
elseif dst.species == SpeciesType.Light_Ion
    obj.name.species='i';
elseif dst.species == SpeciesType.Electron_with_Heavy_Ion
    obj.name.species='ice';
else
    error('Parameters error!');
end

extra=['_x',num2str(dst.xrange.grids(1)),'-',num2str(dst.xrange.grids(2))];
extra=[extra,'_y',num2str(dst.zrange.grids(1)),'-',num2str(dst.zrange.grids(2))];
if isempty(dst.yrange)
    extra=[extra,'_z0-1'];
else
    extra=[extra,'_z',num2str(dst.yrange.grids(1)),'-',num2str(dst.yrange.grids(2))];
end
obj.name.extra=extra;

for i=1:3
    dir=i;
    eval(['obj.handle.f',num2str(i),'=figure(',num2str(i),');']);
    fve=dst.value.fun;
    lv=dst.value.lv;
    prt=dst.name;
    fve=sum(fve,dir);
    fve=reshape(fve,length(lv),length(lv))';
    %% figure
    obj.field(lv,lv, fve, 1);
    hold on
    plot([lv(1),lv(end)],[0,0],'--r','LineWidth',1);
    plot([0,0],[lv(1),lv(end)],'--r','LineWidth',1);
    hold off
    if dir==1
        xlabel([prt,'_{y} [V_A]']);
        ylabel([prt,'_{z} [V_A]']);
    elseif dir==2
        xlabel([prt,'_{x} [V_A]']);
        ylabel([prt,'_{z} [V_A]']);
    elseif dir==3
        xlabel([prt,'_{x} [V_A]']);
        ylabel([prt,'_{y} [V_A]']);
    end
    xlim([-range, range]);
    ylim([-range, range]);
    set(gca,'FontSize',14);
end
