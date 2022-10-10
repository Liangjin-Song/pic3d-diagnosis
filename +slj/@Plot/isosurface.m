function isosurface(fd, lx, ly, lz, isovalue, extra)
%%
% @info: writen by Liangjin Song on 20210629
% @brief: plot the 3D field
% @param: fd - the array containing the field information
% @param: lx - the vector in x direction
% @param: ly - the vector in y direction
% @param: lz - the vector in z direction
% @param: isovalue - the value of the isosurface
% @param: extra - a structure containing the figure's information
%%
[~, is] = slj.Plot.get_term(extra, 'FaceColor');
if ~is
    extra.FaceColor='green';
end
[~, is] = slj.Plot.get_term(extra, 'EdgeColor');
if ~is
    extra.EdgeColor='none';
end

%%
[XX, YY, ZZ]=meshgrid(lx,ly,lz);
p=patch(isosurface(XX, YY, ZZ, fd,isovalue));
isonormals(XX,YY,ZZ,fd,p)
p.FaceColor = extra.FaceColor;
p.EdgeColor = extra.EdgeColor;
daspect([1 1 1])
view(3); 
axis tight
camlight 
lighting gouraud
%% set the figure
slj.Plot.set_field_figure(extra);
end