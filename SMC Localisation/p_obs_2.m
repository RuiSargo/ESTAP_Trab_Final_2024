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
% state_p=zeros(2,SSIZE); Para que é que precisamos do state_p se não
% mudamos nada nele e sim, só o tamanho de colunas SSIZE para nr_obs?

nr_obs=0;
for t=1:SSIZE
     rx = state(1,t);
     ry = state(2,t);
     for b_index=1:n_beacons
        dist_obs = obs(b_index, t);
        if ~(isnan(dist_obs))
            nr_obs=nr_obs+1;
            
            bx = beacons(b_index,1);
            by = beacons(b_index,2);
            
%             angle_tan = atan((by-ry)/(bx-rx));
            dist_true = sqrt((bx-rx)^2+(by-ry)^2);
            % c atan2
%             disp(['dist=',num2str(dist), ' and true_dist=', num2str(true_dist), ' dif= ', num2str(abs(true_dist-dist)), ' and ', num2str(100*abs(true_dist-dist)/true_dist), '%'])
            angle_sin = asin((by-ry)/dist_obs);
            angle_cos = acos((bx-rx)/dist_obs);
%             disp(['angle_sin=', num2str(angle_sin), ' angle_cos=', num2str(angle_cos), ' angle_tan=', num2str(angle_tan)]);
            
            obs_p(1,nr_obs)= rx + (dist_true * cos(angle_cos));
            obs_p(2,nr_obs)= ry + (dist_true * sin(angle_sin));
            
%             state_p(1,nr_obs)=rx;
%             state_p(2,nr_obs)=ry;
        end
    end
end

obs_p=obs_p(:,1:nr_obs);
% state_p=state_p(:,1:nr_obs);
state_p = state;

end

