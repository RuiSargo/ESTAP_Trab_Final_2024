% plotting of basic operation

% first compute the mean trajectory

xmean=mean(squeeze(xtrack(:,1,:)));
ymean=mean(squeeze(xtrack(:,2,:)));

figure(PLAN_FIG);
hold on
plot(xmean,ymean,'b');

% now add a few samples


numsamps=length(xtrack(:,1,1));
inc=100;
numd=floor(numsamps/inc);

for i=1:numd-1
   plot(xtrack(:,1,i*inc),xtrack(:,2,i*inc),'g.')
end

hold off

