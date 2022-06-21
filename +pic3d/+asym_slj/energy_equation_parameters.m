%%
% written by Liangjin Song on 20220523 at Nanchang University
% the parameters of energy conversion equation
%%
%% parameters
indir = 'E:\Asym\cold2\data';
outdir = 'E:\Asym\cold2\out\Energy\Region0';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=0.1:dt:60;
name='h';

% the box and box size
xx = [prm.value.lx(1), prm.value.lx(end)];
zz = [prm.value.lz(1), prm.value.lz(end)];

xrange=[tt(1),tt(end)];
[~, a] = min(abs(prm.value.lx - xx(1)));
[~, b] = min(abs(prm.value.lx - xx(2)));
xindex = [a, b];
[~, a] = min(abs(prm.value.lz - zz(1)));
[~, b] = min(abs(prm.value.lz - zz(2)));
zindex = [a, b];


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