globals;
ginit;

IXERR=1;
IYERR=1;
IPHIERR=0.1;
IRERR=0.1;


IKERR=0.1; % valor inicial para calculo do erro de escala 

NUM_P=1000; % number of particles

xinit=zeros(NUM_P,4);

%disp('Press return to run filter');
%pause;

randn('state',sum(100*clock));

% initialise filter
xinit(:,1)=xtrue(1,1)+IXERR*(randn(NUM_P,1));
xinit(:,2)=xtrue(2,1)+IYERR*(randn(NUM_P,1));
xinit(:,3)=xtrue(3,1)+IPHIERR*(randn(NUM_P,1));
xinit(:,4)=WHEEL_RADIUS+IRERR*(randn(NUM_P,1));
xinit(:,5)=K_SCALE_FACTOR + IKERR*(randn(NUM_P,1)); 

% estamos a dar um valor de fator de escala inicial a cada particula,
% shiftado -0.5 para ver o filtro a convergir 

% cada linha do xinit é uma particula que representa a distribuição
% aleatório em torno das variaveis de estado

%winit representa o peso dado a cada particula, a sua importância


% initialise weights
winit=ones(NUM_P,1)/NUM_P;

%mean(xinit(:,4))

%run filter     
% [xtrack,wtrack]=pfilter(obs,utrue,xinit,winit,beacons);
[xtrack,wtrack]=pfilter2(obs,utrue,xinit,winit,beacons);

%disp('Completed Filtering')
     
        