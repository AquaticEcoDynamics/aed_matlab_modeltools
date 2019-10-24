clear all; close all;

matdir = 'J:\Matfiles_All\run_2016_2017_rerun_ALL\';

vars = {'TEMP';'SAL';'WQ_OXY_OXY';'WQ_NIT_AMM';};

outputdates = [datenum(2016,01,01,12,000,00),...
    datenum(2016,02,01,12,000,00),...
    datenum(2016,07,01,12,000,00),...
    datenum(2016,08,01,12,000,00)];

factors = [1 1 32/1000 14/1000];
for i = 1:length(vars)
    disp(vars{i});
    load([matdir,vars{i},'.mat']);
    
    for j = 1:length(outputdates)
        [~,ind] = min(abs(savedata.Time - outputdates(j)));
        
        if abs(savedata.Time(ind) - outputdates(j)) < 1
            
            outdata.(vars{i}).Top(:,j) = savedata.(vars{i}).Top(:,ind) .* factors(i);
            outdata.(vars{i}).Bot(:,j) = savedata.(vars{i}).Top(:,ind) .* factors(i);
            
        else
            stop
    
    
        end
    end

    clear savedata;
end

convert_2dm_to_shp('Grid.2dm','2016SurfaceData.shp',...
    'TEMP010116',double(outdata.TEMP.Top(:,1)),...
    'TEMP010216',double(outdata.TEMP.Top(:,2)),...
    'TEMP010716',double(outdata.TEMP.Top(:,3)),...
    'TEMP010816',double(outdata.TEMP.Top(:,4)),...
    'SAL010116',double(outdata.SAL.Top(:,1)),...
    'SAL010216',double(outdata.SAL.Top(:,2)),...
    'SAL010716',double(outdata.SAL.Top(:,3)),...
    'SAL010816',double(outdata.SAL.Top(:,4)),...
    'OXY010116',double(outdata.WQ_OXY_OXY.Top(:,1)),...
    'OXY010216',double(outdata.WQ_OXY_OXY.Top(:,2)),...
    'OXY010716',double(outdata.WQ_OXY_OXY.Top(:,3)),...
    'OXY010816',double(outdata.WQ_OXY_OXY.Top(:,4)),...
    'AMM010116',double(outdata.WQ_NIT_AMM.Top(:,1)),...
    'AMM010216',double(outdata.WQ_NIT_AMM.Top(:,2)),...
    'AMM010716',double(outdata.WQ_NIT_AMM.Top(:,3)),...
    'AMM010816',double(outdata.WQ_NIT_AMM.Top(:,4)));

convert_2dm_to_shp('Grid.2dm','2016BottomData.shp',...
    'TEMP010116',double(outdata.TEMP.Bot(:,1)),...
    'TEMP010216',double(outdata.TEMP.Bot(:,2)),...
    'TEMP010716',double(outdata.TEMP.Bot(:,3)),...
    'TEMP010816',double(outdata.TEMP.Bot(:,4)),...
    'SAL010116',double(outdata.SAL.Bot(:,1)),...
    'SAL010216',double(outdata.SAL.Bot(:,2)),...
    'SAL010716',double(outdata.SAL.Bot(:,3)),...
    'SAL010816',double(outdata.SAL.Bot(:,4)),...
    'OXY010116',double(outdata.WQ_OXY_OXY.Bot(:,1)),...
    'OXY010216',double(outdata.WQ_OXY_OXY.Bot(:,2)),...
    'OXY010716',double(outdata.WQ_OXY_OXY.Bot(:,3)),...
    'OXY010816',double(outdata.WQ_OXY_OXY.Bot(:,4)),...
    'AMM010116',double(outdata.WQ_NIT_AMM.Bot(:,1)),...
    'AMM010216',double(outdata.WQ_NIT_AMM.Bot(:,2)),...
    'AMM010716',double(outdata.WQ_NIT_AMM.Bot(:,3)),...
    'AMM010816',double(outdata.WQ_NIT_AMM.Bot(:,4)));

    