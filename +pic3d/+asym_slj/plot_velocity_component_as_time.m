%%
% written by Liangjin Song on 20220520 at Nanchang University
% plot the density flux as the function of time
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

cmpt = 'z';

%% the loop
nt=length(tt);
rate=zeros(1,nt);


for t=1:nt
    V = prm.read(['V', name], tt(t));

    if cmpt == 'x'
        V = V.x;
    elseif cmpt == 'y'
        V = V.y;
    elseif cmpt == 'z'
        V = V.z;
    else
    error('parameters error!');
    end

    %% sum
    rate(t)=sum(V(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end
rate0=rate;
rate = rate/norm;

%% figure
figure;
plot(tt, rate(:), '-k', 'LineWidth', 2);
xlim(xrange);
xlabel('\Omega_{ci}t');
ylabel(['qN_{',sfx,'}E']);
set(gca,'FontSize',14);

cd(outdir);
print('-dpng','-r300',[sfx,'_velocity_as_time_dt=',num2str(dt),'.png']);
