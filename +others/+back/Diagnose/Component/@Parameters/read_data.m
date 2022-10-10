function fd = read_data(obj, varargin)
%% writen by Liangjin Song on 20210325
% read the scalar data
%%
cd(obj.value.indir);
if nargin == 2
    fd=read_vector(obj,varargin{1});
elseif nargin == 3
    fd=read_field(obj, varargin{1}, varargin{2});
else
    error('Parameters error!');
end
