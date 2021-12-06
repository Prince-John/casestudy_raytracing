%% This is our imaging system with a contrast based autofocus functionality.
% This imaging system is based on real world cameras and as such we have
% taken a few assumptions to make it easier to program. 
% We have fixed the d2(distance from lens to sensor) to 15 cm. This is an
% arbitrary choice that we did not optimize for since we are not limited by
% focal length range of an actual lens. 
% The sensor size was adjusted after getting some sharp images to 5 mm to
% crop in on the subject. 
% The pixel count was set to 720 after initial experimetation to get higher
% resolution image outputs. 
% The first internal focus finder uses a pixel count of 100 to 
% speed up computation time. 720 was also chosen because we could not
% percive any noticible improvements in quality after this but lost a lot
% of brightness. 


%https://www.mathworks.com/matlabcentral/answers/81133-how-to-calculate-contrast-per-pixel-cpp-of-an-image


function [img, max_f] = optical_system(rays_at_d0)
    
    % We are using contrast per pixel CPP as a metric to determine average
    % intensity difference of adjecent pixels.
    % To compute cpp we are using convolution like earliers matlab hw
    % exercieses. We found the mask kernel on matlab support forums, linked
    % above. 
    d2 = 0.15;
    f_values = linspace(0.01, 0.1, 100);
    contrast = zeros(length(f_values),1);

    pixels = 480;

    kernel = [-1, -1, -1, -1, 8, -1, -1, -1]/8;


    for i = 1:length(f_values)
        f = f_values(i);
        Mf = [1 0 0 0;-1/f 1 0 0;0 0 1 0;0 0 -1/f 1];
        rays_at_d1 = Mf*rays_at_d0;
        rays_at_d2 = rays_propogate_d(rays_at_d1, d2);

        [img, x_edges, y_edges] = rays2img(rays_at_d2(1,:),rays_at_d2(3,:),0.005, 100);
        diffImage = conv2(double(img), kernel, 'same');
        contrast(i) = mean2(diffImage);


    end
    f_1 = f_values(contrast == min(contrast));
    % more focused search centered around f_1
    
    lf = f_1*0.9;
    hf = f_1*1.1;
    f_values = linspace(lf, hf, 100);
    
    for i = 1:length(f_values)
        f = f_values(i);
        Mf = [1 0 0 0;-1/f 1 0 0;0 0 1 0;0 0 -1/f 1];
        rays_at_d1 = Mf*rays_at_d0;
        rays_at_d2 = rays_propogate_d(rays_at_d1, d2);

        [img, x_edges, y_edges] = rays2img(rays_at_d2(1,:),rays_at_d2(3,:),0.005, 100);
        diffImage = conv2(double(img), kernel, 'same');
        contrast(i) = mean2(diffImage);


    end
    
    max_f = f_values(contrast == min(contrast));
    
    % Rendering Higher Res image.
     f = max_f;
     Mf = [1 0 0 0;-1/f 1 0 0;0 0 1 0;0 0 -1/f 1];
     rays_at_d1 = Mf*rays_at_d0;
     rays_at_d2 = rays_propogate_d(rays_at_d1, d2);
     [img1, x_edges, y_edges] = rays2img(rays_at_d2(1,:),rays_at_d2(3,:),0.005, 720);
    
     img = img1; 
    
    
end