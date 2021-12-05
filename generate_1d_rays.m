%% This function generates equally spaced n rays per point in either xz or yz plane. 

function rays = generate_1d_rays(plane, point1, point2, n)


rays = zeros(4, 2*n);
    if(plane == 'x')
        plane = 1;
    else
        plane = 3; 
    end

rays(plane, 1:n) = point1;
rays(plane, n+1:end) = point2;
rays(plane+1, 1:n) = linspace(-pi/20,pi/20,n);
rays(plane+1, n+1:end) = linspace(-pi/20,pi/20,n);


end