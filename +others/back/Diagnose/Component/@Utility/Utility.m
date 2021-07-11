classdef Utility
%% writen by Liangjin Song on 20210408
%% some useful tools
%% all the methods are static
%%
%% ======================================================================== %%
methods (Access = public)
    function obj=Utility()
    end
end

%% ======================================================================== %%
%% file operation
methods (Access = public, Static)
    %% get the file list
    list=get_file_list(ch);
    %% move files
    move_files(from, to);
    %% check existance of directory
    exist_directory(dir);
end

%% ======================================================================== %%
methods (Access = public, Static)
    %% add char at the front and back
    s = add_char_front(str, ch);
    s = add_char_back(str, ch);
    s = add_char_around(str, ch);
end

%% ======================================================================== %%
end
