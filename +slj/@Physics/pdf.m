function [im, pdf, mu, sigma] = pdf(fd, dd) 
%%
% @brief: calculate the intermittence of the line of field
% @info: written by Liangjin Song on 20231113
% @param: fd -- the field, it is a line vector
% @param: dd -- the precision
% @param: mu -- the mean value
% @param: sigma -- the standard deviation
% @return: im -- the division of intervals
% @return: pdf -- the probability density function
% @return: mu -- the mean value
% @return: sigma -- the standard deviation
%%
%% the field information
fd = fd(:);
m1 = min(fd);
m2 = max(fd);
im = linspace(m1, m2, dd);

%% obtain the probability density function
pdf = zeros(1, length(im));
[~, in] = min(abs(im - fd(:)), [], 2);
in = tabulate(in);
pdf(in(:, 1)) = in(:, 2);
n = length(fd);
pdf = pdf / n;
%% obtain the mean value and standard deviation
mu = mean(fd);
sigma = std(fd);
end