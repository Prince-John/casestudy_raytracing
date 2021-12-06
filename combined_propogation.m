function rays_out = combined_propogation(d1, d2, f, rays)


M = [1-d2/f  d1+d2-(d1*d2)*f 0 0;
    -1/f 1-d1/f 0 0;
    0 0 1-d2/f d1+d2-(d1*d2)/f; 
    0 0 -1/f 1-d1/f];

rays_out = M*rays;

end 