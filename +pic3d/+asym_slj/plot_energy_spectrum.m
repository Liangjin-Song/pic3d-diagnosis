% function plot_energy_spectrum()
clear;
%% parameters
indir='E:\Asym\Case2\data';
outdir='E:\Asym\Case2\out\Spectrum';
prm=slj.Parameters(indir,outdir);
%% the time of the energy spectrum
tt1=0;
tt2=10;
tt3=20;
tt4=45;
tt5=60;

%% species
name='l';

if name == 'h'
    sfx='ic';
elseif name == 'l'
    sfx='ih';
elseif name == 'e'
    sfx='e';
end

%% read data
spm1=prm.read(['spctrm',name],tt1);
spm2=prm.read(['spctrm',name],tt2);
spm3=prm.read(['spctrm',name],tt3);
spm4=prm.read(['spctrm',name],tt4);
spm5=prm.read(['spctrm',name],tt5);

