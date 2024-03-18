function [ix, iz, ss] = findXline_by_Hessian(B, prm)
%%
% @info: written by Liangjin Song on 20240318 at Nanchang University
% @brief: find the x line by Hessian matrix
% @param: B -- the magnetic field
% @param: prm -- the parameters
% @return: ix, iz -- index of the x line position
%%

%% vector potential
ss = slj.Scalar(slj.Physics.stream2d(B.x, B.z));

%% in-plane magnetic field
Bip = sqrt(B.x.^2 + B.z.^2);

%% 1st and 2nd derivatives of ss
D1s = ss.gradient(prm);
D1sq = sqrt(D1s.x.^2 + D1s.z.^2);

D2sx = slj.Scalar(D1s.x);
D2sx = D2sx.gradient(prm);

D2sz = slj.Scalar(D1s.z);
D2sz = D2sz.gradient(prm);

%% find the neutral line
val = D1sq;
threshold = std(val(:)) * 0.01; % 0.0043;
[irow, icol] = find(val < threshold);

%% find the saddle points
np = length(irow);
imr = [];
for i = 1:np
    hessian = [D2sx.x(irow(i), icol(i)), D2sx.z(irow(i), icol(i)); ...
        D2sz.x(irow(i), icol(i)), D2sz.z(irow(i), icol(i))];
    if det(hessian) < 0
        imr = [imr, i];
    end
end
iz = irow(imr);
ix = icol(imr);
end