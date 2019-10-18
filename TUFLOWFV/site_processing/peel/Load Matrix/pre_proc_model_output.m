clear all; close all;

modlist = dir('J:\Matfiles_Main\');

sitelist = dir('J:\Matfiles_Main\run_1979_1981\');

varlist = dir(['J:\Matfiles_Main\run_1979_1981\Dawesville Cut\','*.mat']);
for k = 3:length(sitelist)
        sname = regexprep(sitelist(k).name,' ','_');

    for i = 1:length(varlist)
        daily.(sname).(regexprep(varlist(i).name,'.mat','')).Date = [];
        daily.(sname).(regexprep(varlist(i).name,'.mat','')).Data_Top = [];
        daily.(sname).(regexprep(varlist(i).name,'.mat','')).Data_Bot = [];
        varint.(sname).(regexprep(varlist(i).name,'.mat','')) = 1;
    end
end



for i = 3:length(modlist)
    disp(modlist(i).name);
    for j = 3:length(sitelist)
            sname = regexprep(sitelist(j).name,' ','_');

        disp(sitelist(j).name);
        basedir = ['J:\Matfiles_Main\',modlist(i).name,'\',sitelist(j).name,'\'];
        
        for k = 1:length(varlist)
            
            load([basedir,varlist(k).name]);
            
            utime = unique(floor(savedata.Time));
            
            varname = regexprep(varlist(k).name,'.mat','');
            
            for l = 1:length(utime)
                sss = find(floor(savedata.Time) == utime(l));
                daily.(sname).(varname).Date(varint.(sname).(varname),1) = utime(l);
                
                if strcmpi(varname,'D') == 0 & ...
                        strcmpi(varname,'H') == 0
                        
                    daily.(sname).(varname).Data_Top(varint.(sname).(varname),1) = mean(mean(savedata.(varname).Top(:,sss)'));
                    daily.(sname).(varname).Data_Bot(varint.(sname).(varname),1) = mean(mean(savedata.(varname).Bot(:,sss)'));
                    
                else
                    daily.(sname).(varname).Data_Top(varint.(sname).(varname),1) = mean(mean(savedata.(varname)(:,sss)'));
                    daily.(sname).(varname).Data_Bot(varint.(sname).(varname),1) = mean(mean(savedata.(varname)(:,sss)'));
                end
                varint.(sname).(varname) = varint.(sname).(varname) + 1; 
            end
            clear savedata;
        end
    end
end

save daily.mat daily -mat;
