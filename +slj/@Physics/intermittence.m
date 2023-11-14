function [im, pdf, mu, sigma] = intermittence(fd, dd) 
%%
% @brief: calculate the intermittence of the line of field
% @info: written by Liangjin Song on 20231113
% @param: fd -- the field, it is a line vector
% @param: dd -- the precision
% @param: mu -- the mean value
% @param: sigma -- the standard deviation
% @return: im -- the division of intervals
% @return: pdf -- the probability density function
%%

fd = fd(:);
m1 = min(fd);
m2 = max(fd);

im = linspace(m1, m2, dd);

pdf = zeros(1, length(im));
n = length(fd);

for i = 1:nd
    tmp = abs(im - fd(i));
    [~, in] = min(tmp);
    pdf(in) = pdf(in) + 1;
end

pdf = pdf / length(fd);

mu = mean(fd);
sigma = std(a);

end