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
pic3d.asym_cold_slj.energy_equation_parameters;
% norm=prm.value.qi*prm.value.n0*prm.value.vA*prm.value.vA;
% norm=2*dt*prm.value.wci*prm.value.n0;
norm = 1;

%% the loop
nt=length(tt);
rate=zeros(4,nt);


for t=1:nt
    %% read data
    N=prm.read(['N',name],tt(t));
    V=prm.read(['V',name],tt(t));
    E=prm.read('E', tt(t));
    %% calculation
    qVEx= slj.Scalar(q.*N.value.*V.x.*E.x);
    qVEy= slj.Scalar(q.*N.value.*V.y.*E.y);
    qVEz= slj.Scalar(q.*N.value.*V.z.*E.z);
    qVE = slj.Scalar(q.*N.value.*(V.x.*E.x + V.y.*E.y + V.z.*E.z));

    %% sum
%     rate(1,t)=sum(qVE.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
%     rate(2,t)=sum(qVEx.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
%     rate(3,t)=sum(qVEy.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
%     rate(4,t)=sum(qVEz.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate(1,t)=sum(qVE.value,'all');
    rate(2,t)=sum(qVEx.value,'all');
    rate(3,t)=sum(qVEy.value,'all');
    rate(4,t)=sum(qVEz.value,'all');
end
rate0=rate;
rate = rate/norm;

%% figure
figure;
plot(tt, rate(1,:), '-k', 'LineWidth', 2);
hold on
plot(tt, rate(2,:), '-r', 'LineWidth', 2);
plot(tt, rate(3,:), '-g', 'LineWidth', 2);
plot(tt, rate(4,:), '-b', 'LineWidth', 2);
legend('qNV\cdot E', 'qNVxEx', 'qNVyEy', 'qNVzEz', 'Location', 'Best', 'Box','off');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel(['qN_{',sfx,'}V_{',sfx,'}\cdot E']);
set(gca,'FontSize',14);

cd(outdir);
% save('electric_work.mat', 'tt', 'rate', 'dt','sfx');
print('-dpng','-r300',[sfx,'_energy_conversion_as_time_dt=',num2str(dt),'.png']);