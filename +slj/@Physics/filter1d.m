function ll= filter1d(ll, n)
%%
% @info: writen by Liangjin Song on 20210626
% @brief: filter1d - smooth the line
% @param: ll - the line that need to be smoothed
% @param: n - smoothing times
% @return ln - the smoothed line
%%
if nargin == 1
    n=1;
end
for i=1:n
    ll=smooth(ll);
end
end

%% ======================================================================== %%
function ln = smooth(ll)
%%
% @brief: smoothing the 1d field
% @param: ll - the line
% @return: ln - the smoothed line
%%
ln=ll;
n=length(ll);
for i=2:n-1
    ln(i)=ll(i-1)*0.25+ll(i)*0.5+ll(i+1)*0.25;
end
end
