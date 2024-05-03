function [xe,we]=navresample(xp,wp)
%
% HDW 25/02/2003
%
% This is a function to do resampling of a sample set xp
% accoring to the weighting vector wp. The result is a new 
% sample set xe which has a uniform weighting vector we

nw=length(wp);
xe=zeros(size(xp));


% compute normalised CDF of current weights
cdf=cumsum(wp);
cdf=cdf/cdf(nw);

% get a uniform sample of equivalent size
u=uniformrandom4(nw);

% now resample distribution
j=1;
for i=1:nw
   while cdf(j) < u(i)
      j=j+1;
   end
   xe(i,:)=xp(j,:); % I think this does the right thing
end

% the weights are all equal to 1/n this seems to be redundant
we=ones(size(wp))/nw;
