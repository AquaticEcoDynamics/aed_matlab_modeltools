clear all; close all;

load salt_stra_months.mat;

years = {'year1970';'year1990';'year1998Open';'year2016Open'};

for i = 1:length(years)
    outfile = [years{i},'.shp'];
    
    Summer = double(mean([salt_stra_months.(years{i}).month12,...
        salt_stra_months.(years{i}).month1,...
        salt_stra_months.(years{i}).month2],2));
    Winter = double(mean([salt_stra_months.(years{i}).month6,...
        salt_stra_months.(years{i}).month7,...
        salt_stra_months.(years{i}).month8],2));
    
    Summer(end) = 0;
    Winter(end) = 0;
    
    Winter(Winter > 10) = 10;
    Summer(Summer > 2) = 2;
    Summer(Summer < 0) = 0;
    Winter(Winter < 0) = 0;
    
    
    disp(['Summer ',num2str(max(Summer)),' ',num2str(min(Summer))]);
    disp(['Winter ',num2str(max(Winter)),' ',num2str(min(Winter))]);
    
    
    convert_2dm_to_shp('peel_v12_10m_dem_05m_clip_smooth_NS.2dm',outfile,'Summer',Summer,'Winter',Winter);
    stop
end

fSummer(1:length(Summer),1) = 0;
fSummer(1:100,1) = 2;
fWinter(1:length(Winter),1) = 0;
fWinter(1:100,1) = 10;

    convert_2dm_to_shp('peel_v12_10m_dem_05m_clip_smooth_NS.2dm','Fake.shp','Summer',fSummer,'Winter',fWinter);
