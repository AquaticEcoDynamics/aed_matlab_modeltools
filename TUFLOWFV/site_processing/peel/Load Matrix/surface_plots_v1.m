clear all; close all;

load daily_all.mat;

load load.mat;

outdir = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Peel\4_Simulations\PeelHarveyCatchmentModelResults\Nectar\Surfaces\';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

loadv = datevec(datearray);
basinv = datevec(daily.Dawesville_Cut.Cyano.Date);

year_array = [1979:01:2017];

group(1).month = [1 2 3];
group(2).month = [4 5 6];
group(3).month = [7 8 9];
group(4).month = [10 11 12];


sites = fieldnames(daily);




for i = 1:length(sites)
    
    xdata = [];
    ydata = [];
    cyano = [];
    dino = [];
    wqi = [];
    
    
    inc = 1;
    
    for j = 1:length(year_array)
        
        for k = 1:length(group)
            
            for l = 1:length(group(k).month)
                
                sss = find(loadv(:,1) == year_array(j) & ...
                    loadv(:,2) == group(k).month(l));
                
                ttt = find(basinv(:,1) == year_array(j) & ...
                    basinv(:,2) == group(k).month(l));
                
                
                if ~isempty(sss) & ~isempty(ttt) & length(ttt) > 20
                    
                    xdata(inc,1) = sum(total_N(sss)) / (1000*1000);
                    ydata(inc,1) = sum(total_P(sss)) / (1000*1000);
                    cyano(inc,1) = mean(daily.(sites{i}).Cyano.Data(ttt));
                    dino(inc,1) = mean(daily.(sites{i}).Dino.Data(ttt));
                    wqi(inc,1) = mean(daily.(sites{i}).WQI.Data(ttt));
                    inc = inc + 1;
                end
            end
        end
    end
    
    [xx,yy] = meshgrid([min(xdata):0.1:max(xdata)],[min(ydata):0.1:max(ydata)]);
    
    f = scatteredInterpolant(xdata,ydata,cyano(:,1),'natural','nearest');
    g = scatteredInterpolant(xdata,ydata,dino(:,1),'natural','nearest');
    h = scatteredInterpolant(xdata,ydata,wqi(:,1),'natural','nearest');
    
    zCyano = f(xx,yy);
    zDino = g(xx,yy);
    zWQI = h(xx,yy);
    
    
    
    figure
    
    surf(xx,yy,zCyano,'edgecolor','none');
    xlabel('Total N (tonnes)');
    ylabel('Total P (tonnes)');
    zlabel('CYANO');
    title(regexprep(sites{i},'_',' '));
    
    saveas(gcf,[outdir,sites{i},'_CYANO.png']);
    
    close;
    
    figure
    
    surf(xx,yy,zDino,'edgecolor','none');
    xlabel('Total N (tonnes)');
    ylabel('Total P (tonnes)');
    zlabel('DINO');
    title(regexprep(sites{i},'_',' '));
    
    saveas(gcf,[outdir,sites{i},'_DINO.png']);
    
    close;
    
    figure
    
    surf(xx,yy,zWQI,'edgecolor','none');
    xlabel('Total N (tonnes)');
    ylabel('Total P (tonnes)');
    zlabel('WQI');
    title(regexprep(sites{i},'_',' '));
   
    saveas(gcf,[outdir,sites{i},'_WQI.png']);
    
    close;
    
    
end




