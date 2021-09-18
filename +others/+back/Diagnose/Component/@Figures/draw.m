function fig = draw(prm, fd, varargin)
%% writen by Liangjin Song on 20210330
% plot figure
%%
fig=Figures();
if ~isa(prm, 'Parameters')
    error('Parameters error!');
end
if nargin == 3
    extra=varargin{1};
end
if isa(fd, 'Distribution')
    fig = distribution_function(fig,fd, extra.range);
elseif isa(fd, 'Field')
    if prm.value.ny==1
        if nargin == 3
            fig = field2d(fig, fd, prm, extra);
        else
            fig = field2d(fig, fd, prm);
        end
    else
        error('Parameters error!');
    end
else
    error('Parameters error!');
end
