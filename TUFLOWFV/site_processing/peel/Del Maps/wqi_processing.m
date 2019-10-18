clear all; close all;

addpath(genpath('functions'));

load('J:\Matfiles_All\run_2004_2007\WQ_OXY_OXY.mat');

oxy = savedata;

load('J:\Matfiles_All\run_2004_2007\WQ_DIAG_TOT_TN.mat');

tn = savedata;

load('J:\Matfiles_All\run_2004_2007\WQ_DIAG_TOT_TP.mat');

tp = savedata;

load('J:\Matfiles_All\run_2004_2007\WQ_DIAG_PHY_TCHLA.mat');

tchla = savedata;

clear savedata;


sss = find(oxy.Time >= datenum(2005,10,01) & oxy.Time < datenum(2005,11,01));

mdates = oxy.Time(sss);
for i = 1:length(sss)
    disp(num2str(i));
    for j = 1:size(oxy.WQ_OXY_OXY.Bot,1)

modwqi(j,i) = calc_hsi(oxy.WQ_OXY_OXY.Bot(j,sss(i)),tchla.WQ_DIAG_PHY_TCHLA.Top(j,sss(i)),...
                            max(tn.WQ_DIAG_TOT_TN.Bot(j,sss(i)),tn.WQ_DIAG_TOT_TN.Top(j,sss(i))),...
                            max(tp.WQ_DIAG_TOT_TP.Bot(j,sss(i)),tp.WQ_DIAG_TOT_TP.Top(j,sss(i))));

    end
end
save modwqi.mat modwqi mdates -mat;
%_________________________________________________________________________
data = tfv_readnetcdf('J:\Peel Matrix\summer-0d667-0d5\nrun.nc','names',{'WQ_OXY_OXY';'WQ_DIAG_TOT_TN';'WQ_DIAG_TOT_TP';'WQ_DIAG_PHY_TCHLA'});

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

ox.Top = data.WQ_OXY_OXY(surf_ind,:);
ox.Bot = data.WQ_OXY_OXY(bottom_ind,:);
TOTN.Top = data.WQ_DIAG_TOT_TN(surf_ind,:);
TOTN.Bot = data.WQ_DIAG_TOT_TN(bottom_ind,:);
TOTP.Top = data.WQ_DIAG_TOT_TP(surf_ind,:);
TOTP.Bot = data.WQ_DIAG_TOT_TP(bottom_ind,:);
TOTTC.Top = data.WQ_DIAG_PHY_TCHLA(surf_ind,:);
TOTTC.Bot = data.WQ_DIAG_PHY_TCHLA(bottom_ind,:);

sss = find(mtime >= datenum(2005,10,01) & mtime < datenum(2005,11,01));
cdates = mtime(sss);
for i = 1:length(sss)
    disp(num2str(i));
    for j = 1:size(ox.Top,1)

compwqi(j,i) = calc_hsi(ox.Bot(j,sss(i)),TOTTC.Top(j,sss(i)),...
                            max(TOTN.Bot(j,sss(i)),TOTN.Top(j,sss(i))),...
                            max(TOTP.Bot(j,sss(i)),TOTP.Top(j,sss(i))));

    end
end
save compwqi.mat compwqi cdates  -mat;
