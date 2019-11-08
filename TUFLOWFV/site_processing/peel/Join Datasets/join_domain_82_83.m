clear all; close all;

basedir = 'Y:\Peel Final Report\Processed v11\run_1982_1983\';
joindir = 'Y:\Peel Final Report\Processed v11\run_1982_1983_restart\';
findir = 'Y:\Peel Final Report\Processed_v11_joined\run_1982_1983_joined\';


vars = dir([basedir,'*mat']);
for j = 1:length(vars)
    
    disp([vars(j).name]);
    
    bs = load([basedir,vars(j).name]);
    jd = load([joindir,vars(j).name]);
    
    
    
    vname = regexprep(vars(j).name,'.mat','');
    
    savedata.X = bs.savedata.X;
    savedata.Y = bs.savedata.Y;
    savedata.Area = [bs.savedata.Area];
    
    sss = find(bs.savedata.Time < jd.savedata.Time(1));
    
    savedata.Time = [bs.savedata.Time(sss);jd.savedata.Time];
    
    
    
    
    switch vname
        case 'D'
            savedata.(vname) = [bs.savedata.(vname)(:,sss) jd.savedata.(vname)];
        case 'H'
            savedata.(vname) = [bs.savedata.(vname)(:,sss) jd.savedata.(vname)];
        case 'cell_A'
            savedata.(vname) = bs.savedata.(vname);
        otherwise    
            savedata.(vname).Top = [bs.savedata.(vname).Top(:,sss) jd.savedata.(vname).Top];
            savedata.(vname).Bot = [bs.savedata.(vname).Bot(:,sss) jd.savedata.(vname).Bot];
    end
    
    clear bs jd;
    
    if ~exist([findir],'dir')
        mkdir([findir]);
    end
    
    save([findir,vars(j).name,'.mat'],'savedata','-mat','-v7.3');
    
    clear savedata;
end


