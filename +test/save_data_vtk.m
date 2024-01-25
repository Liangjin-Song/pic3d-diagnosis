%% save the data to vtk file
clear;
%% parameters
indir = 'E:\Asym\cold2_ds1\data';
outdir = 'E:\';
prm = slj.Parameters(indir, outdir);

name = 'B';
tt = 28;

%% load data
fd = prm.read(name, tt);

%% save to vtk
cd(outdir);
slj.Physics.vtkwrite([name, '_t', num2str(tt, '%06.2f'), '.vtk'], 'vectors', name, fd.x, fd.y, fd.z);