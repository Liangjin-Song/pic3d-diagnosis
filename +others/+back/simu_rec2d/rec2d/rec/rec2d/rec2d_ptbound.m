function rec2d_ptbound(tagx,tagy)
%% particle boundary condition
%%
global x y vx vy vz parameter

nx=parameter.nx;
ny=parameter.ny;
mh=floor(size(x,1)/2);
ions=parameter.ions;
lecs=parameter.lecs;
%% -------------deal with X direction first-------------------

if strncmp(tagx,'periodic',2)==1,  %periodic boundary condition
    x(1:ions)=x(1:ions)+nx.*(x(1:ions)<2.0)-nx.*(x(1:ions)>=nx+2);
    x(mh+1:mh+lecs)=x(mh+1:mh+lecs)+nx.*(x(mh+1:mh+lecs)<2.0)-nx.*(x(mh+1:mh+lecs)>=nx+2);
end
%%

%%----------------deal with Z direction-------------------------
if strncmp(tagy,'reflect',2)==1, % ideal conducting boundary condition
    y0=y-vy;
    %%  for ions
    ind=find(y(1:ions)<2.0);
    ty=(2-y0(ind))./vy(ind);
    vy(ind)=-vy(ind);
    y(ind)=2+(1-ty).*vy(ind);
    %%
    ind=find(y(1:ions)>ny+2.0);
    ty=(ny+2.-y0(ind))./vy(ind);
    vy(ind)=-vy(ind);
    y(ind)=ny+2.+(1-ty).*vy(ind);
    
    %% for electrons
    ind=find(y(mh+1:mh+lecs)<2.0);
    ty=(2-y0(mh+ind))./vy(mh+ind);
    vy(mh+ind)=-vy(mh+ind);
    y(mh+ind)=2+(1-ty).*vy(mh+ind);
    %%
    ind=find(y(mh+1:mh+lecs)>ny+2.0);
    ty=(ny+2.-y0(mh+ind))./vy(mh+ind);
    vy(mh+ind)=-vy(mh+ind);
    y(mh+ind)=ny+2.+(1-ty).*vy(mh+ind);

end
    
    
    
    
    
    
    
    
    