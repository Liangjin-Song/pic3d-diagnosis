%% save the data to vtk file
clear;
%% parameters
indir = 'E:\';
outdir = 'E:\';
prm = slj.Parameters(indir, outdir);

name = 'J';
tt = 25;

%% load data
fd = prm.read(name, tt);

%% save to hdf5
cd(outdir);

%% creat hdf5 file
file = [name, '_t', num2str(tt, '%06.2f'), '.h5'];
ds = ['/', name];
h5create(file, ds, size(fd.x));
h5write(file, ds, fd.x);