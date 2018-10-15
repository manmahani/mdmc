
function [RT, correct, incorrect] = SingleTrial(EX,b,sigma,t, trials_no,B, p)
%% Simulate a single trial

%   EX: Mean Activation time E(X(t))
%   b: Barrier > 0
%   sigma: Variance parameter of the process
%   dt: dt=T/N;
%   p: parameter for GeneralBeta

% Draw a starting value X(0)
% trials_no =100;

Start = GeneralBetaRand(-b,b,p,p,1, trials_no); %Random Start Value, symmetrische verteilung

% Generate Standard Wiener Prozess mit variance parameter sigma

%   B = cumsum([  zeros(trials_no), normrnd(0,dt,trials_no,length(t)-1)  ]);
% TODO: double check this B
% B = normrnd(0,dt,trials_no,length(t)-1) .*sigma;

% B = cumsum([ zeros(trials_no,1), normrnd(0,dt,trials_no,length(t)-1)  ], 2);



% Compute Non-Standard Wiener Process with E(X(t)) = EX + E(start)
X =  EX + B.*sigma + Start;


%% Check Type of Response and determine RT
correct = zeros(trials_no,1); incorrect = zeros(trials_no,1);
% slow = zeros(trials_no,1); 
RT = zeros(trials_no,1);

for i = 1:trials_no
    up = find( X(i,:) > b, 1); low = find( X(i,:) < -b, 1);
    
    if  isempty(up) == 0 && isempty(low) == 1         % correct response
        correct(i) = true;
        RT(i)=t(up);
        
    elseif isempty(up) == 1 && isempty(low) == 0      %incorrect response
        incorrect(i) = true;
        RT(i)=t(low);
        
    elseif isempty(up) == 1 && isempty(low) == 1      %too slow
%         slow(i)=true;
        RT(i)=NaN;
        
    elseif isempty(up) == 0 && isempty(low) == 0 && min(low,up) == up; %correct response, double hit
        correct(i) = true;
        RT(i)=t(up);
        
    elseif isempty(up) == 0 && isempty(low) == 0 && min(low,up) == low; %incorrect response, double hit
        incorrect(i) = true;
        RT(i)=t(low);
    end
end

function X=GeneralBetaRand(a,b,p,q,n,trials_no)
%Generates a random variable from the General Beta Distribution
% a: lower bound
% b: upper bound
% p and q are shape parameters
% n: number of drawings
X=a+(b-a)*betarnd(p,q,trials_no,n);


