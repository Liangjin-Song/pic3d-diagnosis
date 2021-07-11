function fd = read(obj, varargin)
%%
% @info: writen by Liangjin Song on 20210425
% @brief: read - read the simulation data of pic3d
% @param: obj - the Parameters object
% @param: varargin - the file information of simulation data
% @return: fd - the simulation data
%%
cd(obj.indir);
if nargin == 2
    fd = obj.read_vector(obj.value, varargin{1});
elseif nargin == 3
    fd = obj.read_field(obj.value, varargin{1}, varargin{2});
else
    error('Parameters error!');
end
end
