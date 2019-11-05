clear all; close all;

[snum,sstr] = xlsread('Spreadsheets/Original BIAS Correction.csv','A2:ZZ10000');

fid = fopen('Spreadsheets/Original BIAS Correction.csv','rt');

header = fgetl(fid);
inc = 1;
while ~feof(fid)
    fline = fgetl(fid);
    
    data.Line(inc) = {fline};
    data.Year(inc) = snum(inc,1);
    data.Month(inc) = snum(inc,2);
    data.Day(inc) = snum(inc,3);
    data.SiteCode(inc) = sstr(inc,1);
    data.Site(inc) = sstr(inc,2);
    data.AED(inc) = sstr(inc,3);
    inc = inc + 1;
end

fclose(fid);

nfid = fopen('Master Spreadsheet v6.csv','rt');
bfid = fopen('New Bias.csv','wt');
cfid = fopen('New Bias Chx.csv','wt');

fprintf(bfid,'%s\n',header);

nHeaders = fgetl(nfid);

first_line = 1;

while ~feof(nfid)
    fline = fgetl(nfid);
    
    splitty = strsplit(fline,',');
    
    sitecode = splitty{1};
    site = splitty{2};
    aedcode = splitty{4};
    year = str2num(splitty{7});
    month = str2num(splitty{8});
    day = str2num(splitty{9});
    
    sss = find(strcmpi(data.SiteCode,sitecode)== 1 & ...
        strcmpi(data.Site,site) == 1 & ...
        data.Year == year & ...
        data.Month == month & ...
        data.Day == day);
    
    
    if ~isempty(sss)
        fprintf(bfid,'%s\n',data.Line{sss});
    else
        %fprintf(bfid,'\n');
        
        ttt = find(strcmpi(data.AED,aedcode)== 1 & ...
            data.Year == year);
        
        if ~isempty(ttt)
            
            bsplitty = strsplit(data.Line{ttt(1)},',','CollapseDelimiters',0);
            bsplitty(1) = splitty(1);
            bsplitty(2) = splitty(2);
            bsplitty(3) = splitty(3);
            bsplitty(4) = splitty(6);
            bsplitty(5) = splitty(7);
            bsplitty(6) = splitty(8);
            
            for k = 1:length(bsplitty)
                fprintf(bfid,'%s,',bsplitty{k});
                fprintf(cfid,'%s,',bsplitty{k});
            end
            fprintf(bfid,'\n');
            fprintf(cfid,'\n');
        else
            www = find(strcmpi(data.AED,aedcode)== 1);
            if ~isempty(www)
                bsplitty = strsplit(data.Line{www(1)},',','CollapseDelimiters',0);
                bsplitty(1) = splitty(1);
                bsplitty(2) = splitty(2);
                bsplitty(3) = splitty(3);
                bsplitty(4) = splitty(6);
                bsplitty(5) = splitty(7);
                bsplitty(6) = splitty(8);
                
                for k = 1:length(bsplitty)
                    fprintf(bfid,'%s,',bsplitty{k});
                    fprintf(cfid,'%s,',bsplitty{k});
                end
                fprintf(bfid,'\n');
                fprintf(cfid,'\n');
            else
                
                
                fprintf(bfid,'%s,%s,%s,%s,%s,%s\n', splitty{1}, splitty{2}, splitty{3}, splitty{6}, splitty{7}, splitty{8});
                fprintf(cfid,'%s,%s,%s,%s,%s,%s\n', splitty{1}, splitty{2}, splitty{3}, splitty{6}, splitty{7}, splitty{8});

            end
        end
        
        
        
    end
end

fclose(bfid);
fclose(nfid);
fclose(cfid);

fclose all;clear all; close all;


