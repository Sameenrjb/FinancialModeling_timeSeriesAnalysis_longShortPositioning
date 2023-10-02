% Script to test the solution to pricing a Chooser option using the CRR
% binomial model
clc
clear all
 
%% Option One
 
% Define input parameters
S0 = 50;
X = 50;
r = 0.05;
sig = 0.2;
T = 1;
nSteps = 12;
Tc = 8/12;
 
% Price the option
OptionValue = Chooser_Jr_Sam(S0,X,r,sig,T,nSteps,Tc);
 
% Display the price
fprintf('Price of the option is $%.4f\n',OptionValue);
 
%% Option Two
 
% Define input parameters
S0 = 100;
X = 98;
r = 0.02;
sig = 0.3;
T = 2;
nSteps = 504;
Tc = 15/12;
 
% Price the option
OptionValue = Chooser_Jr_Sam(S0,X,r,sig,T,nSteps,Tc);
 
% Display the price
fprintf('Price of the option is $%.4f\n',OptionValue);
 
%% Plot of option price versus number of time steps
 
% For the second option, plot the price for a range of nSteps
%nSteps_max = 1000;
%OptionValue = nan(1,nSteps_max);
%for nSteps = 1:nSteps_max
    %OptionValue(nSteps) = Chooser_Jr_Sam(S0,X,r,sig,T,nSteps,Tc);
%end
 
% Plot the results
%figure(1);
%plot(OptionValue);
%title('Option price as a function of number of time steps.');
%xlabel('Time steps');
%ylabel('Option Price');
%grid on;

