function [xtrack,wtrack] = pfilter2(obs,u,xinit,winit,beacons)

%
% HDW 27/02/2003
% partical filter for beacon-based navigation
% each row n of obs contains a range to the nth beacon, except the last
% which is for time

% each row of u contains omega gamma and time

% running 1000 particles
% xinit is expected to be a matrix of dimension num_particles x 4


globals;

% Começar a adaptar a partir daqui!!!!!

[num_beacons,N_OBS]=size(obs); % N_OBS = numero de time frames


[temp,N_U]=size(u);
if temp ~= 3
  error('control input vector of dimension 3 expected')
end
if N_U ~= N_OBS
  error('control and observation sequences of different length')
end

[num_particulas,xsize]=size(xinit);
if xsize~= 5
  error('xinit expected to have four columns')
end

% make some space
xtrack=zeros(num_particulas,xsize,N_OBS); % matriz 
wtrack=zeros(num_particulas,N_OBS);


% x is a matrix of dimension numsamps x 4

% need to cater for the initial location
x=xinit;
w=winit;
xtrack(:,:,1)=xinit; % preencher primeira obs com X init
wtrack(:,1)=winit;   % semelhante a cima

% Loop for each time. Note first observation is not used
time=u(3,1); % começa com time frame inicial ( 0s )
for i=2:N_OBS
   counter = 0;
   
   dt=u(3,i)-time; % diferença de tempo entre iterações, 0.1s
   time=u(3,i);
   
   % first propagate particles
   x=vmodel(x,u(:,i),dt,0); % propagar particulas de acordo c modelo de movimento
   
   % if an observation occurs at this time, recompute weights
   % parte de atualizar a likelyhood
   for ith_beacon=1:num_beacons-1 % de 1 até aos beacon max
       if ~isnan(obs(ith_beacon,i)) % se exister medição de range 
           % recomputar pesos      
           counter = counter + 1;

           w= w + omodel(x,w,obs(ith_beacon,i),beacons,ith_beacon);
       end
   end

   % if obs(3,i) ~= 0 				
   %    w=omodel(x,w,obs(:,i),beacons); 
   % end
   
   % compute effetive number of particles
   Neff=1/sum(w.*w); 	
   rho=Neff/num_particulas;
   
   % test for resampling
   if rho < 0.5 	
      [x,w]=navresample(x,w); % this resamples
   end
   
   % finally record values
   xtrack(:,:,i)=x; 
   wtrack(:,i)=w;
end

