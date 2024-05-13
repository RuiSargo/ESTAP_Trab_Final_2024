
% first compute the mean trajectory

xmean=mean(squeeze(xtrack(:,1,:))); % remover dimensões de comprimento 1 
ymean=mean(squeeze(xtrack(:,2,:)));

figure(PLAN_FIG+1)
hold on
h1=plot(xtrue(1,:),xtrue(2,:),'b');
legend('True Trajectory')
h2=plot(xmean,ymean,'r');
plot(beacons(:,1),beacons(:,2),'bo');
h3=plot(obs_p(1,:),obs_p(2,:),'rx');

% now add a few samples


numsamps=length(xtrack(1,1,:));
inc=100;
numd=floor(numsamps/inc);

for i=1:numd-1
   h4=plot(xtrack(:,1,i*inc),xtrack(:,2,i*inc),'g.');
end

legend([h1,h2,h3,h4],'True Trajectory','Mean Estimated Trajectory','Landmark Observations','Example Particles')
title('Particle Filter Localisation')
xlabel('X location (m)')
ylabel('Y location (m)')
hold off
