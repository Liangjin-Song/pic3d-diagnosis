%% modify the lines of the data
% writen by Liangjin Song on 20200713
datdir='/data/simulation/zhong/M100B01Bg035/data';

tt=29;

varname={'Bx','By','Bz','Dense','Densi','Ex','Ey','Ez','stream','vxe','vye','vze','vxi','vyi','vzi'};

nt=length(tt);
nvar=length(varname);

for t=1:nt
    for n=1:nvar
        cd(datdir);
        strt=num2str(tt(t),'%06.2f');
        var=char(varname(n));
        data=load([var,'_t',strt,'.txt']);
        ndx=size(data,1);
        ndy=size(data,2);
        datat=zeros(ndx/2,ndy);
        for i=1:2:ndx-1
            datat((i+1)/2,:)=(data(i,:)+data(i+1,:))/2;
        end
        save([var,'_t',strt,'.mat'],'datat');
    end
end
