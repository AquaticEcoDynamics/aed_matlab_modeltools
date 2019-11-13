function tfv_process_fluxfile(filename,matfile,wqfile,nodefile)

[~,col_headers] = xlsread(wqfile,'A2:A1000');

fid = fopen(filename,'rt');

headers = strsplit(fgetl(fid),',');

num_cols = length(headers);

frewind(fid)
x  = num_cols;
textformat = [repmat('%s ',1,x)];
% read single line: number of x-values
datacell = textscan(fid,textformat,'Headerlines',1,'Delimiter',',');
fclose(fid);

% Dates are the first column.
%disp('************** Processing Dates... *********************************');
mDates = datenum(datacell{:,1},'dd/mm/yyyy HH:MM:SS');
%disp('************** Finished Dates...   *********************************');


nodestrings = {};
for i = 1:length(headers)
    tt = strsplit(headers{i},'_');
    nodestrings(i) = tt(1);
end

uni_NS = unique(nodestrings,'stable');

data = [];

inc = 2;

length(uni_NS)

for i = 2:length(uni_NS)
    for j = 1:length(col_headers)
        data.(uni_NS{i}).(col_headers{j}) = str2double(datacell{inc});
        inc = inc + 1;
        data.(uni_NS{i}).mDate = mDates;
    end
end


[nnum,nstr] = xlsread(nodefile,'A2:D26');

nodes = fieldnames(data);

flux = [];

for i = 1:length(nodes)
    ss = find(strcmp(nstr(:,1),nodes{i}) == 1);
    flux.(nstr{ss,3}) = data.(nodes{i});
    
    vars = fieldnames(flux.(nstr{ss,3}));
    
    for ii = 1:length(vars)
        if strcmp(vars{ii},'mDate') == 0
          flux.(nstr{ss,3}).(vars{ii}) =  flux.(nstr{ss,3}).(vars{ii}) * nnum(ss); 
        end
    end
end


% if isfield(flux,'NS14')
%     flux = rmfield(flux,'NS14');
%     disp('Removing Nodestring 14.........');
% end


sites = fieldnames(flux);
for i = 1:length(sites)
    vars = fieldnames(flux.(sites{i}));
    sss = find(flux.(sites{i}).mDate >= datenum(2018,07,01,00,00,00));
    for j = 1:length(vars)
        flux1.(sites{i}).(vars{j}) = flux.(sites{i}).(vars{j})(sss);
    end
end
flux = [];
flux = flux1;





save(matfile,'flux','-mat');