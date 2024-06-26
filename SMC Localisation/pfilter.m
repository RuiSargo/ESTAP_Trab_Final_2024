function [xtrack,wtrack]=pfilter(obs,u,xinit,winit,beacons)

%
% HDW 27/02/2003
% partical filter for beacon-based navigation
% each row of obs contains an observation of range bearing and beacon index
% each row of u contains omega gamma and time
% obs and u should have the smae number of rows
% xinit is expected to be a matrix of dimension numsamp x 4


globals;

[temp,N_OBS]=size(obs);
if temp ~= 4
  error('observation dimension of 4 expected')
end

[temp,N_U]=size(u);
if temp ~= 3
  error('control input vector of dimension 3 expected')
end
if N_U ~= N_OBS
  error('control and observation sequences of different length')
end

[numsamps,xsize]=size(xinit);
if xsize~= 4
  error('xinit expected to have four columns')
end

% make some space
xtrack=zeros(numsamps,xsize,N_OBS);
wtrack=zeros(numsamps,N_OBS);


% x is a matrix of dimension numsamps x 4

% need to cater for the initial location
x=xinit;
w=winit;
xtrack(:,:,1)=xinit;
wtrack(:,1)=winit;

% Loop for each time. Note first observation is not used
time=u(3,1);
for i=2:N_OBS
   dt=u(3,i)-time;
   time=u(3,i);
   
   % first propagate particles
   x=vmodel(x,u(:,i),dt,0); 	
   
   % if an observation occurs at this time, recompute weights
   if obs(3,i)~= 0 				
      w=omodel(x,w,obs(:,i),beacons); 
   end
   
   % compute effetive number of particles
   Neff=1/sum(w.*w); 	
   rho=Neff/numsamps;
   
   % test for resampling
   if rho < 0.5 	
      [x,w]=navresample(x,w); % this resamples
   end
   
   % finally record values
   xtrack(:,:,i)=x; 
   wtrack(:,i)=w;
end

