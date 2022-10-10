function [ppi,ppe,pn,np]=sort_mms_current_data(data)
%% categorize the data
% writen by Liangjin Song on 20200718
%
% data is a cell array read from the text file
% 
% pp represents that both Ji and Je are positive
% pn represents that Ji is positive while Je is negative
% np represents that Ji is negative while Je is positive
%

% line number
nl=length(data{4});

ppi=[];
ppe=[];
pn=[];
np=[];

for i=1:nl
    ji=data{3}(i);
    je=data{4}(i);
    if (ji>0)&&(je>0)
        if ji>je
            ppi=[ppi;ji,je];
        else
            ppe=[ppe;ji,je];
        end
    elseif (ji>0)&&(je<0)
        pn=[pn;ji,je];
    elseif (ji<0)&&(je>0)
        np=[np;ji,je];
    else
        error(['lines ',num2str(i),': both Ji and Je are negative!']);
    end
end
