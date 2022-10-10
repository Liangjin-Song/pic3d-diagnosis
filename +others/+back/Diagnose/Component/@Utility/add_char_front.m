function s = add_char_front(str, ch)
%% writen by Liangjin Song on 20210409
%% add char before the string
%%
nstr=length(str);
s=[];
for i=1:nstr
    s=[s; string([ch, char(str(i))])];
end
