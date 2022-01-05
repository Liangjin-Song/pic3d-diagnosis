classdef Utility
%%
% @info: writen by Liangjin Song on 20210823
% @brief: some useful tools
%%
%% ======================================================================== %%
methods (Access = public, Static)
    ll = current_sheet_index(fd);
end

%% ======================================================================== %%
%% file operation
methods (Access = public, Static)
    %% check existance of directory
    exist_directory(dir);
end

%% ======================================================================== %%
end
