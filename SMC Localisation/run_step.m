num=300;
for i=num:num+10
   x=xtrack(:,:,num);
   dt=utrue(3,num)-utrue(3,num-1);
   x=vmodel(x,utrue(:,i),dt,0); % this propagates particals
   if obs(3,num)~= 0 % only resample when you have an observation
      w=omodel(x,obs(:,num),beacons); % this computes weights from sample z
      x=navresample(x,w); % this resamples
   end
end
