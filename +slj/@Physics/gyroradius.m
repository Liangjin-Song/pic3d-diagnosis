function R = gyroradius(q, m, V, B)
%%
% @info: writen by Liangjin Song on 20211201 at Nanchang University
% @brief: calculate the gyroradius of one species polulation
% @param: q - the charge of the species
% @param: m - the mass of the species
% @param: V - the bulk velocity of the species, which is a Vector
% @param: B - the magnetic field, which is a Vector
% @return: R - the gyroradius distribution of the species, 
%            which is a Scalar
%%
%% mass to charge ratio
mq=abs(m/q);

%% perpendicular velocity
[~, perp] = V.fac_vector(B);
perp=perp.sqrt();

%% the strength of the magnetic field
BB=B.sqrt();

%% the gyroradius
R=mq.*perp.value./BB.value;
R=slj.Scalar(R);
end