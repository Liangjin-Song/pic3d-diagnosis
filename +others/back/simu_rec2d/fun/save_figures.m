function save_figures(var,outdir,str)
%% writen by Liangjin Song on 20180909
% save the figures
%
% var is the physical name which is a string
% exprm is the extern parameters
%%
cd(outdir);
if strcmp('Bx',var) || strcmp('By',var) || strcmp('Bz',var)
    is_exist_dir('B');
    cd('B');
    is_exist_dir(var);
    cd(var);
elseif strcmp('Ex',var) || strcmp('Ey',var) || strcmp('Ez',var)
    is_exist_dir('E');
    cd('E');
    is_exist_dir(var);
    cd(var);
elseif strcmp('vxi',var) || strcmp('vyi',var) || strcmp('vzi',var)
    is_exist_dir('v');
    cd('v');
    is_exist_dir('vi');
    cd('vi');
    is_exist_dir(var);
    cd(var);
elseif strcmp('vxe',var) || strcmp('vye',var) || strcmp('vze',var)
    is_exist_dir('v');
    cd('v');
    is_exist_dir('ve');
    cd('ve');
    is_exist_dir(var);
    cd(var);
elseif strcmp('Ne',var) || strcmp('Ni',var) || strcmp('Densi',var) || strcmp('Dense',var)
    is_exist_dir('N');
    cd('N');
    is_exist_dir(var);
    cd(var);
elseif strcmp('Ti_aver',var) || strcmp('Ti_perp',var) || strcmp('Ti_para',var) || strcmp('Ti_anis',var) || strcmp('Ti',var)
    is_exist_dir('T');
    cd('T');
    is_exist_dir('Ti');
    cd('Ti');
    if ~strcmp('Ti',var)
        is_exist_dir(var);
        cd(var);
    end
elseif strcmp('Te_aver',var) || strcmp('Te_perp',var) || strcmp('Te_para',var) || strcmp('Te_anis',var) || strcmp('Te',var)
    is_exist_dir('T');
    cd('T');
    is_exist_dir('Te');
    cd('Te');
    if ~strcmp('Te',var)
        is_exist_dir(var);
        cd(var);
    end
elseif strcmp('Jx',var) || strcmp('Jy',var) || strcmp('Jz',var) || strcmp('J_tot',var)
    is_exist_dir('J');
    cd('J');
    is_exist_dir(var);
    cd(var);
elseif strcmp('P_tot',var) || strcmp('Pi',var) || strcmp('Pe',var) || strcmp('Pb',var)
    is_exist_dir('P');
    cd('P');
    is_exist_dir(var);
    cd(var);
elseif strcmp('conversion',var) || strcmp('ion_conversion',var) || strcmp('electron_conversion',var)
    is_exist_dir('Energy');
    cd('Energy');
    is_exist_dir(var);
    cd(var);
elseif strcmp('vi',var) || strcmp('ve',var)
    is_exist_dir('v');
    cd('v');
    is_exist_dir(var);
    cd(var);
    is_exist_dir('vector');
    cd('vector');
end
print('-r300','-dpng',[var,str,'.png']);
