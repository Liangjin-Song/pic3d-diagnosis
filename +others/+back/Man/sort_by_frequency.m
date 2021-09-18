function s=sort_by_frequency(data1,data2)
%% sort by frequency
% writen by Liangjin Song on 20200718
% 
% s1 (0,0.5]
% s2 (0.5,0.67]
% s3 (0.67,1]
% s4 (1,1.5]
% s5 (1.5,2]
% s6 (2,nan)
%

rate=data1./data2;

s1=0;s2=0;s3=0;s4=0;s5=0;s6=0;

nl=length(rate);
for i=1:nl
    val=rate(i);
    if val<=0.5
        s1=s1+1;
    elseif (val>0.5)&&(val<=0.67)
        s2=s2+1;
    elseif (val>0.67)&&(val<=1)
        s3=s3+1;
    elseif (val>1)&&(val<=1.5)
        s4=s4+1;
    elseif (val>1.5)&&(val<=2)
        s5=s5+1;
    else
        s6=s6+1;
    end
end
s=[s1,s2,s3,s4,s5,s6];
