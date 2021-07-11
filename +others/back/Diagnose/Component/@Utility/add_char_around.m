function s = add_char_around(str, ch)
%% writen by Liangjin Song on 20210409
%% add ch to the beging and end
%%
s=Utility.add_char_front(str, ch);
s=Utility.add_char_back(s, ch);
