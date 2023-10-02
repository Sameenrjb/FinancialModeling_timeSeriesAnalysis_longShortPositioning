% Script to test the solution to pricing a Binary option using the Tian
% binomial model

% Author: Phil Goddard (phil@goddardconsulting.ca)
% Date: for Bus857
clc
clear all

%% Option One

% Define input parameters
S0 = 100;
X = 100;
r = 0.05;
sig = 0.2;
T = 1;
nSteps = 12;
dt = T/nSteps
% Price the option
oVal = BinaryTian(S0,X,r,sig,T,nSteps);

% Display the price
fprintf('Price of the option is $%.4f\n',oVal);

%% Option Two

% Define input parameters
S0 = 100;
X = 100;
r = 0.02;
sig = 0.3;
T = 2;
nSteps = 504;
allow_early_exercise = true;
generate_plots = true;

% Price the option
oVal = BinaryTian(S0,X,r,sig,T,nSteps,allow_early_exercise,generate_plots);

% Display the price
fprintf('Price of the option is $%.4f\n',oVal);
