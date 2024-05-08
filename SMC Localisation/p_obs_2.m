function [obs_p,state_p]=p_obs_2(obs,state,beacons)

globals;
ginit;

[emp,OSIZE]=size(obs);
[temp,SSIZE]=size(state);

[n_beacons,temp]=size(beacons);

if (SSIZE ~= OSIZE)
  error('Unmatched state and observation dimensions')
end

obs_p=zeros(2,SSIZE*n_beacons);
state_p=zeros(2,SSIZE);

numobs=0;
for t=1:SSIZE
     rx = state(1,t);
     ry = state(2,t);
     for b_index=1:n_beacons
        dist = obs(b_index, t);
        if ~(isnan(dist))
            numobs=numobs+1;
            
            bx = beacons(b_index,1);
            by = beacons(b_index,2);
            angle = atan((by-ry)/(bx-rx));
%             angle = asin((by-ry)/dist);
            
            obs_p(1,numobs)=rx+(dist*cos(angle));
            obs_p(2,numobs)=ry+(dist*sin(angle));

            state_p(1,numobs)=rx;
            state_p(2,numobs)=ry;
        end
    end
end

obs_p=obs_p(:,1:numobs);
state_p=state_p(:,1:numobs);

end

