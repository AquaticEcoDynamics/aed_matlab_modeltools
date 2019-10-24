clear all; close all;

dem_file = 'Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm';
outfile = '2016_Sept.shp';

datelim = [datenum(2016,09,01) datenum(2017,01,01)];


% Oxygen

sd = load('J:\Matfiles_All\run_2016_1_BASE\WQ_OXY_OXY.mat');
md = load('J:\Matfiles_All\run_2016_BASE\WQ_OXY_OXY.mat');
gd = load('J:\Matfiles_All\run_2017\WQ_OXY_OXY.mat');


mtime = [sd.savedata.Time;md.savedata.Time;gd.savedata.Time];

oxybot = [sd.savedata.WQ_OXY_OXY.Bot,md.savedata.WQ_OXY_OXY.Bot,gd.savedata.WQ_OXY_OXY.Bot];

oxybot = oxybot * 32/1000;

sss = find(mtime >= datelim(1) & mtime < datelim(2));

oxy(1:size(oxybot,1),1) = 0;

for i = 1:size(oxybot,1)
    
    tt = find(oxybot(i,sss) < 4);
    
    if ~isempty(tt)
    
        oxy(i,1) = (length(tt)/length(sss)) * 100;
        
    end
end
 

clear sd md mtime oxybot;


% SAL

sd = load('J:\Matfiles_All\run_2016_1\SAL.mat');
md = load('J:\Matfiles_All\run_2016\SAL.mat');
gd = load('J:\Matfiles_All\run_2017\SAL.mat');

mtime = [sd.savedata.Time;md.savedata.Time;gd.savedata.Time];

salbot = [sd.savedata.SAL.Bot,md.savedata.SAL.Bot,gd.savedata.SAL.Bot];
saltop = [sd.savedata.SAL.Top,md.savedata.SAL.Top,gd.savedata.SAL.Top];
salstrat = salbot - saltop;


sss = find(mtime >= datelim(1) & mtime < datelim(2));

sal(1:size(salstrat,1),1) = 0;

for i = 1:size(salstrat,1)
    
    sal(i,1) = mean(salstrat(i,sss));
end
 

clear sd md mtime salbot saltop salstrat;




        

% TN

sd = load('J:\Matfiles_All\run_2016_1_DIAG\WQ_DIAG_TOT_TN.mat');
md = load('J:\Matfiles_All\run_2016_DIAG\WQ_DIAG_TOT_TN.mat');
gd = load('J:\Matfiles_All\run_2017_DIAG\WQ_DIAG_TOT_TN.mat');

mtime = [sd.savedata.Time;md.savedata.Time;gd.savedata.Time];

tntop = [sd.savedata.WQ_DIAG_TOT_TN.Top,md.savedata.WQ_DIAG_TOT_TN.Top,gd.savedata.WQ_DIAG_TOT_TN.Top];

tntop = tntop * 14/1000;

sss = find(mtime >= datelim(1) & mtime < datelim(2));

tn(1:size(tntop,1),1) = 0;

for i = 1:size(tntop,1)

        tn(i,1) = mean(tntop(i,sss));
        
end




clear sd md mtime tntop;

% TP

sd = load('J:\Matfiles_All\run_2016_1_DIAG\WQ_DIAG_TOT_TP.mat');
md = load('J:\Matfiles_All\run_2016_DIAG\WQ_DIAG_TOT_TP.mat');
gd = load('J:\Matfiles_All\run_2017_DIAG\WQ_DIAG_TOT_TP.mat');

mtime = [sd.savedata.Time;md.savedata.Time;gd.savedata.Time];

tptop = [sd.savedata.WQ_DIAG_TOT_TP.Top,md.savedata.WQ_DIAG_TOT_TP.Top,gd.savedata.WQ_DIAG_TOT_TP.Top];

tptop = tptop * 31/1000;

sss = find(mtime >= datelim(1) & mtime < datelim(2));

tp(1:size(tptop,1),1) = 0;

for i = 1:size(tptop,1)

        tp(i,1) = mean(tptop(i,sss));
        
end


[~,ind] = min(tn);
tn(ind) = 0;
[~,ind] = min(tp);
tp(ind) = 0;
clear sd md mtime tptop;






convert_2dm_to_shp(dem_file,outfile,'OXY',oxy,'TN',tn,'TP',tp,'SALT',sal);









