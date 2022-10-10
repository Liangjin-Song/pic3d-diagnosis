function fd=read_spectrum(obj, name, time)
%% read the spectrum
% writen by Liangjin Song on 20210406
%%
fd=Spectrum();
fd.time=time;
filename=[name,'_t',num2str(time,'%06.2f'),'.bsd'];
fd.value=read_binary_file(obj,filename);
if strcmp(name, 'spctrme')
    fd.type=SpeciesType.Electron;
elseif strcmp(name, 'spctrmi')
    fd.type=SpeciesType.Ion;
elseif strcmp(name, 'spctrml')
    fd.type=SpeciesType.Ion;
elseif strcmp(name, 'spctrmh')
    fd.type=SpeciesType.Heavy_Ion;
elseif strcmp(name, 'spctrmhe')
    fd.type=SpeciesType.Electron_with_Heavy_Ion;
else
    error('Parameters error!');
end

end
