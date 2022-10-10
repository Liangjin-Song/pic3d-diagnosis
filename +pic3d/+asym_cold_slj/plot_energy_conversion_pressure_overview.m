%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot the density flux as the function of time
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt = 48;
name='h';
cmpt = 'o';

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

if name == 'l'
    sfx='ih';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.tlm;
elseif name == 'h'
    sfx='ic';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.thm;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.tem;
else
    error('Parameters Error!');
end

norm=tm*prm.value.n0*prm.value.vA/prm.value.di;
nt = length(tt);
%% the loop
for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    V=prm.read(['V',name],tt(t));
    ss=prm.read('stream',tt(t));
    %% calculation
    divPV=P.divergence(prm);
    divPVx= slj.Scalar(divPV.x.*V.x);
    divPVy= slj.Scalar(divPV.y.*V.y);
    divPVz= slj.Scalar(divPV.z.*V.z);
    divPV = slj.Scalar(divPV.x.*V.x + divPV.y.*V.y + divPV.z.*V.z);
    
    if cmpt == 'x'
        fd = divPVx;
    elseif cmpt == 'y'
        fd = divPVy;
    elseif cmpt == 'z'
        fd = divPVz;
    else
        fd = divPV;
        cmpt = '';
    end
    
    f=figure;
    slj.Plot.overview(fd.value/norm, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['[(\nabla\cdot P)\cdot V]_', cmpt, ',  \Omega_{ci}t = ',num2str(tt(t))]);
    cd(outdir);
    
end

cd(outdir);
% print('-dpng','-r300',[sfx,'_energy_conversion_pressure_t',num2str(tt),'.png']);