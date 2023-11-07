%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot the density flux as the function of time
%%
clear;
%% parameters
indir='Y:\turbulence5.55';
outdir='C:\Users\Liangjin\Pictures\Turbulence\Energy';
prm=slj.Parameters(indir,outdir);

tt = 50;
name='e';
cmpt = 'o';

extra=[];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='Z [c/\omega_{pi}]';

if name == 'i'
    sfx='i';
    q=prm.value.qi;
    m=prm.value.mi;
    tm=prm.value.te*prm.value.tie;
elseif name == 'e'
    sfx = 'e';
    q=prm.value.qe;
    m=prm.value.me;
    tm=prm.value.te;
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
    B=prm.read('B', tt(t));
    ss=slj.Physics.stream2d(B.x, B.z);
    %% calculation
    divPV=P.divergence(prm);
    divPVx= slj.Scalar(divPV.x.*V.x);
    divPVy= slj.Scalar(divPV.y.*V.y);
    divPVz= slj.Scalar(divPV.z.*V.z);
    divPV = slj.Scalar(divPV.x.*V.x + divPV.y.*V.y + divPV.z.*V.z);
    
    f=figure;
    slj.Plot.overview(divPV.value, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['[(\nabla\cdot P)\cdot V]_', name, ',  \Omega_{ci}t = ',num2str(tt(t))]);
    cd(outdir);
    
end

cd(outdir);
% print('-dpng','-r300',[sfx,'_energy_conversion_pressure_t',num2str(tt),'.png']);