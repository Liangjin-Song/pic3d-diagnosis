function field(lx, ly, fd, varargin)
%% writen by Liangjin Song on 20210330
% plot the field, fd is a Scalar
% lx ly are lines
%%
%% set the colormap
if nargin == 3
    map='parula';
else
    map=mycolormap(varargin{1});
end
%% figure
[X,Y]=meshgrid(lx,ly);
s=pcolor(X,Y,fd);
colorbar;shading flat
colormap(map);
s.FaceColor = 'interp';
end

%% ======================================================================== %%
function map=mycolormap(type)
%% writen by Liangjin Song on 20200422
% colormap, white in the middle position
%%
map0=[
0       0       143
0       0       159
0       0       175
0       0       191
0       0       207
0       0       223
0       0       239
0       0       255
0       23      255
0       46      255
0       69      255
0       93      255
0       116     255
0       139     255
0       162     255
0       185     255
0       209     255
0       232     255
0       255     255
26      255     255
51      255     255
77      255     255
102     255     255
128     255     255
153     255     255
178     255     255
204     255     255
229     255     255
255     255     255
255     255     255
255     255     255
255     255     255
255     255     255
255     255     255
255     255     232
255     255     209
255     255     185
255     255     162
255     255     139
255     255     116
255     255     93
255     255     69
255     255     46
255     255     23
255     255     0
255     232     0
255     209     0
255     185     0
255     162     0
255     139     0
255     116     0
255     93      0
255     69      0
255     46      0
255     23      0
255     0       0
239     0       0
223     0       0
207     0       0
191     0       0
175     0       0
159     0       0
143     0       0
128     0       0
];
map0=map0/255;

mycolorpoint=[[255 255 255];...
    [255 255 255];...
    [0 186 199];...
    [255 255 0];...
    [255 0 0];...
    [128 0 0]];
mycolorposition=[1 32 96 160 224 256];
mycolormap_r=interp1(mycolorposition,mycolorpoint(:,1),1:256,'linear','extrap');
mycolormap_g=interp1(mycolorposition,mycolorpoint(:,2),1:256,'linear','extrap');
mycolormap_b=interp1(mycolorposition,mycolorpoint(:,3),1:256,'linear','extrap');
mycolor=[mycolormap_r',mycolormap_g',mycolormap_b']/255;
mycolor=round(mycolor*10^4)/10^4;

if type == 0
    map=map0;
elseif type == 1
    map=mycolor;
else
    error('Parameters error!');
end
end
