function plot_stream2d(fd, prm, varargin)
%% writen by Liangjin Song on 20210409
%% plot stream
%%
if nargin == 3
    number=varargin{1};
else
    number=40;
end
contour(prm.value.lx,prm.value.lz,fd,number,'k');
xlabel('X [c/\omega_{pi}]');
ylabel('Z [c/\omega_{pi}]');
xlim([0,prm.value.Lx]);
ylim([-prm.value.Lz/2, prm.value.Lz/2]);

