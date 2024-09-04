%% figure 4, the phase space density of electrons
clear;
%%
% directory
indir='E:\Asym\cold2_ds1\data';
outdir = 'E:\Asym\cold2_ds1\out\Article\Paper6';
prm=slj.Parameters(indir,outdir);

%% time
t1=30;
t2=40;
vdir=1;

%% name
name11=['PVe_ts', num2str(t1/prm.value.wci), '_x1200-1600_y418-661_z0-1'];
name12=['PVe_ts', num2str(t1/prm.value.wci), '_x1600-2000_y418-661_z0-1'];
name21=['PVe_ts', num2str(t2/prm.value.wci), '_x1200-1600_y418-661_z0-1'];
name22=['PVe_ts', num2str(t2/prm.value.wci), '_x1600-2000_y418-661_z0-1'];

xrange=[30,50];


%%
f = figure('Position',[500,100,1200,500]);
h = slj.Plot.subplot(1,2,[0.025,0.1],[0.2,0.05],[0.1,0.05]);
fontsize=16;
extra.colormap='moon';
extra.xrange=[30,50];
extra.xlabel='X [c/\omega_{pi}]';
extra.ylabel='V_{ex} [v_A]';
extra.log = false;

%%
axes(h(1));
spc1 = prm.read(name11);
spc2 = prm.read(name12);
spcs = spc1.add(spc2);
spc = spcs.subposition([0, 50], [0, 1], [-1, -0.85]);
dst=spc.dstrv(1,vdir,prm.value.vA,prm.value.nx);
slj.Plot.field2d_suitable(dst.value, dst.ll.lr, dst.ll.lv,extra);

axes(h(2));
spc1 = prm.read(name21);
spc2 = prm.read(name22);
spcs = spc1.add(spc2);
spc = spcs.subposition([0, 50], [0, 1], [-1, -0.85]);
dst=spc.dstrv(1,vdir,prm.value.vA,prm.value.nx);
slj.Plot.field2d_suitable(dst.value, dst.ll.lr, dst.ll.lv,extra);

%%
annotation(f,'textbox',...
    [0.214166666666667 0.849000002264977 0.0887499976033966 0.0959999977350235],...
    'String',{'\Omega_{ci}t=30'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.690000000000001 0.847000002264977 0.0887499976033966 0.0959999977350235],...
    'String',{'\Omega_{ci}t=40'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.0408333333333334 0.895000001609326 0.0470833321784934 0.0739999983906746],...
    'String',{'(a)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');
annotation(f,'textbox',...
    [0.515833333333334 0.893000001609326 0.0479166654869915 0.0739999983906746],...
    'String',{'(b)'},...
    'LineStyle','none',...
    'FontSize',18,...
    'FontName','Times New Roman');

%%
cd(outdir);
print('-dpng', '-r300', 'figure4.png');