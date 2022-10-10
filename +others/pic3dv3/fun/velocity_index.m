%% get the index of a particle in the distribution function
function [nx,ny,nz]=velocity_index(vx,vy,vz,sv)
    nsv=length(sv)-1;
    for i=1:nsv
        if(vx>sv(i) && vx <= sv(i+1))
            nx=i;
            break;
        end
    end
    for j=1:nsv
        if(vy>sv(j) && vy <= sv(j+1))
            ny=j;
            break;
        end
    end
    for k=1:nsv
        if(vz>sv(k) && vz <= sv(k+1))
            nz=k;
            break;
        end
    end
end