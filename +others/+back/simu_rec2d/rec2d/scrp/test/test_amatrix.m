axx=[1 2 3; 4 3 8];
axy=[2 3 8; 8 3 2];
axz=[2 3 8; 8 8 2];
ayy=[1 2 8; 9 8 10];
ayz=[0 3 2; 8 9 2];
azz=[9 7 5; 1 3 9];

delt=axx.*ayy.*azz+axy.*ayz.*axz+axz.*axy.*ayz-axx.*ayz.*ayz-axy.*axy.*azz-axz.*ayy.*axz

cxx=(ayy.*azz-ayz.*ayz)./delt;
cxy=-(axy.*azz-ayz.*axz)./delt;
cxz=(axy.*ayz-ayy.*axz)./delt;
% cyx=-(axy.*azz-axz.*ayz)./delt;
cyy=(axx.*azz-axz.*axz)./delt;
cyz=-(axx.*ayz-axy.*axz)./delt;
% czx=(axy.*ayz-axz.*ayy)./delt;
% czy=-(axx.*ayz-axz.*axy)./delt;
czz=(axx.*ayy-axy.*axy)./delt;

bxx=axx.*cxx+axy.*cxy+axz.*cxz
bxy=axx.*cxy+axy.*cyy+axz.*cyz


%{
delt=axx*ayy*azz+axy*ayz*axz+axz*axy*ayz-axx*ayz*ayz-axy*axy*azz-axz*ayy*axz

cxx=(ayy*azz-ayz*ayz)/delt;
cxy=-(axy*azz-ayz*axz)/delt;
cxz=(axy*ayz-ayy*axz)/delt;
cyx=-(axy*azz-axz*ayz)/delt;
cyy=(axx*azz-axz*axz)/delt;
cyz=-(axx*ayz-axy*axz)/delt;
czx=(axy*ayz-axz*ayy)/delt;
czy=-(axx*ayz-axz*axy)/delt;
czz=(axx*ayy-axy*axy)/delt;

A=[axx axy axz; axy ayy ayz; axz ayz azz]
C=[cxx cxy cxz; cyx cyy cyz; czx czy czz];
B=C'
A*B
%}
