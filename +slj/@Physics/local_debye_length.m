function debye = local_debye_length(P, N, q, prm)
%% 
% @brief: calculate the local debye length
% @info: written by Liangjin Song on 20230215 at Nanchang University
% @param: P -- the pressure, it is a tensor
% @param: N -- the plasma density
% @param: q -- the charge
% @param: prm -- the parameters
% @return: debye -- the debye length
%% 
if isa(N, 'slj.Scalar')
    N = N.value;
end
P = (P.xx + P.yy + P.zz)./3;
T = P./N;
debye = slj.Scalar(sqrt(T./(N.*q.*q)));
end