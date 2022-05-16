function ix = RF_Position(prm, t, range)
%%
% @info: written by Liangjin Song on 20220516 at  Nanchang University
% @brief: obtain the index of RF position
% @param: prm -- the parameters structure
% @param: t -- the time step
% @param: range -- the range that contains the RF
% @return: ix -- the index of the RF positoin
%%
%% read data
b = prm.read('B', t);

%% obtain the Bz line
lbz = b.get_line2d(0, 0, prm, 1);
lbz = lbz.lz(range(1):range(2));

%% the index of the RF
[~, ix] = max(abs(lbz));
ix = ix + range(1) - 1;
end