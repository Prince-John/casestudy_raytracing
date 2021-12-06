function rays_out = combined_propogation(d1, d2, f, rays)


M = [-(d2/d1) 0 0 0;
    -1/f -(d1/d2) 0 0;
    0 0 -(d2/d1) 0; 
    0 0 -1/f -(d1/d2)];

rays_out = M*rays;

end 