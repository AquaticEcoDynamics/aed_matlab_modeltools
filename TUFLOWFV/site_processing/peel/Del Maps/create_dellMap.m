clear all; close all;

addpath(genpath('functions'));

load('J:\Matfiles_All\run_2004_2007\WQ_OXY_OXY.mat');

data = tfv_readnetcdf('J:\Peel Matrix\summer-0d667-0d5\nrun.nc','names',{'WQ_OXY_OXY'});

dat = tfv_readnetcdf('J:\Peel Matrix\summer-0d667-0d5\nrun.nc','time',1);


dat2 = tfv_readnetcdf('J:\Peel Matrix\summer-0d667-0d5\nrun.nc','timestep',1);

vert(:,1) = dat2.node_X;
vert(:,2) = dat2.node_Y;

faces = dat2.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);


surf_ind = dat2.idx3;

bottom_ind(1:length(dat2.idx3)-1) = dat2.idx3(2:end) - 1;
bottom_ind(length(dat2.idx3)) = length(dat2.idx3);

vtime = datevec(dat.Time);
vtime(:,1) = 2005;

mtime = datenum(vtime);

sss = find(mtime >=  datenum(2005,10,01));

%__________________________________________________________________________

oxy_bot = data.WQ_OXY_OXY(bottom_ind,:);

oxy_bot = oxy_bot * 32/1000;
savedata.WQ_OXY_OXY.Bot = savedata.WQ_OXY_OXY.Bot* 32/1000;




for i = 1:length(sss)
    
    [~,int] = min(abs(savedata.Time - mtime(sss(i))));
    
    oxyall(:,i) = savedata.WQ_OXY_OXY.Bot(:,int) - oxy_bot(:,sss(i));
    
end

oxymean = double(mean(oxyall,2));
clear data savedata oxyall oxy_bot;

%__________________________________________________________________________


load('J:\Matfiles_All\run_2004_2007\WQ_DIAG_TOT_TN.mat');

data = tfv_readnetcdf('J:\Peel Matrix\summer-0d667-0d5\nrun.nc','names',{'WQ_DIAG_TOT_TN'});

TN_bot = data.WQ_DIAG_TOT_TN(bottom_ind,:);

TN_bot = TN_bot * 14/1000;
savedata.WQ_DIAG_TOT_TN.Bot = savedata.WQ_DIAG_TOT_TN.Bot* 14/1000;




for i = 1:length(sss)
    
    [~,int] = min(abs(savedata.Time - mtime(sss(i))));
    
    tnall(:,i) = savedata.WQ_DIAG_TOT_TN.Bot(:,int) - TN_bot(:,sss(i));
    
end

tnmean = double(mean(tnall,2));

clear data savedata tnall tn_bot;

%__________________________________________________________________________


load('J:\Matfiles_All\run_2004_2007\WQ_DIAG_TOT_TP.mat');

data = tfv_readnetcdf('J:\Peel Matrix\summer-0d667-0d5\nrun.nc','names',{'WQ_DIAG_TOT_TP'});

TP_bot = data.WQ_DIAG_TOT_TP(bottom_ind,:);

TP_bot = TP_bot * 31/1000;
savedata.WQ_DIAG_TOT_TP.Bot = savedata.WQ_DIAG_TOT_TP.Bot* 31/1000;




for i = 1:length(sss)
    
    [~,int] = min(abs(savedata.Time - mtime(sss(i))));
    
    tpall(:,i) = savedata.WQ_DIAG_TOT_TP.Bot(:,int) - TP_bot(:,sss(i));
    
end

tpmean = double(mean(tpall,2));

clear data savedata tpall tp_bot;

%__________________________________________________________________________


load('J:\Matfiles_All\run_2004_2007\WQ_DIAG_PHY_TCHLA.mat');

data = tfv_readnetcdf('J:\Peel Matrix\summer-0d667-0d5\nrun.nc','names',{'WQ_DIAG_PHY_TCHLA'});

TC_bot = data.WQ_DIAG_PHY_TCHLA(bottom_ind,:);

TC_bot = TC_bot;% * 31/1000;
savedata.WQ_DIAG_PHY_TCHLA.Bot = savedata.WQ_DIAG_PHY_TCHLA.Bot;%* 31/1000;




for i = 1:length(sss)
    
    [~,int] = min(abs(savedata.Time - mtime(sss(i))));
    
    tcall(:,i) = savedata.WQ_DIAG_PHY_TCHLA.Bot(:,int) - TC_bot(:,sss(i));
    
end

tcmean = double(mean(tcall,2));

clear data savedata tpall tp_bot;

load modwqi.mat
load compwqi.mat

for i = 1:length(cdates)
        [~,int] = min(abs(mdates - cdates(i)));
    
    wqiall(:,i) = modwqi(:,int) - compwqi(:,i);
end

wqimean = double(mean(wqiall,2));
convert_2dm_to_shp('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm',...
    'OXY',oxymean','TN',tnmean,'TP',tpmean,'TCHLA',tcmean,'WQI',wqimean);


    