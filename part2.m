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

