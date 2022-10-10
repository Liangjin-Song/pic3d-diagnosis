classdef Field
%% writen by Liangjin Song on 20210325
% the Scalar class, such as density
%%
properties
    name;
    time;
    value;
    norm;
    type;
end
%% ======================================================================== %%
methods (Access = public)
    function obj = Field(varargin)
        if nargin == 0
            obj.name=[];
            obj.time=[];
            obj.value=[];
            obj.norm=[];
            obj.type=[];
        elseif nargin == 1
            obj.name=[];
            obj.time=[];
            obj.norm=[];
            obj.value=varargin{1};
            obj.type=[];
        else
            error('parameters error!');
        end
    end
end

%% ======================================================================== %%
%% reload operators
methods (Access = public)
    % +
    fd = plus(lhs, rhs);
    % -
    fd = minus(lhs, rhs);
    % .*
    fd = times(lhs, rhs);
    % ./
    fd = rdivide(lsh,rhs);
    % .^
    fd = power(lhs, rhs);
    % this cross rhs
    fd = cross(obj, rhs);
end

%% ======================================================================== %%
end
