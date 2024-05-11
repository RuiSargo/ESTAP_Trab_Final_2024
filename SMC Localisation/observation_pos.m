function [obs_p,state_p] = observation_pos(obs,state)


globals;

[N_BEACONS,temp]=size(beacons);
if (temp ~= 2)
  error('Incorrect Size for beacon map')
end

[emp,OSIZE]=size(obs);
[temp,SSIZE]=size(state);

if (SSIZE ~= OSIZE)
  error('Unmatched state and observation dimensions')
end

obs_p=zeros(2,SSIZE);% inicialização da matriz de beacons observados, medições
state_p=zeros(2,SSIZE);% inicialização da matriz de estado x-y do robô

for delta_t=1:SSIZE % percorrendo todos os instantes de tempo
    rx = state(1,delta_t); % posição em x do robo ao longo do tempo
    ry = state(2,delta_t); % posição em y do robo ao longo do tempo
    for beacon_num=1:N_BEACONS % em cada instante, avalia-se cada beacon
        dist = obs(beacon_num,SSIZE);

        if isnan(dist)

        end

        bx = beacons(beacon_num,1);
        by = beacons(beacon_num,2);

        angle_tan = atan((by-ry)/(bx-rx)); % angulo entre robo e beacon
        true_dist = sqrt((bx-rx)^2 + (by-ry)^2); % distancia real entre robo e beacon

        angle_sin = asin((by-ry)/dist);
        








    end
end





end