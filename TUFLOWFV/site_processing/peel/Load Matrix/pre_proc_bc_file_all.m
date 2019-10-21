clear all; close all;

filelist = dir('BC/');

for i = 3:length(filelist)
    dat = tfv_readBCfile(['BC/',filelist(i).name]);
    
    site = ['site_',regexprep(filelist(i).name,'.csv','')];
    
    ldata.(site) = dat;
    ldata.(site).ML = dat.Flow * 86400 /1000;
    
end

save ldata.mat ldata -mat;

historical_data;
