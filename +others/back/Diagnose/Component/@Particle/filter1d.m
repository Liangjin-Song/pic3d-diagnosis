function fd=filter1d(fd)
%% writen by Liangjin Song on 20210412
%% filter the field
n=5;
for i=1:n
    f=fd;
    nl=length(fd);
    for j=2:nl-1
        fd(j)=f(j)*0.5+f(j-1)*0.25+f(j+1)*0.25;
    end
end

