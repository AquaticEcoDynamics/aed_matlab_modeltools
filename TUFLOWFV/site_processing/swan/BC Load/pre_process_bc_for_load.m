clear all; close all;

dirlist = dir('Inflows/');

addpath(genpath('tuflowfv'));

for i = 3:length(dirlist);
    
    site = regexprep(dirlist(i).name,'.csv','');
    
    data.(site) = tfv_readBCfile(['Inflows/',dirlist(i).name]);
    
    load.(site).ML = data.(site).FLOW * (86400/1000);
    load.(site).L = load.(site).ML * 1e6;
    load.(site).Date = data.(site).ISOTIME;
    
    
    tnconv = 14/1000;
    tpconv = 31/1000;
    
    load.(site).TN_mg = ...
        ((data.(site).AMM * tnconv) .* load.(site).L) + ...
        ((data.(site).NIT * tnconv) .* load.(site).L) + ...
        ((data.(site).DON * tnconv) .* load.(site).L) + ...
        ((data.(site).PON * tnconv) .* load.(site).L) + ...
        ((data.(site).DONR * tnconv) .* load.(site).L);
    
    load.(site).AMM_mg = (data.(site).AMM * tnconv) .* load.(site).L;
    load.(site).NIT_mg = (data.(site).NIT * tnconv) .* load.(site).L;
    load.(site).DON_mg = (data.(site).DON * tnconv) .* load.(site).L;
    load.(site).PON_mg = (data.(site).PON * tnconv) .* load.(site).L;
    load.(site).DONR_mg = (data.(site).DONR * tnconv) .* load.(site).L;
    
    
    
    
    
    
    
    load.(site).TP_mg = ...
        ((data.(site).FRP * tpconv) .* load.(site).L) + ...
        ((data.(site).FRP_ADS * tpconv) .* load.(site).L) + ...
        ((data.(site).DOP * tpconv) .* load.(site).L) + ...
        ((data.(site).POP * tpconv) .* load.(site).L) + ...
        ((data.(site).DOPR * tpconv) .* load.(site).L);
    
    
    load.(site).FRP_mg = (data.(site).FRP * tpconv) .* load.(site).L;
    load.(site).FRP_ADS_mg = (data.(site).FRP_ADS * tpconv) .* load.(site).L;
    load.(site).DOP_mg = (data.(site).DOP * tpconv) .* load.(site).L;
    load.(site).POP_mg = (data.(site).POP * tpconv) .* load.(site).L;
    load.(site).DOPR_mg = (data.(site).DOPR * tpconv) .* load.(site).L;
    
    
    
    
    
    load.(site).TN_kg = load.(site).TN_mg /1e-6;
    load.(site).TP_kg = load.(site).TP_mg /1e-6;
    
    load.(site).AMM_kg = load.(site).AMM_mg /1e-6;
    load.(site).NIT_kg = load.(site).NIT_mg /1e-6;
    load.(site).DON_kg = load.(site).DON_mg /1e-6;
    load.(site).PON_kg = load.(site).PON_mg /1e-6;
    load.(site).DONR_kg = load.(site).DONR_mg /1e-6;
    
    load.(site).FRP_kg = load.(site).FRP_mg /1e-6;
    load.(site).FRP_ADS_kg = load.(site).FRP_ADS_mg /1e-6;
    load.(site).DOP_kg = load.(site).DOP_mg /1e-6;
    load.(site).POP_kg = load.(site).POP_mg /1e-6;
    load.(site).DOPR_kg = load.(site).DOPR_mg /1e-6;
    
end

save load.mat load -mat;

sites = fieldnames(load);

fid = fopen('Flow.csv','wt');

fprintf(fid,'Date,');

for i = 1:length(sites)
    fprintf(fid,'%s (ML/day),',sites{i});
end
fprintf(fid,'\n');

for j = 1:length(load.(sites{1}).Date);
    fprintf(fid,'%s,',datestr(load.(sites{1}).Date(j),'dd/mm/yyyy'));
    
    for i = 1:length(sites)
        if load.(sites{i}).Date(j) == load.(sites{1}).Date(j)
            fprintf(fid,'%4.10f,',load.(sites{i}).ML(j));
        else
            stop;
        end
    end
    fprintf(fid,'\n');
end

fclose(fid);


%________________________

fid = fopen('TN.csv','wt');

fprintf(fid,'Date,');

for i = 1:length(sites)
    fprintf(fid,'%s (KG/day),',sites{i});
end
fprintf(fid,'\n');

for j = 1:length(load.(sites{1}).Date);
    fprintf(fid,'%s,',datestr(load.(sites{1}).Date(j),'dd/mm/yyyy'));
    
    for i = 1:length(sites)
        if load.(sites{i}).Date(j) == load.(sites{1}).Date(j)
            fprintf(fid,'%4.10f,',load.(sites{i}).TN_kg(j));
        else
            stop;
        end
    end
    fprintf(fid,'\n');
end

fclose(fid);

%________________________

fid = fopen('TP.csv','wt');

fprintf(fid,'Date,');

for i = 1:length(sites)
    fprintf(fid,'%s (KG/day),',sites{i});
end
fprintf(fid,'\n');

for j = 1:length(load.(sites{1}).Date);
    fprintf(fid,'%s,',datestr(load.(sites{1}).Date(j),'dd/mm/yyyy'));
    
    for i = 1:length(sites)
        if load.(sites{i}).Date(j) == load.(sites{1}).Date(j)
            fprintf(fid,'%4.10f,',load.(sites{i}).TP_kg(j));
        else
            stop;
        end
    end
    fprintf(fid,'\n');
end

fclose(fid);

