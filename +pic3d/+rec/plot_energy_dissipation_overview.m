% function plot_energy_conversion_overview(name)
clear;
%% parameters
indir='Z:\Simulation\sym\rec1d';
outdir='E:\Asym';
prm=slj.Parameters(indir,outdir);

tt=20;

nt=length(tt);

extra=[];
extra.xlabel='';
extra.ylabel='';
extra.Visible=true;

norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
% 
% if name == 'l'
%     sfx='ih';
% elseif name == 'h'
%     sfx='ic';
% elseif name == 'e'
%     sfx = 'e';
% else
%     error('Parameters Error!');
% end



for t=1:nt
    %% read data
    E=prm.read('E',tt(t));
    J=prm.read('J',tt(t));
    V=prm.read('Ve',tt(t));
    B=prm.read('B',tt(t));
%     V=prm.read(['V',name],tt(t));
%     N=prm.read(['N',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
%     if cmpt == 't'
%         JE=E.dot(V);
%         tit = ['J',sfx,'\cdot E'];
%         stit = ['J',sfx,'_dot_E'];
%     elseif cmpt == 'x'
%         JE=slj.Scalar(V.x.*E.x);
%         tit = ['J',sfx,'xEx'];
%         stit=tit;
%     elseif cmpt == 'y'
%         JE=slj.Scalar(V.y.*E.y);
%         tit = ['J',sfx,'yEy'];
%         stit=tit;
%     elseif cmpt == 'z'
%         JE=slj.Scalar(V.z.*E.z);
%         tit = ['J',sfx,'zEz'];
%         stit=tit;
%     else
%         error('unknown components!');
%     end
%     JE=JE*N;
%     if name == 'e'
%         JE=slj.Scalar(-JE.value);
%     end
    JE = V.cross(B);
    E = E + JE;
    JE = J.dot(E);
    f=figure('Visible', extra.Visible);
    slj.Plot.overview(JE, ss, prm.value.lx, prm.value.lz, norm, extra);
%     ylim([-10,10]);
    % title(['J\cdot E,  \Omega_{ci}t = ',num2str(tt(t))]);
    title('J\cdot (E + Ve \times B)');
    cd(outdir);
     print('-dpng','-r300',['J.Ed_t',num2str(tt(t), '%06.2f'),'.png']);
%      close(gcf);
end