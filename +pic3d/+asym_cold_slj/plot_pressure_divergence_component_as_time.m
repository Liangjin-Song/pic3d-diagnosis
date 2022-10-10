%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot pressure divergence components as the function of time
%%
clear;
%{
%% parameters
indir='E:\Asym\dst1v2\data';
outdir='E:\Asym\dst1v2\out\partial_t\region1';
prm=slj.Parameters(indir,outdir);

dt = 0.1;
tt=20:dt:60;
name='h';

% the box and box size
xx = [30,50];
zz = [-2,0];

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
%}
pic3d.asym_slj.energy_equation_parameters;
% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
% norm=2*dt*prm.value.wci*prm.value.n0;
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(3,nt);

dir = 'z';


for t=1:nt
    %% read data
    P=prm.read(['P',name],tt(t));
    %% calculation
    if dir == 'x'
        p1 = slj.Scalar(P.xx);
        p1 = p1.gradient(prm);
        p1 = p1.x;

        p2 = slj.Scalar(P.xz);
        p2 = p2.gradient(prm);
        p2 = p2.z;

        divP=P.divergence(prm);
        divP = divP.x;
    elseif dir == 'y'
        p1 = slj.Scalar(P.xy);
        p1 = p1.gradient(prm);
        p1 = p1.x;

        p2 = slj.Scalar(P.yz);
        p2 = p2.gradient(prm);
        p2 = p2.z;

        divP=P.divergence(prm);
        divP = divP.y;
    elseif dir == 'z'
        p1 = slj.Scalar(P.xz);
        p1 = p1.gradient(prm);
        p1 = p1.x;

        p2 = slj.Scalar(P.zz);
        p2 = p2.gradient(prm);
        p2 = p2.z;

        divP=P.divergence(prm);
        divP = divP.z;
    else
        error('Parameters Error!');
    end

    %% sum
    rate(1,t)=sum(divP(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(2,t)=sum(p1(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(3,t)=sum(p2(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end
rate0=rate;
rate = rate/norm;

%% figure
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2);
hold on
plot(tt, rate(2,:), '-r', 'LineWidth', 2);
plot(tt, rate(3,:), '-b', 'LineWidth', 2);
legend('\nabla \cdot P', '\partial_1P_{13}', '\partial_3P_{33}',  'Location', 'Best');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel(['(\nabla \cdot P)_',dir]);
set(gca,'FontSize',14);

cd(outdir);
print('-dpng','-r300',[sfx,'_pressure_divergence_',dir,'_as_time_dt=',num2str(dt),'.png']);