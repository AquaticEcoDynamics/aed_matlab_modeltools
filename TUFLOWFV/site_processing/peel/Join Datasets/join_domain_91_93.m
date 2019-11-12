clear all; close all;

basedir = 'T:\PEEL\Processed v12\run_1991_1993\';
joindir = 'T:\PEEL\Processed v12\run_1991_1993_restart\';
joindir2 = 'T:\PEEL\Processed v12\run_1991_1993_restart_restart\';
findir = 'Y:\Peel Final Report\Processed_v12_joined\run_1991_1993_joined\';


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
    
    sss = find(bs.savedata.Time < jd.savedata.Time(1));
    ttt = find(jd.savedata.Time < jd2.savedata.Time(1));
    savedata.Time = [bs.savedata.Time(sss);jd.savedata.Time(ttt);jd2.savedata.Time];
    
    
    
    
    switch vname
        case 'D'
            savedata.(vname) = [bs.savedata.(vname)(:,sss) jd.savedata.(vname)(:,ttt) jd2.savedata.(vname)];
        case 'H'
            savedata.(vname) = [bs.savedata.(vname)(:,sss) jd.savedata.(vname)(:,ttt) jd2.savedata.(vname)];
        case 'cell_A'
            savedata.(vname) = bs.savedata.(vname);
        otherwise    
            savedata.(vname).Top = [bs.savedata.(vname).Top(:,sss) jd.savedata.(vname).Top(:,ttt) jd2.savedata.(vname).Top];
            savedata.(vname).Bot = [bs.savedata.(vname).Bot(:,sss) jd.savedata.(vname).Bot(:,ttt) jd2.savedata.(vname).Bot];
    end
    
    clear bs jd jd2;
    
    if ~exist([findir],'dir')
        mkdir([findir]);
    end
    
    save([findir,vars(j).name],'savedata','-mat','-v7.3');
    
    clear savedata;
end


