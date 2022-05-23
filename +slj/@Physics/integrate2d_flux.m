function [top, bottom, left, right] = integrate2d_flux(flx, xrange, zrange, prm)
%%
% @info: written by Liangjin Song on 20220519 at Nanchang University
% @brief: calculate the integration of the flux vector for 2d field
% @param: flx -- the flux vector, which is a Vector
% @param: xrange, zrange -- the range of the box, the simulation plane is the x-z plane
% @param: prm - the Parameters object
% @return: top, bottom, left, right -- the line integration of the flux, pointing to the outside of the box is positive
%%
n = 1;
top = sum(flx.z(zrange(2), xrange(1):xrange(2)) .* n);
n = -1;
bottom = sum(flx.z(zrange(1), xrange(1):xrange(2)) .* n);
n = -1;
left = sum(flx.x(zrange(1):zrange(2), xrange(1)) .* n);
n = 1;
right = sum(flx.x(zrange(1):zrange(2), xrange(2)) .* n);
end