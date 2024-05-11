function [obs_coluna] = dist_beacon(location,beacons)

globals;

k_scale = 0.95; % fator de escala
% The beacon map consists of an array of x,y locations
% for the beacons 
[N_BEACONS,temp]=size(beacons);
if (temp ~= 2)
  error('Incorrect Size for beacon map')
end

obs_coluna=zeros(N_BEACONS+1,1);

beacon=1;
x_robot = location(1);
y_robot = location(2);
range = R_MAX_RANGE;

for i=1:N_BEACONS
    x_beacon = beacons(i,1);
    y_beacon = beacons(i,2);

    distance = sqrt( (x_beacon-x_robot)^2 + (y_beacon - y_robot)^2 );
    if(distance <= range)
        obs_coluna(beacon,:) = distance * k_scale;
    else
        obs_coluna(beacon,:) = NaN;
    end
    beacon = beacon + 1;
end

obs_coluna(N_BEACONS+1,:) = location(4);
