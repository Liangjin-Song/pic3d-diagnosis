function err=check_mms_current_data(data)
%% check the current
% writen by Liangjin Song on 20200718
% 
% data is a cell array read from the text file
%
% err is the error line number, if no errors, it is empty

err=[];

% line number
nl=length(data{4});

for i=1:nl
    if data{3}(i)+data{4}(i) < 0
        err=[err,i];
    end
end

