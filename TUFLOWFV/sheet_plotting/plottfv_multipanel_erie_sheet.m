clear all; close all;

addpath(genpath('../tuflowfv'));
int = 1;

% var(int).name = 'WQ_BIV_FILTFRAC';
% var(int).nc = 'D:\Simulations\Erie\Lake Erie\TFVAED2\tfv_004_2013_MET_aed2_2018_BIV - Copy\Output\erie_aed.nc';
% var(int).conv = 1;
% var(int).caxis = [0 0.8];
% var(int).Title = 'BIV FRAC';
% int = int  + 1;
% 
% var(int).name = 'WQ_DIAG_BIV_NUM';
% var(int).nc = 'D:\Simulations\Erie\Lake Erie\TFVAED2\tfv_004_2013_MET_aed2_2018_BIV - Copy\Output\erie_aed_diag.nc';
% var(int).conv = 1;
% var(int).caxis = [0 1];
% var(int).Title = 'BIV NUM';
% int = int  + 1;
% 
% var(int).name = 'WQ_DIAG_BIV_NMP';
% var(int).nc = 'D:\Simulations\Erie\Lake Erie\TFVAED2\tfv_004_2013_MET_aed2_2018_BIV - Copy\Output\erie_aed_diag.nc';
% var(int).conv = 1;
% var(int).caxis = [0 1];
% var(int).Title = 'BIV NMP';
% int = int  + 1;
% 
% var(int).name = 'WQ_DIAG_BIV_TBIV';
% var(int).nc = 'D:\Simulations\Erie\Lake Erie\TFVAED2\tfv_004_2013_MET_aed2_2018_BIV - Copy\Output\erie_aed_diag.nc';
% var(int).conv = 1;
% var(int).caxis = [0 1000];
% var(int).Title = 'BIV TBIV';
% int = int  + 1;


var(int).name = 'WQ_DIAG_MAG_GPP_BEN';
var(int).nc = '/Projects2/erie_12_a_AED_diag.nc';;
var(int).conv = 1;
var(int).caxis = [0 0.1];
var(int).Title = 'GPP';
int = int  + 1;

var(int).name = 'WQ_DIAG_MAG_TMALG';
var(int).nc = '/Projects2/erie_12_a_AED_diag.nc';;
var(int).conv = 1;
var(int).caxis = [0 100];
var(int).Title = 'CGM';
int = int  + 1;

var(int).name = 'WQ_DIAG_MAG_CGM_FPHO_BEN';
var(int).nc = '/Projects2/erie_12_a_AED_diag.nc';;
var(int).conv = 1;
var(int).caxis = [0 1];
var(int).Title = 'F(P)';
int = int  + 1;

var(int).name = 'WQ_DIAG_TOT_PAR';
var(int).nc = '/Projects2/erie_12_a_AED_diag.nc';;
var(int).conv = 1;
var(int).caxis = [0 100];
var(int).Title = 'PAR';
int = int  + 1;





% var(int).name = 'WQ_DIAG_PHY_TCHLA';
% var(int).nc = 'D:\Simulations\Erie\Lake Erie\TFVAED2\tfv_002_2013_2dwind_aed2_2018\Output\erie__aed_diag.nc';
% var(int).conv = 1;
% var(int).caxis = [0 15];
% var(int).Title = 'TCHLa (ug/L)';
% int = int  + 1;




pdate = datenum(2013,05,07:0.25:50,12,00,00);

outputdir = '/Projects2/Erie/tfv_012_Val_a/Sheet_4panel/';

cols = 2;
rows = 2;

if ~exist(outputdir,'dir')
    mkdir(outputdir);
end

%__________________________________________________________________________________

for j = 1:length(pdate)
    figure
    
    disp('hi');
    
    for i = 1:length(var)
        dat = tfv_readnetcdf(var(i).nc,'time',1);
        [~,var(i).ts] = min(abs(dat.Time - pdate(j)));
        
        
        
        subplot(rows,cols,i)
        
        data = tfv_readnetcdf(var(i).nc,'timestep',var(i).ts);
        
        vert(:,1) = data.node_X;
        vert(:,2) = data.node_Y;
        
        faces = data.cell_node';
        
        %--% Fix the triangles
        faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);
        
        
        surf_ind = data.idx3;
        
        bottom_ind(1:length(data.idx3)-1) = data.idx3(2:end) - 1;
        bottom_ind(length(data.idx3)) = length(data.idx3);
        
        
        cdata = data.(var(i).name)(bottom_ind) * var(i).conv;
        
        %colormap(jet);
        
        fig.ax = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat;hold on
        
        caxis(var(i).caxis);
        
        cb = colorbar('location','southoutside');
        
        cb1 = get(cb,'position');
        set(cb,'position',[cb1(1) (cb1(2)-0.1) cb1(3) 0.01]);
        
        text(0.2,0.99,var(i).Title,'fontsize',8,'units','normalized');
        text(0.6,-0.1,datestr(pdate(j),'dd-mm-yyyy HH:MM'),'fontsize',8,'units','normalized','horizontalalignment','center');
        axis off; axis equal;
        
		
		xlim([551881.877957092          682544.753952539]);
		ylim([4680926.08875129          4764402.29277041]);
        
    end
    
    
    
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'centimeters');
    xSize = 20;
    ySize = 20;
    xLeft = (21-xSize)/2;
    yTop = (30-ySize)/2;
    set(gcf,'paperposition',[0 0 xSize ySize])
    
    finalname = [outputdir,datestr(pdate(j),'yyyymmddHHMM'),'.png'];
    %print(gcf,finalname,'-depsc2');
    print(gcf,finalname,'-dpng','-r300');
    
    close all;
    
end

