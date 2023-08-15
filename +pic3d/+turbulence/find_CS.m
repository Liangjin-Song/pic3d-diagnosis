clear;
%%
% input/output directory
indir='Y:\turbulence5.55';
outdir='C:\Users\Liangjin\Pictures\Turbulence';
prm=slj.Parameters(indir,outdir);
tt=93;
extra = [];
extra.Visible=true;
extra.xrange=[prm.value.lx(1), prm.value.lx(end)];
extra.yrange=[prm.value.lz(1), prm.value.lz(end)];
% extra.xrange=[60,90];
% extra.yrange=[9,15];
extra.xlabel='X [c/\omega_{pe}]';
extra.ylabel='Z [c/\omega_{pe}]';
lx=prm.value.lx;
lz=prm.value.lz;
%% normalization
% n0=prm.value.n0;
% va=prm.value.vA;
% q=prm.value.qi;
% normJE=q*n0*va*va;
% norm=q*n0*va*va;
normv=prm.value.vA;
normJ=prm.value.qi*prm.value.n0*prm.value.vA;   
% orientation=9.5455;
%% the length of the time and the variable name
nt=length(tt);
%% global x0 y0;
for t=1:nt
      J=prm.read('J',tt(t));
%     E=prm.read('E',tt(t));
      B=prm.read('B',tt(t));
      Bq=sqrt((B.x).^2+(B.z).^2);
%     Bq1=sqrt((B.x).^2+(B.y).^2);
%     Pe=prm.read('Pe',tt(t));
%     Pi=prm.read('Pi',tt(t));
%     irf_minvar_gui(B.x);
%     E=prm.read('E',tt(t));
%     divB=prm.read('divB',tt(t));
%     divE=prm.read('divE',tt(t));     
%     Dense=prm.read('Ne',tt(t));
%     Densei=prm.read('Ni',tt(t));
%     Te=(Pe.xx+Pe.yy+Pe.zz)/3;
%     Te=slj.Scalar(Te./Dense.value);
%     Ti=(Pi.xx+Pi.yy+Pi.zz)/3;
%     Ti=slj.Scalar(Ti./Densei.value);
      
      Ve=prm.read('Ve',tt(t));
      Vi=prm.read('Vi',tt(t));
%%    
      ss=slj.Physics.stream2d(B.x,B.z); 
      [D1x,D1y]=gradient(ss);
%       L=sub2ind(size(Fx),1000,1000);
      D1=sqrt(D1x.*D1x+D1y.*D1y);
      rows = reshape(D1,prm.value.nx*prm.value.nz,1);
      B_D1=std(rows);
      [Dmx,Dmy]=find(D1<0.015*B_D1);
      
%       D_min=min(min(D1));
   
      [D2xx,D2xy]=gradient(D1x);
      [D2yx,D2yy]=gradient(D1y);
      linearind=sub2ind(size(D1),Dmx,Dmy);
      SP=D2xx(linearind).*D2yy(linearind)-D2yx(linearind).*D2xy(linearind);
      Coo_SP=find(SP<0);
      N=length(Coo_SP);
      for i = 1:N
      Coo_SPlinear(1,:)=linearind(Coo_SP(i,:),1);
      DataCoo_SPlinear(i,:)=Coo_SPlinear(1,:);
      end
      
      for i = 1:N
      hessian=[D2xx(DataCoo_SPlinear(i)),D2xy(DataCoo_SPlinear(i));D2yx(DataCoo_SPlinear(i)),D2yy(DataCoo_SPlinear(i))];  
      Eig(2,:)=eig(hessian);
      [E_vector,~] = eig(hessian);
      E_vectorL=E_vector(:);
      E_vectorA(:,i)=E_vectorL(:,1);
      
      Eigq(i,:)=Eig(2,:);
      Judge_eig(1,:)=Eigq(i,1).*Eigq(i,2);
      J_eig(i,:)=Judge_eig(1,:);
      [J_eigx,~]=find(J_eig<0);
      end  
%%
      SP_x=mod(DataCoo_SPlinear,prm.value.nx);
      SP_y=floor(DataCoo_SPlinear/prm.value.nz)+1;
      
      SPX=(SP_x-504)./4;
      SPY=(SP_y)./4;
%%
%%选择坐标画向量
      M=1;
      theta=atand(E_vectorA(4,M)/E_vectorA(3,M));
      theta2=atand(E_vectorA(2,M)/E_vectorA(1,M));
      V_x1=SPY(M,1)-15.*cosd(theta);
      V_x2=SPY(M,1)+15.*cosd(theta);
      V_y1=SPX(M,1)-15.*sind(theta);
      V_y2=SPX(M,1)+15.*sind(theta);
      
      V_x3=SPY(M,1)-15.*cosd(theta2);
      V_x4=SPY(M,1)+15.*cosd(theta2);
      V_y3=SPX(M,1)-15.*sind(theta2);
      V_y4=SPX(M,1)+15.*sind(theta2);
%%   
      TS_value=rms(J.y);
      TS_value=rms(TS_value);
      Jy=J.y;
      Jy(find(abs(Jy)<TS_value))=0;
      
      fig=slj.Plot(extra);
      fig.overview(Jy, ss, lx, lz, normJ, extra);
      colormap(jet);
      title(['Jy  \Omega_{ci}t=',num2str(tt(t))]);
      colormap(jet);
      
      
      
      hold on
      plot(SPY,SPX,'ro');   
      line([V_x1,V_x2],[V_y1,V_y2],'color','r');
      line([V_x3,V_x4],[V_y3,V_y4],'color','r');
      
      fig.png(prm, ['Jy',num2str(tt(t),'%06.2f')]);
%       fig.close();   

end

      
