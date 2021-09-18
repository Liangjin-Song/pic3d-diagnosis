%% plot the trajectory of the avi
% writen by Liangjin Song on 20210505
%% parameters
indir='E:\PIC\Cold-Ions\mie100\data';
outdir='E:\PIC\Cold-Ions\mie100\out\Trajectory\avi';
di=40;
nx=4000;
ny=2000;
Lx=nx/di;
Ly=ny/di;
xrange=[0,Lx];
yrange=[-Ly/2,Ly/2];
%% read data
cd(indir);
%% get the file list of particle trajectory files
nlist=length(id);

el=zeros(nlist,1);
%% treatment for each file
for i=1:nlist
    name=num2str(id(i));
    % name=name(1:end-4);
    name=['trajh_id',name];
    % obj.trajectory_survey(name);
    prt=cold.prm.read_data(name);
    k=prt.value.k(1:3501);
    % m=max(k)/exp(1);
    % in=find(k>m,1,'first');
    % el(i)=mean(k(in:end));
    el(i)=max(k);
end
norm=cold.prm.value.tem*cold.prm.value.tle*cold.prm.value.thl/cold.prm.value.coeff;
el=el/norm;