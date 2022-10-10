function ll = current_sheet_index(bx)
%%
% @info: writen by Liangjin Song on 20210823
% @brief: get the current sheet index in the asymmetric reconnection
% @param: bx - the magnetic field in x-direction
% @return: ll - the current sheet index in z-direction
%%
if isa(bx,'slj.Scalar')
    bx=bx.value;
elseif isa(bx, 'slj.Vector')
    bx=bx.x;
end
[~,ll]=min(abs(bx));
end
