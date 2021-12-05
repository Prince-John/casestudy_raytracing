%% Part 1 Exploring Ray Tracing. 
% Let's define the ray variables. 
% Each ray is defined as (x-pos, x-angle, y-pos, y-angle)'

% The set of N rays would be in a 4 by N vector. This one set will still
% represent all rays present at one perticular z position

% To start I will manually define 4 rays total at two different x
% locations, with different angles with respect to z. 

% Note: Theta needs to be limited between -$\pi$/20 and $\pi$/20 since we
% are assuming that tan $\theta$ = $\theta$.

rays_in = [0 0 0.01 0.01;0.04*pi -0.04*pi 0.03*pi -0.03*pi;0 0 0 0;0 0 0 0];

d = 0.05;
% propgation matrix
Md = [1 d 0 0;0 1 0 0;0 0 1 d;0 0 0 1];


% Rays after propogation

rays_out = Md*rays_in;

% Plotting the result

% rays_in is a 4 x N matrix representing the rays emitted from an object
% rays_out is a 4 x N matrix representing the rays after propagating distance d
ray_z = [zeros(1,size(rays_in,2)); d*ones(1,size(rays_in,2))];
plot(ray_z, [rays_in(1,:); rays_out(1,:)]);

% Automating the generation of rays in a plane given a set of start points
% and number of rays required per point. 

rays_in = generate_1d_rays('x', 0.00, 0.01, 5);
rays_out = Md*rays_in;
ray_z = [zeros(1,size(rays_in,2)); d*ones(1,size(rays_in,2))];
plot(ray_z, [rays_in(1,:); rays_out(1,:)]);
ylim([-0.03, 0.03])
xlabel('z (m)');
ylabel('x (m)');

%% Light filed dataset exploration
load('lightField.mat')

%Plotting using rays2img choosing sensor width to be 35mm, standard full
%frame sensor size. 

[img, x_edges, y_edges] =rays2img(rays(1,:), rays(3,:), 0.035, 480);
figure;
colormap(gray)
image(x_edges([1 end]),y_edges([1 end]),img); 
axis image xy;

% b) experimenting with different sensor widths



