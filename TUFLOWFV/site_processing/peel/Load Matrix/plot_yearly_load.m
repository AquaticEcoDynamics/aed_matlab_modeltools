clear all; close all;

load load.mat;

dv = datevec(datearray);

u_years = unique(dv(:,1));

for i = 1:length(u_years)
    
    sss = find(dv(:,1) == u_years(i) & ...
        dv(:,2) > 4 & ...
        dv(:,2) < 11);
    
    wetP(i) = sum(total_P(sss))/(1000*1000);
    wetN(i) = sum(total_N(sss))/(1000*1000);
    wetML(i) = sum(ML(sss));
    
end



figure



subplot(3,1,1)
plot(u_years,wetP);hold on
plot([u_years(1) u_years(end)],[wetP(end-1) wetP(end-1)],'--k');



title('P Load (t) May - Oct');

subplot(3,1,2)
plot(u_years,wetN);hold on
plot([u_years(1) u_years(end)],[wetN(end-1) wetN(end-1)],'--k');

title('N Load (t) May - Oct');


subplot(3,1,3)
plot(u_years,wetML);hold on
plot([u_years(1) u_years(end)],[wetML(end-1) wetML(end-1)],'--k');




title('Flow (ML) May - Oct');

load daily_all.mat;


dd = datevec(daily.Dawesville_Cut.Cyano.Date);
sss = find(dd(:,1) == 2005 & ...
        dd(:,2) > 4 & ...
        dd(:,2) < 11);
    