clear all; close all;

base_dir = 'H:\Lowerlakes-CEW-Results\Regions/';

vars = {'SAL';'WQ_NIT_AMM';'WQ_PHS_FRP';'WQ_SIL_RSI';'ON';'OP';'WQ_DIAG_PHY_TCHLA'};


fid = fopen('tables.csv','wt');

%%

fprintf(fid,'Mean\n');
fprintf(fid,'Site,Scenario,Salinity (PSU),Ammonium (mg/L),Phosphate (mg/L),Silica (mg/L),Particulate organic nitrogen (mg/L),Particulate organic phosphorus (mg/L),Chlorophyll a (mg/L)\n');


%____________

filename = '0001_Wellington.csv';

fprintf(fid,'Wellington,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'B2200:B2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Wellington,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C2200:C2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Wellington,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D2200:D2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end
fprintf(fid,'\n');

%____________

filename = '0005_Lake Alex Mid.csv';

fprintf(fid,'Lake Alexandrina Middle,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'B2200:B2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Lake Alexandrina Middle,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C2200:C2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Lake Alexandrina Middle,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D2200:D2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end

%____________
fprintf(fid,'\n');

filename = '0023_Mouth.csv';

fprintf(fid,'Murray Mouth,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'B2200:B2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Murray Mouth,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C2200:C2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Murray Mouth,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D2200:D2200');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');
fprintf(fid,'\n');
fprintf(fid,'\n');


fprintf(fid,'Median\n');
fprintf(fid,'Site,Scenario,Salinity (PSU),Ammonium (mg/L),Phosphate (mg/L),Silica (mg/L),Particulate organic nitrogen (mg/L),Particulate organic phosphorus (mg/L),Chlorophyll a (mg/L)\n');


%____________

filename = '0001_Wellington.csv';

fprintf(fid,'Wellington,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'B2197:B2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Wellington,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C2197:C2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Wellington,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D2197:D2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end
fprintf(fid,'\n');

%____________

filename = '0005_Lake Alex Mid.csv';

fprintf(fid,'Lake Alexandrina Middle,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'B2197:B2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Lake Alexandrina Middle,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C2197:C2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Lake Alexandrina Middle,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D2197:D2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end
fprintf(fid,'\n');

%____________

filename = '0023_Mouth.csv';

fprintf(fid,'Murray Mouth,With all Water,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'B2197:B2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Murray Mouth,No CEW,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'C2197:C2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end

fprintf(fid,'\n');

fprintf(fid,'Murray Mouth,No eWater,');

for i = 1:length(vars)
    
    csv_file = [base_dir,vars{i},'\',filename];
    
    
    snum = xlsread(csv_file,'D2197:D2197');
    
    fprintf(fid,'%4.4f,',snum);
    
end
fprintf(fid,'\n');

fclose(fid);


