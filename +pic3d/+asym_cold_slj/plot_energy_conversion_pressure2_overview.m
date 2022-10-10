%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot the density flux as the function of time
%%
clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Test';
prm=slj.Parameters(indir,outdir);

tt = 18;
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
    gV = slj.Scalar(V.x);
    gV = gV.gradient(prm);
    PV1 = P.xx .* gV.x + P.xy .* gV.y + P.xz .* gV.z;
    gV = slj.Scalar(V.y);
    gV = gV.gradient(prm);
    PV2 = P.xy .* gV.x + P.yy .* gV.y + P.yz .* gV.z;
    gV = slj.Scalar(V.z);
    gV = gV.gradient(prm);
    PV3 = P.xz .* gV.x + P.yz .* gV.y + P.zz .* gV.z;
    PV = PV1 + PV2 + PV3;
    
    
    if cmpt == 'x'
        fd = -PV1;
    elseif cmpt == 'y'
        fd = -PV2;
    elseif cmpt == 'z'
        fd = -PV3;
    else
        fd = -PV;
        cmpt = '';
    end
    
    f=figure;
    slj.Plot.overview(fd/norm, ss, prm.value.lx, prm.value.lz, norm, extra);
    title(['-[(P\cdot\nabla)\cdot V]_', cmpt, ',  \Omega_{ci}t = ',num2str(tt(t))]);
    cd(outdir);
    
end

cd(outdir);
% print('-dpng','-r300',[sfx,'_energy_conversion_pressure_as_time.png']);