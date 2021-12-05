%% This function returns a 4xN ray vector after propogating given rays by d distance in meters. 
function rays = rays_propogate_d(rays, d)

Md = [1 d 0 0;0 1 0 0;0 0 1 d;0 0 0 1];
rays = Md*rays;


end