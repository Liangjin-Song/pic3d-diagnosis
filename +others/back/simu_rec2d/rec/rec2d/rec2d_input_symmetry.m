function parameter=rec2d_input_symmetry
%%
%%
global s0 s1 s2
%% input the parameters for the simulation
nx=128;
ny=64;
npt=nx*ny*40; %number of particles per species
tlast=25;  % the final time of the simulation, normalized by the ion gyro-period
%%
di=10;   % ion inertial length
w0=0.5*di;  %half width of current sheet
c=0.6;   %speed of light

mr=25;   %mass ratio
tie=5;   %temperature between ions and electrons
fr=3;    %frequency ratio between wpe and wce
nbh=0.2; % the density ratio between Harris sheet and background
%%
b0=1; %asymptotic magnetic field
bg=0.0; %guide field strength
psi0=0.1; % initial flux perturbation
sm=0.5;  %smoothing coefficient
%% some deduced parameters 
vte=c/fr/sqrt(2*(1+tie));  %thermal speed vth, m*vth^2=Te.
vti=vte*sqrt(tie/mr);
bratio=nbh*ny/(nbh*ny+2*w0);
n0=npt*(1-bratio)/nx/2/w0;
me=fr^2*b0^2/n0;
mi=me*mr;
de=di/sqrt(mr);
wpe=c/de;
wce=wpe/fr;
wpi=c/di;
wci=wce/mr;
%%
qi=wci*mi/b0;
qe=-qi;
debye=vte/wpe;
rhoi=vti/wci;
rhoe=vte/wce;
va=b0/sqrt(n0*mi);
vdi=2*vti^2/wci/w0;  % cross-tail ion drift speed
vde=vdi/tie;   % cross-tail electron drift speed
%%
% coeff=npt/nx/sum(ni);
%% the diagnosis parameters
tfield=0:100;
tplasma=0:100;
tenergy=0:100;
%%
s0=1/(1+2*sm)^2;   %smoothing coefficient
s1=4*sm/(1+2*sm)^2;
s2=4*sm^2/(1+2*sm)^2;
%%
parameter=struct('nx',nx,'ny',ny,'npt',npt,'tlast',tlast,'lightspeed',c,'di',di,'w0',w0,...
    'massratio',mr,'tie',tie,'fr',fr,'b0',b0,'bg',bg,'n0',n0,'nbh',nbh,'bratio',bratio,...
    'wci',wci,'wpi',wpi,'wce',wce,'mi',mi,'me',me,'qi',qi,'qe',qe,'vti',vti,'vte',vte,...
    'vdi',vdi,'vde',vde,'rhoi',rhoi,'rhoe',rhoe,'debye',debye,'alfvenspeed',va,...
    'psi0',psi0, 'tfield',tfield,'tplasma',tplasma,'tenergy',tenergy,'sm',sm);

return
end



