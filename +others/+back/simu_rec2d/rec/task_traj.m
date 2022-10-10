%%
id=6452619;
vv=find(pts(:,1)==id);
part=pts(vv,:);

%%
ss=load('stream_t014.00.txt');
plot_stream(ss,25.6,25.6,1);
hold on
plot_traj(part,0.05,25.6,25.6,0.008,1,20)

%%
plot_tpart_multi(part,{'bx','z','x','vpara','vperp','kappa'},[0.6,20,20,0.04,0.04],0.008,1,20);