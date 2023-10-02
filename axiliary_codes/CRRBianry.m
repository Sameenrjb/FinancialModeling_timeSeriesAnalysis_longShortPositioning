function [stockTree,valueTree,deltaTree,gammaTree] = ...
    CRRBianry(S0,X,r,sig,dt,steps,optionType,earlyExercise)
% Function to calculate the price of a vanilla (European or American)
% option on a non-dividend paying stock in a Black-Scholes world.
%
% Syntax:
% [stockTree,priceTree,delta,gamma] = ...
%          CRRpricing(S0,X,r,sig,dt,steps,optionType,earlyExercise)
%
% Inputs: S0 - stock price
%       : X - strike price
%       : r - risk free interest rate
%       : sig - volatility
%       : dt - size of time steps
%       : steps - number of time steps to calculate
%       : optionType - either 'CALL' or 'PUT'
%       : earlyExercise - false for European, true for American
%
% Output: stockTree - simulated potential future stock prices
%       : valueTree - option prices
%       : deltaTree - option sensitivity delta
%       : gammaTree - option sensvitivity gamma
%       For each of the outputs the columns represents a time step and the
%       row represents the possible value at that time step
%
% Notes: This code focuses on the CRR algorithm and calculation of the
%        price and sensitivities, hence it
%        - doesn't contain any error checking.
%        - doesn't try to be efficient with memory usage

% Author: Phil Goddard (phil@goddardconsulting.ca)
% Date  : For BUS857

if nargin ~= 8   %nargin is the number of inputs
    error('%s requires exactly 8 inputs.',mfilename);
end

% Calculate the CRR model parameters
a = exp(r*dt);
u = exp(sig*sqrt(dt));
d = 1/u;
p = (a-d)/(u-d);

% Loop over each node and simulate the underlying stock prices
stockTree = nan(steps+1,steps+1);
stockTree(1,1) = S0;
for idx = 2:steps+1
    stockTree(1:idx-1,idx) = stockTree(1:idx-1,idx-1)*u;
    stockTree(idx,idx) = stockTree(idx-1,idx-1)*d;
end

% Preallocate the option value output
valueTree = nan(size(stockTree));  % it means the exactly the same size of tree
% valueTree = nan(steps+1,steps+1);
% Calculate the value at expiry
% calculating the final column 
switch optionType
    case 'PUT'
         X-stockTree(1:idx,idx)> 0
                valueTree(1:idx,idx) = 1;
                
    case 'CALL'
        valueTree(:,end) = max(stockTree(:,end)-X,0);
end

% Loop backwards to get values at the earlier times
for idx = steps:-1:1 %steps here is 4, so it means from 4 to 3,2,1 and stop at 1
    valueTree(1:idx,idx) = exp(-r*dt)*(p*valueTree(1:idx,idx+1) + (1-p)*valueTree(2:idx+1,idx+1));
    % in 2 e yani 2 to the diagnol ? yani badish ?
    if earlyExercise
        switch optionType
            case 'PUT'
                if stockTree(1:idx,idx)>= X
                valueTree(1:idx,idx) = 1;
                else
                valueTree(1:idx,idx)= 0;
                end
            case 'CALL'
                valueTree(1:idx,idx) = max(stockTree(1:idx,idx)-X,valueTree(1:idx,idx));
        end
    end
end


% Delta and Gamma

deltaTree = nan(steps+1,steps+1);
gammaTree = nan(steps+1,steps+1);


% Calculate the sensitivities
if nargout > 2
    dS = diff(stockTree);  % diff gives us( second row - first row ) like S0u-S0u^3
    deltaTree = diff(valueTree)./dS;
    if nargout > 3
        gammaTree = diff(deltaTree)./dS(2:end,:); %because dif has one less row, so we start ds from2. or to n-1
    end
end