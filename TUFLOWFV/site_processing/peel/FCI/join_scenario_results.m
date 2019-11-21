clear all; close all;

dirlist = dir('Scenario_Output/');

fci =  [];

for i = 3:length(dirlist)
    scen = dirlist(i).name;
    
    thefiles = dir(['Scenario_Output/',scen,'/','*.csv']);
    the_alls = [];
    for j = 1:length(thefiles)
        
        nn = strsplit(thefiles(j).name,'_');
        
        the_alls = [the_alls;nn(1)];
        
    end
    
    the_times = unique(the_alls);
    mdate = datenum(the_times,'yyyymmddHHMMSS');
    
    for k = 1:length(the_times)
        
        grid = [];
        pred_fci = [];
        fci_se = [];
        grade = {};
        
        disp([scen,' << ',the_times{k}]);
        
        filename = ['Scenario_Output/',scen,'/',the_times{k},'_M1.csv'];
        
        [snum,sstr] = xlsread(filename,'B2:E30000');
        
        grid = [grid;snum(:,1)];
        pred_fci = [pred_fci;snum(:,2)];
        fci_se = [fci_se;snum(:,3)];
        grade = [grade;sstr(:,end)];
        
        filename = ['Scenario_Output/',scen,'/',the_times{k},'_M2.csv'];
        
        [snum,sstr] = xlsread(filename,'B2:E30000');
        
        grid = [grid;snum(:,1)];
        pred_fci = [pred_fci;snum(:,2)];
        fci_se = [fci_se;snum(:,3)];
        grade = [grade;sstr(:,end)];
        
        filename = ['Scenario_Output/',scen,'/',the_times{k},'_M3.csv'];
        
        [snum,sstr] = xlsread(filename,'B2:E30000');
        
        grid = [grid;snum(:,1)];
        pred_fci = [pred_fci;snum(:,2)];
        fci_se = [fci_se;snum(:,3)];
        grade = [grade;sstr(:,end)];
        
        [fci.(scen).grid(:,k),ind] = sort(grid);
        fci.(scen).pred_fci(:,k) = pred_fci(ind);
        fci.(scen).fci_se(:,k) = fci_se(ind);
        grade_hold = grade(ind);
        fci.(scen).grade(1:length(grade),k) = 0;
        
        sss = find(strcmpi(grade_hold,'A') == 1);
        fci.(scen).grade(sss,k) = 1;
        
        sss = find(strcmpi(grade_hold,'B') == 1);
        fci.(scen).grade(sss,k) = 2;
        
        sss = find(strcmpi(grade_hold,'C') == 1);
        fci.(scen).grade(sss,k) = 3;
        
        sss = find(strcmpi(grade_hold,'D') == 1);
        fci.(scen).grade(sss,k) = 4;
        
        sss = find(strcmpi(grade_hold,'E') == 1);
        fci.(scen).grade(sss,k) = 5;
        
    end
    fci.(scen).mtime = mdate;
        
end
        
save fci.mat fci -mat -v7.3
    