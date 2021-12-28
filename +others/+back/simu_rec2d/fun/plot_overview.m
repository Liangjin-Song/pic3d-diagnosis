function plot_overview(fd,stream,norm,Lx,Ly)
%% plot 2D figures
% writen by Liangjin Song on 20180719
%   fd is the field
%   stream is the field line
%   norm is normalization parameter
%   Lx, Ly are the size of field
%%   
plot_field(fd,Lx,Ly,norm);
color_range=caxis;
hold on
plot_stream(stream,Lx,Ly,20);
caxis(color_range);

