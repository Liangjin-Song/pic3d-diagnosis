function R = gyroradius(q, m, T, B)
%%
% @info: writen by Liangjin Song on 20211201 at Nanchang University
% @brief: calculate the Larmor radius of one species polulation
% @param: q - the charge of the species
% @param: m - the mass of the species
% @param: T - the temperature of the species, which is a Scalar 
% @param: B - the magnetic field, which is a Vector
% @return: R - the Larmor radius distribution of the species, 
%            which is a Scalar
%%
%% mass to charge ratio
mq=abs(m/q);

%% thermal velocity
V = sqrt(T.value./m);

%% the strength of the magnetic field
BB=B.sqrt();

%% the gyroradius
R=mq.*V./BB.value;
R=slj.Scalar(R);
end