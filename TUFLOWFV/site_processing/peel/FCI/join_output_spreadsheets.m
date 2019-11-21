clear all; close all;

dirlist = dir(['output/','*.csv']);

the_alls = {};

for i = 1:length(dirlist)
    
    nn = strsplit(dirlist(i).name,'_');
    
    the_alls = [the_alls;nn(1)];
    
end
    
the_times = unique(the_alls);

for i = 1:length(the_times)
    
    grid = [];
    pred_fci = [];
    fci_se = [];
    grade = {};
    
    disp(the_times{i});
    
    filename = ['output/',the_times{i},'_M1.csv'];
    
    [snum,sstr] = xlsread(filename,'B2:E30000');
    
    grid = [grid;snum(:,1)];
    pred_fci = [pred_fci;snum(:,2)];
    fci_se = [fci_se;snum(:,3)];
    grade = [grade;sstr(:,end)];
    
    filename = ['output/',the_times{i},'_M2.csv'];
    
    [snum,sstr] = xlsread(filename,'B2:E30000');
    
    grid = [grid;snum(:,1)];
    pred_fci = [pred_fci;snum(:,2)];
    fci_se = [fci_se;snum(:,3)];
    grade = [grade;sstr(:,end)];
    
    filename = ['output/',the_times{i},'_M3.csv'];
    
    [snum,sstr] = xlsread(filename,'B2:E30000');
    
    grid = [grid;snum(:,1)];
    pred_fci = [pred_fci;snum(:,2)];
    fci_se = [fci_se;snum(:,3)];
    grade = [grade;sstr(:,end)];
    
    [out(i).grid,ind] = sort(grid);
    out(i).pred_fci = pred_fci(ind);
    out(i).fci_se = fci_se(ind);
    out(i).grade = grade(ind);
    out(i).time = datenum(the_times{i},'yyyymmddHHMMSS');
    
    
end
    







