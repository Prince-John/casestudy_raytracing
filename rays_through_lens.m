function rays_out = rays_through_lens(rays, f)

    Mf = [1 0 0 0;-1/f 1 0 0;0 0 1 0;0 0 -1/f 1];
    rays_out = Mf*rays;

end