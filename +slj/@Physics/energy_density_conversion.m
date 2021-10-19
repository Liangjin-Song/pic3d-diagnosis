function [pTt, divQ, PddivV, pdivV, VdivT] = energy_density_conversion(prm, name, tt, dt)
%%
% Syntax: [pTt, divQ, PddivV, pdivV, VdivT] = energy_density_conversion(prm, name, tt, dt)
% @info: writen by Liangjin Song on 20211019
% @info: energy_density_conversion - energy density conversion equation
% @param: prm - the Parameters object
% @param: name - the species's name, for example, e represents electrons
% @param: tt - the time
% @param: dt - the time interval
% @return: pTt - \frac{\partial T}{\partial t}
% @return: divQ - -\frac{2}{3}\frac{1}{n}\nabla\cdot\vec{Q}
% @return: PddivV - -\frac{2}{3}\frac{1}{n}(\vec{\vec{P}}' \cdot \nabla) \cdot \vec{v}
% @return: pdivV - -\frac{2}{3}\frac{1}{n}p\nabla \cdot \vec{v}
% @return: VdivT - -\vec{v}\cdot\nabla T
% the energy density conversion equation is
%   \frac{\partial T}{\partial t} = -\frac{2}{3} \frac{\nabla \cdot \vec{Q} + (\vec{\vec{P}}' \cdot \nabla)\cdot \vec{v} - p\nabla\cdot\vec{v}}{n} - \vec{v} \cdot \nabla T
%%

%% \frac{\partial T}{\partial t}
T2 = slj.Physics.temperature(prm.read(['P',name], tt+dt), prm.read(['N',name], tt+dt));
T1 = slj.Physics.temperature(prm.read(['P',name], tt-dt), prm.read(['N',name], tt-dt));
pTt=slj.Scalar((T2.value-T1.value).*2.*dt.*prm.value.wci);

%% -\frac{2}{3}\frac{1}{n}\nabla\cdot\vec{Q}
N = prm.read(['N',name], tt);
divQ = prm.read(['qflux',name],tt);
divQ = divQ.divergence(prm); 
divQ = slj.Scalar(-2.*divQ.value./(N.value.*3));

%% -\frac{2}{3}\frac{1}{n}(\vec{\vec{P}}' \cdot \nabla) \cdot \vec{v}
end