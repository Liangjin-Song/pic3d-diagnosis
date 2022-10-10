function q = agyrotropy(P, B, prm)
%%
% @info: writen by Liangjin Song on 20220820
% @brief: agyrotropy_fac - quantifying gyrotropy in the simulation system
% @param: P -- pressure directly from the simulation
% @param: B -- the magnetic field directly from simulation
% @param: prm -- the Parameters
% @output: q -- from Swisdak 2016, Appendix A
%%
I1 = P.xx + P.yy + P.zz;
I2 = P.xx .* P.yy + P.xx .* P.zz + P.yy .* P.zz - (P.xy .* P.xy + P.xz .* P.xz + P.yz .* P.yz);

b = sqrt(B.x.^2 + B.y.^2 + B.z.^2);
bx = B.x./b;
by = B.y./b;
bz = B.z./b;

para = bx .* bx .* P.xx + by .* by .* P.yy + bz .* bz .* P.zz + 2 * (bx .* by .* P.xy + bx .* bz .* P.xz + by .* bz .* P.yz);

q = sqrt(1 - (4 * I2) ./ ((I1 - para) .* (I1 + 3 * para)));
end