function [RTS, CTS, ICTS] = model_fn_mdmc(x, no_runs_per_itr )

%diffusion sigma 
sigma = 4;
%residual time
mu_r = x(1);
sigma_r=x(2);
%Controlled Process
b=x(3);
mu_c=x(4);
%Visual Automatic Process
AV=x(5);
aV=2;
tauV=x(6);
%Tactile Automatic Process
A_tac_aud=x(7);
a_tac_aud=2;
tau_tac_aud=x(8);
%Neutral coefficents
mu_r_NV = x(9);

init_alpha = x(10);


tmax=1000;
dt=1;
t=[0 linspace(dt,tmax,tmax/dt)];
% sigma=5;

CVCT =  @(x) mu_c.*x + AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1)  +  A_tac_aud.*exp(-x./tau_tac_aud).*(t.*exp(1)./((a_tac_aud-1).*tau_tac_aud)).^(a_tac_aud-1);
CVIT  =  @(x) mu_c.*x + AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1)   -  A_tac_aud.*exp(-x./tau_tac_aud).*(t.*exp(1)./((a_tac_aud-1).*tau_tac_aud)).^(a_tac_aud-1);
CVNT =  @(x) mu_c.*x + AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1) ;

IVCT = @(x) mu_c.*x - AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1)  +  A_tac_aud.*exp(-x./tau_tac_aud).*(t.*exp(1)./((a_tac_aud-1).*tau_tac_aud)).^(a_tac_aud-1);
IVIT = @(x) mu_c.*x - AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1)  -  A_tac_aud.*exp(-x./tau_tac_aud).*(t.*exp(1)./((a_tac_aud-1).*tau_tac_aud)).^(a_tac_aud-1);
IVNT = @(x) mu_c.*x - AV.*exp(-x./tauV).*(t.*exp(1)./((aV-1).*tauV)).^(aV-1) ;

NVCT = @(x) mu_c.*x  +  A_tac_aud.*exp(-x./tau_tac_aud).*(t.*exp(1)./((a_tac_aud-1).*tau_tac_aud)).^(a_tac_aud-1);
NVIT = @(x) mu_c.*x -  A_tac_aud.*exp(-x./tau_tac_aud).*(t.*exp(1)./((a_tac_aud-1).*tau_tac_aud)).^(a_tac_aud-1);
NVNT = @(x) mu_c.*x;


ECVCT= CVCT(t); ECVIT= CVIT(t); ECVNT= CVNT(t);

EIVCT= IVCT(t); EIVIT= IVIT(t); EIVNT= IVNT(t);

ENVCT= NVCT(t); ENVIT= NVIT(t); ENVNT= NVNT(t);

%%
%running single trials

noRuns = no_runs_per_itr;
RTS = zeros(noRuns,9);
RTS_NV = zeros(noRuns,3);
CTS = zeros(noRuns,9);
ICTS = zeros(noRuns,9);

rndn = randn(no_runs_per_itr,length(t)).*dt;
B = cumsum(rndn, 2);

[RTS(:,1), CTS(:,1), ICTS(:,1)] = SingleTrial(ECVCT,b,sigma,t, noRuns, B, init_alpha);
[RTS(:,7), CTS(:,7), ICTS(:,7)] = SingleTrial(ECVIT,b,sigma,t, noRuns, B, init_alpha);
[RTS(:,4), CTS(:,4), ICTS(:,4)] = SingleTrial(ECVNT,b,sigma,t, noRuns, B, init_alpha);

%Visual Neutral
[RTS_NV(:,1), CTS(:,2), ICTS(:,2)] = SingleTrial(ENVCT,b,sigma,t, noRuns, B, init_alpha);
[RTS_NV(:,2), CTS(:,8), ICTS(:,8)] = SingleTrial(ENVIT,b,sigma,t, noRuns, B, init_alpha);
[RTS_NV(:,3), CTS(:,5), ICTS(:,5)] = SingleTrial(ENVNT,b,sigma,t, noRuns, B, init_alpha);

%  Visual Incongruent
[RTS(:,3), CTS(:,3), ICTS(:,3)] = SingleTrial(EIVCT,b,sigma,t, noRuns, B, init_alpha);
[RTS(:,9), CTS(:,9), ICTS(:,9)] = SingleTrial(EIVIT,b,sigma,t, noRuns, B, init_alpha);
[RTS(:,6), CTS(:,6), ICTS(:,6)] = SingleTrial(EIVNT,b,sigma,t, noRuns, B, init_alpha);


%adding Residual process time
[w,h] = size(RTS);
RTS = RTS+normrnd(mu_r,sigma_r,w,h);

%adding Residual process time
[w,h] = size(RTS_NV);
RTS_NV = RTS_NV+normrnd(mu_r_NV,sigma_r,w,h);

RTS(:,2) = RTS_NV(:,1);
RTS(:,8) = RTS_NV(:,2);
RTS(:,5) = RTS_NV(:,3);


end

