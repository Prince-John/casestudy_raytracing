%% Using inverse to back propogate the rays

%Mdinv = [1 -d 0 0;0 1 0 0;0 0 1 -d;0 0 0 1];

% Since we already know from part 2 that the focal length is 0.0857135 m we can
% calculate the original d1,

d2 = 0.15;
f = 0.0857;
d1 = (f*d2)/(d2 - f);


% Then original object would be 

Md_inv = [1 -d1 0 0;0 1 0 0;0 0 1 -d1;0 0 0 1];
rays_at_d0 = load('lightField.mat').rays;
rays_original = Md_inv*rays_at_d0;
[img, x_edges, y_edges] = rays2img(rays_original(1,:),rays_original(3,:),0.005, 720);
figure;
colormap(gray)
image(x_edges([1 end]),y_edges([1 end]),img); 
axis image xy;

