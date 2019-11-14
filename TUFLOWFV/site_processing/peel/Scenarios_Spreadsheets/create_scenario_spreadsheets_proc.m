clear all; close all;

scenario_dir = 'Y:\Peel Final Report\Scenarios\Processed v12\';

outdir = 'Y:\Peel Final Report\Scenarios\Scenarios_Spreadsheets\';

shp = shaperead('Scenario_Zones.shp');

vars = {'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_OXY_OXY',...
    'V_x',...
    'V_y',...
    'TEMP',...
    'SAL',...
    'WQ_NIT_NIT',...
    'WQ_NIT_AMM',...
    'WQ_PHS_FRP',...
    };


scen = dir(scenario_dir);

outdata = [];

themonths(1).val = [4 6];
themonths(1).year = 2016;
themonths(1).lab = 'April_June';

themonths(2).val = [7 9];
themonths(2).year = 2016;
themonths(2).lab = 'July_Sept';


themonths(3).val = [10 12];
themonths(3).year = 2016;
themonths(3).lab = 'Oct_Dec';


themonths(4).val = [1 3];
themonths(4).year = 2017;
themonths(4).lab = 'Jan_Mar';

if ~exist(outdir,'dir')
    mkdir(outdir);
end


for i = 3:length(scen)
    
    for j = 1:length(vars)
        load([scenario_dir,scen(i).name,'/',vars{j},'.mat']);
        
        for k = 1:length(shp)
            
            site = regexprep(shp(k).Name,' ','_');
            
            inpol = inpolygon(savedata.X,savedata.Y,shp(k).X,shp(k).Y);
            disp(['<< ',scen(i).name,' ',vars{j},' ',site]);
            for l = 1:length(themonths)
                
                
                
                theday = eomday(themonths(l).year,themonths(l).val(2));
                
                sss = find(savedata.Time >= datenum(themonths(l).year,themonths(l).val(1),01,00,00,00) & ...
                    savedata.Time <= datenum(themonths(l).year,themonths(l).val(2),theday,23,59,59));
                
                
                outdata.(scen(i).name).(vars{j}).(site).(themonths(l).lab).Top = savedata.(vars{j}).Top(inpol,sss);
                outdata.(scen(i).name).(vars{j}).(site).(themonths(l).lab).Bot = savedata.(vars{j}).Bot(inpol,sss);
                outdata.(scen(i).name).(vars{j}).(site).(themonths(l).lab).Area = savedata.Area(inpol);
                outdata.(scen(i).name).(vars{j}).(site).(themonths(l).lab).Time = savedata.Time(sss);
            end

        end

    end
    
    save([outdir,scen(i).name,'.mat'],'outdata','-mat','-v7.3');
    clear outdata;
end
