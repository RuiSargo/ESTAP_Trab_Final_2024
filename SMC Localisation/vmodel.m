function x=vmodel(x,u,dt,t_flag)
%
% HDW 25/02/2003
%
% Tricycle model for a partical filter.
% x(samples,states) is a bunch of particles representing the pdf on x
% u is control input u(1) is omega, u(2) is gamma, u(3) is normally time
% dt is the sample interval
% t_flag indicates that true (no noise) inputs to be used

globals;

[num_particulas,nstates]=size(x); % nsamps = num_particulas

SIGMA_K = 0.05;

% compute control inputs
% if t_flag set, then no noise on inputs
% otherwise we sample control inputs according to process model
if t_flag
   omega=u(1);
   gamma=u(2);
   radius=WHEEL_RADIUS;
else
   omega=u(1)+dt*SIGMA_W*randn(num_particulas,1); % espalha particulas pela velocidade angular
   gamma=u(2)+dt*SIGMA_S*randn(num_particulas,1); % semelhante a cima para gamma
   radius=x(:,4)+dt*SIGMA_R*randn(num_particulas,1);
   scale_factor = x(:,5)+dt*SIGMA_K*randn(num_particulas,1);
end

% compute a term that is used a lot
dV=dt.*radius.*omega;

% then the model (note old samples are over-written)
x(:,1)=x(:,1)+dV.*cos(gamma+x(:,3));
x(:,2)=x(:,2)+dV.*sin(gamma+x(:,3));
x(:,3)=x(:,3)+dV.*sin(gamma)/WHEEL_BASE;
x(:,4)=radius;
x(:,5)=scale_factor;
