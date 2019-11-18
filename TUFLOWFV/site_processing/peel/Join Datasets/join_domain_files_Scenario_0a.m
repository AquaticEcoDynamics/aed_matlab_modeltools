clear all; close all;

basedir = 'Y:\Peel Final Report\Scenarios\Holding\run_scenario_0a_part1\';
joindir = 'Y:\Peel Final Report\Scenarios\Holding\run_scenario_0a_rerun\';
joindir2 = 'Y:\Peel Final Report\Scenarios\Holding\run_scenario_0a_rerun_restart\';

findir = 'Y:\Peel Final Report\Scenarios\Processed v12\run_scenario_0a\';


vars = dir([basedir,'*mat']);
for j = 1:length(vars)
    
    disp([vars(j).name]);
    
    bs = load([basedir,vars(j).name]);
    jd = load([joindir,vars(j).name]);
    jd2 = load([joindir2,vars(j).name]);
    
    
    vname = regexprep(vars(j).name,'.mat','');
    
    savedata.X = bs.savedata.X;
    savedata.Y = bs.savedata.Y;
    savedata.Area = [bs.savedata.Area];
    
    sss = find(bs.savedata.Time < jd.savedata.Time(3));
    ttt = find(jd.savedata.Time < jd2.savedata.Time(3));
    savedata.Time = [bs.savedata.Time(sss);jd.savedata.Time(ttt);jd2.savedata.Time(3:end)];
    
    
    
    
    switch vname
        case 'D'
            savedata.(vname) = [bs.savedata.(vname)(:,sss) jd.savedata.(vname)(:,ttt) jd2.savedata.(vname)(:,3:end)];
        case 'H'
            savedata.(vname) = [bs.savedata.(vname)(:,sss) jd.savedata.(vname)(:,ttt) jd2.savedata.(vname)(:,3:end)];
        case 'cell_A'
            savedata.(vname) = bs.savedata.(vname);
        otherwise    
            savedata.(vname).Top = [bs.savedata.(vname).Top(:,sss) jd.savedata.(vname).Top(:,ttt) jd2.savedata.(vname).Top(:,3:end)];
            savedata.(vname).Bot = [bs.savedata.(vname).Bot(:,sss) jd.savedata.(vname).Bot(:,ttt) jd2.savedata.(vname).Bot(:,3:end)];
    end
    
    clear bs jd jd2;
    
    if ~exist([findir],'dir')
        mkdir([findir]);
    end
    
    save([findir,vars(j).name],'savedata','-mat','-v7.3');
    
    clear savedata;
end

