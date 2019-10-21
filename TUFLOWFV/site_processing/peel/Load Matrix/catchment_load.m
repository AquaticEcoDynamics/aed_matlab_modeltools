clear all; close all;

load ldata.mat;

sites = fieldnames(ldata);

datearray = ldata.site_Harvey.Date;

for j = 1:length(datearray)
    
    N_Conc(j) = 0;
    P_Conc(j) = 0;
    ML(j) = 0;
    for i = 1:length(sites)
        N_Conc(j) = N_Conc(j) + (ldata.(sites{i}).Nit(j) + ...
            ldata.(sites{i}).Amm(j) + ...
            ldata.(sites{i}).DON(j) + ...
            ldata.(sites{i}).DONR(j) + ...
            ldata.(sites{i}).PON(j)) * 14/1000;
        P_Conc(j) = P_Conc(j) + (ldata.(sites{i}).FRP(j) + ...
            ldata.(sites{i}).FRP_ADS(j) + ...
            ldata.(sites{i}).DOP(j) + ...
            ldata.(sites{i}).DOPR(j) + ...
            ldata.(sites{i}).POP(j)) * 31/1000;
        ML(j) = ML(j) + ldata.(sites{i}).ML(j);
    end
end
            
    
total_N = ML' .* N_Conc';
total_P = ML' .* P_Conc';

plot(datearray,(total_N/(1000*1000)));datetick('x');

save load.mat datearray total_N total_P ML;