function [obs_calc]=calc_dist_beacons(k_loc,beacons)

globals;

k_scale = 0.95;

[n_beacons,temp]=size(beacons);
obs_calc=zeros(n_beacons+1,1);

x_robot=k_loc(1);
y_robot=k_loc(2);
for i=1:n_beacons
    x_beacon=beacons(i,1);
    y_beacon=beacons(i,2);
    distance = sqrt((x_beacon-x_robot)^2+(y_beacon-y_robot)^2);
    if (distance<=R_MAX_RANGE)
        obs_calc(i) = distance * k_scale;
    else
        obs_calc(i) = NaN;
    end
    obs_calc(n_beacons+1)=k_loc(4);
end

end

