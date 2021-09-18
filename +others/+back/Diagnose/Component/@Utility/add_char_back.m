function s = add_char_back(str, ch)
%% writen by Liangjin Song on 20210409
%% add char back the string
%%
nstr=length(str);
s=[];
for i=1:nstr
    s=[s; string([char(str(i)), ch])];
end

