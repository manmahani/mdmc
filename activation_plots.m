% VALUES ARE OLD IN THIS SCRIPT
clear
close all


%% VT
AT = 6.6;
aT = 2;
tauT = 96.3;

AV = 12.1;
aV = 2;
tauV = 30;

tmax=1000;
dt=1;
t=linspace(dt,tmax,tmax/dt);
tactile_af =  @(x) AT.*exp(-x./tauT).*(t.*exp(1)./((aT-1).*tauT)).^(aT-1);
visual_af =  @(x) AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1);

visual = visual_af(t);
tactile = tactile_af(t);

figure
subplot(2,2,1);
plot(visual, 'b', 'LineWidth' ,3);
hold on;
plot(tactile, 'r', 'LineWidth' ,3);
axis ([0 500 0 25 ])
title ('Visual-Tactile MDMC')
%% VT-FN
clear 
AT = 8.1;
aT = 2;
tauT = 24.3;

AV = 21.6;
aV = 2;
tauV = 36.6;

tmax=1000;
dt=1;
t=linspace(dt,tmax,tmax/dt);
tactile_af =  @(x) AT.*exp(-x./tauT).*(t.*exp(1)./((aT-1).*tauT)).^(aT-1);
visual_af =  @(x) AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1);

visual = visual_af(t);
tactile = tactile_af(t);
subplot(2,2,3);
plot(visual, 'b', 'LineWidth' ,3);
hold on;
plot(tactile, 'r', 'LineWidth' ,3);
axis ([0 500 0 25 ])
title('Visual-Tactile FN-MDMC')

%% VA
clear 
AT = 9.5;
aT = 2;
tauT = 84.5;

AV = 17.4;
aV = 2;
tauV = 23.9;

tmax=1000;
dt=1;
t=linspace(dt,tmax,tmax/dt);
tactile_af =  @(x) AT.*exp(-x./tauT).*(t.*exp(1)./((aT-1).*tauT)).^(aT-1);
visual_af =  @(x) AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1);

visual = visual_af(t);
tactile = tactile_af(t);
subplot(2,2,2);
plot(visual, 'b', 'LineWidth' ,3);
hold on;
plot(tactile, 'r', 'LineWidth' ,3);
axis ([0 500 0 25 ])
title('Visual-Auditory MDMC')

%% VA-FN
clear 
AT = 11.2;
aT = 2;
tauT = 17.7;

AV = 16.5;
aV = 2;
tauV = 41.8;

tmax=1000;
dt=1;
t=linspace(dt,tmax,tmax/dt);
tactile_af =  @(x) AT.*exp(-x./tauT).*(t.*exp(1)./((aT-1).*tauT)).^(aT-1);
visual_af =  @(x) AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1);

visual = visual_af(t);
tactile = tactile_af(t);
subplot(2,2,4);
plot(visual, 'b', 'LineWidth' ,3);
hold on;
plot(tactile, 'r', 'LineWidth' ,3);
axis ([0 500 0 25 ])
title('Visual-Auditory FN-MDMC')