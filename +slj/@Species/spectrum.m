function [fd, le] = spectrum(obj, prm, m, dir, norm, ne, log)
%%
% @brief: convert the distribution function into the energy spectrum form
% @info: written by Liangjin Song on 20211221 at Nanchang University
% @param: prm - the Parameters object
% @param: m - the mass of the current species
% @param: dir - 0 : consider the total velocity
%               1 : consider the x-direction velocity
%               2 : consider the y-direction velocity
%               3 : consider the z-direction velocity
%              12 : consider the x-y direction velocity
%              13 : consider the x-z direction velocity
%              23 : consider the y-z direction velocity
%           other : consider the total velocity
% @param: norm - the normalization of the energy, the default is 1
% @param: ne - precision, the number of energy points, default is 100
% @param: log - Logarithm or not, the default is true
% @return: fd - the energy spectrum
% @return: le - the energy range
%%
%% the precision
if nargin == 4
    norm = 1;
    ne = 100;
    log = true;
elseif nargin == 5
    ne = 100;
    log = true;
elseif nargin == 6
    log = true;
end

%% the energy
en = [];
if dir == 1
    en = 0.5 .* m .* (obj.value.vx .* obj.value.vx) .* obj.value.weight;
elseif dir == 2
    en = 0.5 .* m .* (obj.value.vy .* obj.value.vy) .* obj.value.weight;
elseif dir == 3
    en = 0.5 .* m .* (obj.value.vz .* obj.value.vz) .* obj.value.weight;
elseif dir == 12
    en = 0.5 .* m .* (obj.value.vx .* obj.value.vx + obj.value.vy .* obj.value.vy) .* obj.value.weight;
elseif dir == 13
    en = 0.5 .* m .* (obj.value.vx .* obj.value.vx + obj.value.vz .* obj.value.vz) .* obj.value.weight;
elseif dir == 23
    en = 0.5 .* m .* (obj.value.vy .* obj.value.vy + obj.value.vz .* obj.value.vz) .* obj.value.weight;
else
    c = prm.value.c;
    v2=obj.value.vx .* obj.value.vx + obj.value.vy .* obj.value.vy + obj.value.vz .* obj.value.vz;
    en = m .* c .* c .* (c./sqrt(c.*c - v2) - 1).* obj.value.weight;
end

%% 
en = en/norm;

if log
    en0 = en;
    en = log10(en);
end

a = floor(min(en));
b = ceil(max(en));
le = linspace(a, b, ne);

in = (ne-1).*(en - a)/(b - a) + 1;

%% set the spectrum
np = length(obj.value.id);
fd = zeros(1, ne);
for i = 1:np
    a = floor(in(i));
    b = ceil(in(i));
    fd(a) = fd(a) + obj.value.weight(i) * (b - in(i));
    fd(b) = fd(b) + obj.value.weight(i) * (in(i) - a);
end

if log
    fd = log10(fd);
end

end