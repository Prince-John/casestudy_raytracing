%% Using Lenses to create images

% This is build off of the part 1 script and uses the same concepts and
% assumptions. 


% Defining the lens matrix to experiment for later parts the lens will be
% abstracted away as a function.

f = 0.1; % test f in meters, abitrary choice right now. 
Mf = [1 0 0 0;-1/f 1 0 0;0 0 1 0;0 0 -1/f 1];
rays_at_d0 = generate_1d_rays('x', 0.01, 0.02, 5);

% From the handout the ratio of d1, d2, and f must be according to this
% equation $\frac{1}{d_1} + \frac{1}{d_2} = \frac{1}{f}$. So, 1/f - 1/d1 =
% 1/d2; d2 = (d1xf)/(d1 - f)

% choosing d1 same as part one = 0.05

d1 = 0.2;
d2 = ((d1*f)/(d1-f))*1.1;

rays_at_d1 = rays_propogate_d(rays_at_d0, d1);
rays_after_d1 = Mf*rays_at_d1;
rays_at_d2 = rays_propogate_d(rays_after_d1, d2);

% Ploting this on a xz plane.
figure()
rays_in = rays_at_d0;
rays_out= rays_at_d1;
hold on;
ray_z1 = [zeros(1,size(rays_in,2)); d1*ones(1,size(rays_in,2))];
plot(ray_z1, [rays_in(1,:); rays_out(1,:)]);
rays_in = rays_after_d1;
rays_out= rays_at_d2;
ray_z2 = [d1*ones(1,size(rays_in,2)); (d1+d2)*ones(1,size(rays_in,2))];
plot(ray_z2, [rays_in(1,:); rays_out(1,:)]);
hold off;
ylim([-0.05, 0.1])
xlabel('z (m)');
ylabel('x (m)');

%% b adding a third origin
new_origin = generate_1d_rays('x', 0.0, 1, 5);
new_origin = new_origin(:,1:5);
rays_at_d0 = [new_origin rays_at_d0];
rays_at_d1 = rays_propogate_d(rays_at_d0, d1);
rays_after_d1 = Mf*rays_at_d1;
rays_at_d2 = rays_propogate_d(rays_after_d1, d2);

% Ploting this on a xz plane.
figure()
rays_in = rays_at_d0;
rays_out= rays_at_d1;
hold on;
ray_z1 = [zeros(1,size(rays_in,2)); d1*ones(1,size(rays_in,2))];
plot(ray_z1, [rays_in(1,:); rays_out(1,:)]);
rays_in = rays_after_d1;
rays_out= rays_at_d2;
ray_z2 = [d1*ones(1,size(rays_in,2)); (d1+d2)*ones(1,size(rays_in,2))];
plot(ray_z2, [rays_in(1,:); rays_out(1,:)]);
hold off;
ylim([-0.05, 0.1])
xlabel('z (m)');
ylabel('x (m)');

%% c Altering f and d2 to explore magnification.

% Testing f values from 0.01 m to 0.8 m

f_values = linspace(0.1, 0.3, 6);
d2_values = ((d1*f_values)./(d1-f_values))*1.1;


for i = 1:length(f_values)

figure()
rays_in = rays_at_d0;
rays_out= rays_at_d1;
hold on;
ray_z1 = [zeros(1,size(rays_in,2)); d1*ones(1,size(rays_in,2))];
plot(ray_z1, [rays_in(1,:); rays_out(1,:)]);

rays_after_d1 = rays_through_lens(rays_at_d1, f_values(i));
rays_at_d2 = rays_propogate_d(rays_after_d1, d2_values(i));
rays_in = rays_after_d1;
rays_out= rays_at_d2;
ray_z2 = [d1*ones(1,size(rays_in,2)); (d1+d2_values(i))*ones(1,size(rays_in,2))];
plot(ray_z2, [rays_in(1,:); rays_out(1,:)]);
hold off;
ylim([-0.01, 0.1])
xlabel('z (m)');
ylabel('x (m)');
title("F = "+num2str(f_values(i)), 'Fontsize', 16);
end

% The position of the plane of focus d2 gets larger with an increase in
% focal length untill the focal length equal d1 when the d2 goes to
% infinity. after that focal plane of the goes behind the lens. This
% behavior is present in concave lenses and might be a numeric artifcat of
% the way we are computing rays through the lens. 

% The seperation between the image points gets larger with increase in f
% with constant d1. If we define the size as distance b/w the two of the
% furthest points in a plane then the magnification will be size of the 
% image/size of object.
%%

f_values = linspace(0.1, 0.3, 500);
d2_values = ((d1*f_values)./(d1-f_values));
mag = zeros(1, length(f_values));
for i = 1:length(f_values)
rays_after_d1 = rays_through_lens(rays_at_d1, f_values(i));
rays_at_d2 = rays_propogate_d(rays_after_d1, d2_values(i));
mag(i) = max(abs(rays_at_d2(1,:)))/max(abs(rays_at_d0(1,:)));
end

figure()
plot(f_values, mag);
xlabel('Focus (m)', 'Fontsize', 16);
ylabel('Magnification', 'Fontsize', 16);


% c) the equation would not hold up 

%% Design a system
d1 = 0.5;
[f_experiment, d2_experiment] = optical_system(d1);

function [f_values, d2_values] = optical_system(d1)
    rays_at_d0 = load('lightField.mat').rays;

    % From the handout the ratio of d1, d2, and f must be according to this
    % equation $\frac{1}{d_1} + \frac{1}{d_2} = \frac{1}{f}$. So, 1/f - 1/d1 =
    % 1/d2; d2 = (d1xf)/(d1 - f)

    % choosing d1 same as part one = 0.05
    f_values = linspace(0.3, 0.6, 6);
    d2_values = ((d1*f_values)./(d1-f_values))*1.1;
    for i =1:length(f_values)
        Mf = [1 0 0 0;-1/f_values(i) 1 0 0;0 0 1 0;0 0 -1/f_values(i) 1];
        rays_at_d1 = rays_propogate_d(rays_at_d0, d1);
        rays_after_d1 = Mf*rays_at_d1;
        rays_at_d2 = rays_propogate_d(rays_after_d1, d2_values(i));
        [img, x_edges, y_edges] = rays2img(rays_at_d2(1,:),rays_at_d2(3,:),0.035, 480);
        figure;
        colormap(gray)
        image(x_edges([1 end]),y_edges([1 end]),img); 
        axis image xy;
        niqeI = brisque(rays_at_d2,rays_at_d0);
        fprintf('NIQE score for original image is %0.4f.\n',niqeI)
    end

end
