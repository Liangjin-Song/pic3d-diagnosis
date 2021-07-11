%% modify the time of the file
dir='E:\PIC\wave-particle\data';
ch='*.bsd';
cd(dir);
fileFolder=fullfile(dir);
dirOutput=dir(fullfile(fileFolder,'E*'));
list={dirOutput.name}';