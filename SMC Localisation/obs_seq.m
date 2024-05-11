function obs=obs_seq(state,beacons)


% HDW 15/12/94, modified 17/05/00
% function to gather a complete observation sequence
% inputs are

globals;

% state vector, containing x,y,phi,t (we need to add kscale here?)
[XSIZE,N_STATES]=size(state);
if XSIZE ~= 4
  error('Incorrect state dimension')
end
[N_BEACONS,temp]=size(beacons)
if (temp ~= 2)
  error('Incorrect Size for beacon map')
end

disp(N_BEACONS)
%obs=zeros(4,N_STATES);
obs=zeros(N_BEACONS+1,N_STATES);


for i=1:N_STATES
   %start_loc=state(:,i);
   %end_loc=state(:,i+1);
   %obs(:,i)=rad_sim(start_loc,end_loc,beacons);
   location = state(:,i);
   obs(:,i) = dist_beacon(location,beacons);

end
