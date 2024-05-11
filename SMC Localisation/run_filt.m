globals;
ginit;
IXERR=1;
IYERR=1;
IPHIERR=0.1;
IRERR=0.1;
NUM_P=1000;

xinit=zeros(NUM_P,4);

disp('Press return to run filter');
pause;

randn('state',sum(100*clock));

% initialise filter
xinit(:,1)=xtrue(1,1)+IXERR*(randn(NUM_P,1)-0.5); % previsao inicial da posicao em x
xinit(:,2)=xtrue(2,1)+IYERR*(randn(NUM_P,1)-0.5);
xinit(:,3)=xtrue(3,1)+IPHIERR*(randn(NUM_P,1)-0.5);
xinit(:,4)=WHEEL_RADIUS+IRERR*(randn(NUM_P,1)-0.5);

% initialise weights
winit=ones(NUM_P,1)/NUM_P;

%run filter     
[xtrack,wtrack]=pfilter(obs,utrue,xinit,winit,beacons);

disp('Completed Filtering')
     
        