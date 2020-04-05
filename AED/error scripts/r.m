function rf=r(obsDATA, simDATA)
% PLOT model vs 

% find matching time values
[v loc_obs loc_sim] = intersect(obsDATA(:,1), simDATA(:,1));

% and create subset of data with elements= Time, Observed, Simulated
MatchedData = [v obsDATA(loc_obs,2) simDATA(loc_sim,2)];

% I'm not familiar with how MATLAB is optimized to clear it's memory,
% this next call may or may not speed things up.
clear v loc_obs loc_sim

ss = find(~isnan(MatchedData(:,1)) == 1);

if length(MatchedData(:,1)) > 3
	[r,p] = corrcoef(MatchedData(ss,1), MatchedData(ss,2));hold on;
else
    r(1:2,1:2) = NaN;
end

rf=r(2);
end
