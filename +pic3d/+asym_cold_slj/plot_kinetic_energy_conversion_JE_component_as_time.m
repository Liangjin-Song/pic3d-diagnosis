%%
% written by Liangjin Song on 20220523 at Nanchang University
% plot the J dot E and its components in a box
%%
clear;
%{
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

norm = 1;


nt=length(tt);
rate1=zeros(4,nt);
rate2=zeros(3,nt);


for t=1:nt
    %% read parameters
    N=prm.read(['N',name],tt(t));
    V=prm.read(['V',name],tt(t));
    E=prm.read('E', tt(t));
    B=prm.read('B', tt(t));

    %% the sum, J.E
    qVE = slj.Scalar(q.*N.value.*(V.x.*E.x + V.y.*E.y + V.z.*E.z));

    %% in the simulation frame
    qVEx = slj.Scalar(q.*N.value.*V.x.*E.x);
    qVEy = slj.Scalar(q.*N.value.*V.y.*E.y);
    qVEz = slj.Scalar(q.*N.value.*V.z.*E.z);

    %% in the fac frame
    [vpara, vperp] = V.fac_vector(B);
    [epara, eperp] = E.fac_vector(B);
    qVEpara = slj.Scalar(q.*N.value.*(vpara.x.*epara.x + vpara.y.*epara.y + vpara.z.*epara.z));
    qVEperp = slj.Scalar(q.*N.value.*(vperp.x.*eperp.x + vperp.y.*eperp.y + vperp.z.*eperp.z));

    %%
    rate1(1,t)=sum(qVE.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate1(2,t)=sum(qVEx.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate1(3,t)=sum(qVEy.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate1(4,t)=sum(qVEz.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    %%
    rate2(1,t)=rate1(1,t);
    rate2(2,t)=sum(qVEpara.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
    rate2(3,t)=sum(qVEperp.value(zindex(1):zindex(2),xindex(1):xindex(2)),'all');
end

rate1 = rate1/norm;
rate2 = rate2/norm;

%% simulation frame
f1=figure;
plot(tt, rate1(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate1(2,:), '-r', 'LineWidth', 2);
plot(tt, rate1(3,:), '-g', 'LineWidth', 2);
plot(tt, rate1(4,:), '-b', 'LineWidth', 2);
hold off

legend('J\cdot E', 'JxEx', 'JyEy', 'JzEz', 'Location', 'Best');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel(['J',sfx,'\cdot E']);
set(gca,'FontSize',14);

%% fac frame
f2=figure;
plot(tt, rate2(1,:), '-k', 'LineWidth', 2); hold on
plot(tt, rate2(2,:), '-r', 'LineWidth', 2);
plot(tt, rate2(3,:), '-b', 'LineWidth', 2);
hold off

legend('J\cdot E', 'J_{||}E_{||}', 'J_\perp E_\perp', 'Location', 'Best');
xlim(xrange);
xlabel('\Omega_{ci} t');
ylabel(['J',sfx,'\cdot E']);
set(gca,'FontSize',14);

cd(outdir);
print(f1,'-dpng','-r300',[sfx,'_JE_simulation_frame_as_time_dt=',num2str(dt),'.png']);
print(f2,'-dpng','-r300',[sfx,'_JE_fac_frame_as_time_dt=',num2str(dt),'.png']);