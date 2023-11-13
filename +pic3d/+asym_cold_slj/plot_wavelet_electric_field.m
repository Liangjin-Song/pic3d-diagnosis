clear;
%% parameters
indir='E:\Asym\cold2_ds1\data';
outdir='E:\Asym\cold2_ds1\out\Wave';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=20:dt:40;
name='e';
cmpt = 't';


%% the subrange
xrange = 1201:prm.value.nx;
yrange = 415:521;

nt=length(tt);

extra=[];

normJE=prm.value.nhm*prm.value.vA*prm.value.vA;
normE = prm.value.vA;

if name == 'l'
    sfx='ih';
elseif name == 'h'
    sfx='ic';
elseif name == 'e'
    sfx = 'e';
else
    error('Parameters Error!');
end

pz = zeros(nt, 1);
nx = prm.value.nx;
tJE = zeros(nt, nx);
tE = zeros(nt, nx);

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

    %% obtain the range
    rje = abs(JE.value(yrange, xrange));
    %% obtain the maximum value position
    [sje, pos] = sort(rje(:));
    [mz, mx] = ind2sub(size(rje), pos(end-5:end));
    %% the average position
    pz(t) = round(mean(mz(:)) + yrange(1) - 1);
    %% obtain the field
    tE(t, :) = E.x(pz(t), :);
    tJE(t, :) = JE.value(pz(t), :);
end

%% ============================================================= %%
% the wavelet
va=0.036;
Bl=1.17;
norm=va*Bl;
x=35;
fs=10;
[~, n]=min(abs(prm.value.lx-x));
le = tE(:, n);



cd(outdir);
figure;
cwt(le/norm, 'amor', fs);