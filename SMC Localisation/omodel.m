function w=omodel(x,w,z,beacons)
%
% HDW 25/02/2003
%
% function to compute weights from likelihood model
%

% extract useful variables
globals;

range=z(1);
bearing=z(2);
bn=z(3);
dx=beacons(bn,1)-x(:,1);
dy=beacons(bn,2)-x(:,2);

% compute normalised range and bearing error
nrange_err=(sqrt(dx.*dx + dy.*dy)-range)/SIGMA_RANGE;
nbearing_err=a_sub(a_sub(atan2(dy,dx),x(:,3)),bearing)/SIGMA_BEARING;

% compute normalised likelihood
w=w.*exp(-(nrange_err.*nrange_err + nbearing_err.*nbearing_err)/2.0);
w=w/sum(w);