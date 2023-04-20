% function plot_energy_conversion_overview(name)
clear;
%% parameters
indir='E:\Asym\case1\data';
outdir='C:\Users\Liangjin\Pictures\Asym\case1\Overview';
prm=slj.Parameters(indir,outdir);

tt=0:100;
name='e';
cmpt = 't';

nt=length(tt);

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';
extra.Visible=false;

norm=prm.value.nis*prm.value.vA*prm.value.vA;

if name == 'i'
    sfx='i';
elseif name == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end



for t=1:nt
    %% read data
    E=prm.read('E',tt(t));
    V=prm.read(['V',name],tt(t));
    N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    if cmpt == 't'
        JE=E.dot(V);
        tit = ['J',sfx,'\cdot E'];
        stit = ['J',sfx,'_dot_E'];
    elseif cmpt == 'x'
        JE=slj.Scalar(V.x.*E.x);
        tit = ['J',sfx,'xEx'];
        stit=tit;
    elseif cmpt == 'y'
        JE=slj.Scalar(V.y.*E.y);
        tit = ['J',sfx,'yEy'];
        stit=tit;
    elseif cmpt == 'z'
        JE=slj.Scalar(V.z.*E.z);
        tit = ['J',sfx,'zEz'];
        stit=tit;
    else
        error('unknown components!');
    end
    JE=JE*N;
    if name == 'e'
        JE=slj.Scalar(-JE.value);
    end
    f=figure('Visible', extra.Visible);
    slj.Plot.overview(JE, ss, prm.value.lx, prm.value.lz, norm, extra);
    ylim([-10,10]);
    title([tit,',  \Omega_{ci}t = ',num2str(tt(t))]);
    cd(outdir);
    print(f,'-dpng','-r300',[stit,'_t',num2str(tt(t)),'.png']);
    close(gcf);
end