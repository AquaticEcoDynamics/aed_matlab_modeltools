clear all; close all;
filelist = dir('BC Old/');

for i = 3:length(filelist)
    dat = tfv_readBCfile(['BC Old/',filelist(i).name]);
    
    site = ['site_',regexprep(filelist(i).name,'.csv','')];
    
    hdata.(site) = dat;
    hdata.(site).ML = dat.Flow * 86400 /1000;
    
end

load ldata.mat;

pin = ldata.site_Pinjarra;
har = ldata.site_Harvey;
sur = ldata.site_Serpentine;

sss = find(hdata.site_Pinjarra.Date < pin.Date(1));
ttt = find(hdata.site_Harvey.Date < har.Date(1));
uuu = find(hdata.site_Serpentine.Date < sur.Date(1));

ssss = find(hdata.site_Pinjarra.Date > pin.Date(end));
tttt = find(hdata.site_Harvey.Date > har.Date(end));
uuuu = find(hdata.site_Serpentine.Date > sur.Date(end));


vars = fieldnames(hdata.site_Pinjarra);

for i = 1:length(vars)

ldata.site_Pinjarra.(vars{i}) = hdata.site_Pinjarra.(vars{i})(sss);
ldata.site_Pinjarra.(vars{i}) = [ldata.site_Pinjarra.(vars{i});pin.(vars{i})];
ldata.site_Pinjarra.(vars{i}) = [ldata.site_Pinjarra.(vars{i});hdata.site_Pinjarra.(vars{i})(ssss)];

ldata.site_Harvey.(vars{i}) = hdata.site_Harvey.(vars{i})(ttt);
ldata.site_Harvey.(vars{i}) = [ldata.site_Harvey.(vars{i});har.(vars{i})];
ldata.site_Harvey.(vars{i}) = [ldata.site_Harvey.(vars{i});hdata.site_Harvey.(vars{i})(tttt)];

ldata.site_Serpentine.(vars{i}) = hdata.site_Serpentine.(vars{i})(uuu);
ldata.site_Serpentine.(vars{i}) = [ldata.site_Serpentine.(vars{i});sur.(vars{i})];
ldata.site_Serpentine.(vars{i}) = [ldata.site_Serpentine.(vars{i});hdata.site_Serpentine.(vars{i})(uuuu)];

end

save ldata.mat ldata -mat;



