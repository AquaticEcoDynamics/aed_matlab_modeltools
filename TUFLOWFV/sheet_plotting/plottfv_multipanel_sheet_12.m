clear all; close all;

addpath(genpath('..\tuflowfv'));

% define the CDM NC output file
ncfile = 'Y:\Development\matt\hchb_tfvaed_v2_calibration_z31_newSHP\output_31\hchb_wave_21901101_20210701_wq_v5_resuspension_all.nc';

% define 12 variables to plot
varname = {...
    'WQ_DIAG_SDG_OXY01'			,...
    'WQ_DIAG_SDF_FSED_OXY'			,...
    'WQ_DIAG_SDF_FSED_NIT'			,...
    'WQ_DIAG_SDG_AMM01'         ,...
    'WQ_DIAG_SDG_POML01'        ,...
    'WQ_DIAG_SDG_SWI_DEFF'      ,...
    'WQ_DIAG_SDG_OPD'           ,...
    'WQ_DIAG_SDG_MINERL'        ,...
    'WQ_DIAG_SDG_DENIT'         ,...
    'WQ_DIAG_SDG_SO4RED'        ,...
    'WQ_DIAG_SDG_BIODEPTH'      ,...
    'WQ_DIAG_SDG_STEADINESS'    ,...
    };

% define the title captions for 12 variable
caps = {...
    'SDG_OXY 1cm (mmol/m^3)'			,...
    'SDF_FSED_OXY (mmol/m^2/d)'			,...
    'SDF_FSED_NIT  (mmol/m^2/d)'			,...
    'SDG_AMM 1cm  (mmol/m^2)'         ,...
    'SDG_POML 1cm  (mmol/m^2)'        ,...
    'SDG_SWI_DEFF (m2/s)'      ,...
    'SDG_OPD (cm)'           ,...
    'SDG_MINERL (mmol/L/y)'        ,...
    'SDG_DENIT (mmol/L/y)'         ,...
    'SDG_SO4RED (mmol/L/y)'        ,...
    'SDG_BIODEPTH (cm)'      ,...
    'SDG_STEADINESS (mmol/mL/y)'    ,...
    };

% define conversion facotr and caxis
for int=1:length(varname)
    var(int).name  = varname{int};
    var(int).conv  = 1;
    var(int).caxis = [];
    var(int).Title = caps{int};
end

% define plotting time steps
pdate = datenum(2019,11,5:400,12,0,0);

% define output directory
outputdir = 'Y:/Development/matt/hchb_tfvaed_v2_calibration_z31_newSHP/Plots31c/Sheets/';

if ~exist(outputdir,'dir')
    mkdir(outputdir);
end

%% _________plotting________________________________________________________


dat = tfv_readnetcdf(ncfile,'time',1);

data = tfv_readnetcdf(ncfile,'timestep',1);

vert(:,1) = data.node_X;
vert(:,2) = data.node_Y;

faces = data.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);


surf_ind = data.idx3;

bottom_ind(1:length(data.idx3)-1) = data.idx3(2:end) - 1;
bottom_ind(length(data.idx3)) = length(data.idx3);

%%

hfig = figure('visible','off','position',[304         166        1500         900]);

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
set(gcf,'paperposition',[0.635 6.35 30 18]);

for j = 1:length(pdate)
    clf;
    disp(datestr(pdate(j)));
    [~,ts] = min(abs(dat.Time - pdate(j)));
    data = tfv_readnetcdf(ncfile,'timestep',ts);
    
    for i = 1:length(var)
        
        if i<7
            axes('Position',[(i-1)*0.15-0.05 0.5 0.4 0.4]);
        else
            axes('Position',[(i-7)*0.15-0.05 0.1 0.4 0.4]);
        end

        cdata = data.(var(i).name)(bottom_ind) * var(i).conv;

        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat;
        set(gca,'box','on');
        
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        if ~isempty(var(i).caxis)
            caxis(var(i).caxis);
        end
        %  caxis(cax);
        cb = colorbar; %(h(i),'location','west');
        if i<7
            set(cb,'Position',[(i-1)*0.15+0.1 0.65 0.005 0.15 ]);
        else
            set(cb,'Position',[(i-7)*0.15+0.1 0.25 0.005 0.15 ]);
        end
      
        text(0.2,0.2,regexprep(var(i).Title,'_',' '),'fontsize',6,'units','normalized');
        text(0.2,0.1,datestr(pdate(j),'dd-mm-yyyy HH:MM'),'fontsize',6,'units','normalized','horizontalalignment','left');

        axis off;        axis equal;
        xlim([3.2280e+05 3.9398e+05]);
        ylim([5.9896e+06 6.0526e+06]);
        camroll(-25);
        
    end

    finalname = [outputdir,datestr(pdate(j),'yyyymmdd_HHMM'),'.png'];
    %print(gcf,finalname,'-depsc2');
    print(gcf,finalname,'-dpng','-r300');
    clear data;
    
end
