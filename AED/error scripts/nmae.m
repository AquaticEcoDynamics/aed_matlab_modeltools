% Error calculation:
% 1) NORMALISED MEAN ABSOLUTE ERROR (NMAE)

%        sum | Xsim - Xobs |
%  MAE = ------------------
%           N * mean(Xobs)

% Syntax:
%     [error_MAE] = mae(obsDATA, simDATA)
%
% where:
%     obsData = N x 1
%     simData = N x 1
%
%     obsData(:,1) = Observed Data
%     simData(:,1) = Simulated data
%
function [error_NMAE] = nmae(obsDATA, simDATA)

% find matching time values
[v loc_obs loc_sim] = intersect(obsDATA(:,1), simDATA(:,1));

% and create subset of data with elements= Time, Observed, Simulated
MatchedData = [v obsDATA(loc_obs,2) simDATA(loc_sim,2)];

% I'm not familiar with how MATLAB is optimized to clear it's memory,
% this next call may or may not speed things up.
clear v loc_obs loc_sim

X = MatchedData(:,2) - MatchedData(:,3);
N = length(MatchedData(:,2));

error_NMAE= sum(abs(X)) / (N*mean(MatchedData(:,2))) ;