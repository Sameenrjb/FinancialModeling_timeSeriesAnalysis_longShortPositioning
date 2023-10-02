function [P,Q] = BoxMueller(hs1,hs2)
% This function generates normal variates using the
% Box-Mueller algorithm.
%
% Inputs: 2 normal sequences (i.e. those generated
%         by a Halton sequence generator)

% Author: Phil Goddard
% Date: Q1 2007

R = sqrt(-2*log(hs1));
Theta = 2*pi*hs2;
P = R.*sin(Theta);
Q = R.*cos(Theta);