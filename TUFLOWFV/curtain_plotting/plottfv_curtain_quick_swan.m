clear all; close all;
%function plot_curtain(conf)

addpath(genpath('tuflowfv'));

ncfile = 'N:\SCERM\SCERM_v6\Output\SCERM8_2017_2018.nc';
geofile = 'N:\SCERM\SCERM_v6\Input\log\SCERM8_2017_2018_noAED_geo.nc';
linefile = 'Zone3_Cross.csv';

ylimit = [-5 1.5];
xlimit = [0 0.6]; % in km
cax = [15 35];

varname = 'TEMP';

title = 'Temperature (C)';

outdir = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Swan_BB\SCERM_v6\Curtain\Zone3_Crossection\';

   if ~exist(outdir,'dir')
        mkdir(outdir);
    end
%__________________________________________________________________________
frames_per_second = 8; % Lowest is 6

clear hvid;
 hvid = VideoWriter([outdir,varname,'.mp4'],'MPEG-4');
    set(hvid,'Quality',100);
    set(hvid,'FrameRate',8);
    framepar.resolution = [1024,768];
    
    open(hvid);


line = load(linefile);


dat = tfv_readnetcdf(ncfile,'time',1);
timesteps = dat.Time;

geo = tfv_readnetcdf(geofile);
[pt_id,geodata,cells_idx2] = tfv_searchnearest(line,geo);

sXX = geodata.X(1:end);
sYY = geodata.Y(1:end);


curt.dist(1:length(geodata.X)) = 0;
for ii = 1:length(geodata.X)-1
    temp_d = sqrt((sXX(ii+1)-sXX(ii)) .^2 + (sYY(ii+1) - sYY(ii)).^2);
    curt.dist(ii+1) = curt.dist(ii) + temp_d;
end

DX(:,1) = sXX;
DX(:,2) = sYY;
curt.base = geodata.Z;


inc = 1;

% Bathymetry Fills
fillX = [min(curt.dist /1000) sort(curt.dist /1000) max(curt.dist /1000)];
fillY =[-70;curt.base;-70];

for TL = 1:1:length(timesteps)
    
    data = tfv_readnetcdf(ncfile,'timestep',TL);
    
    clear functions
    %
    % Build Patch Grid_________________________________________________
    N = length(geodata.X);
    
    for n = 1 : (N - 1)
        i2 = cells_idx2(n);
        % Traditionl
        NL = data.NL(i2);
        i3 = data.idx3(i2);
        i3z = i3 + i2 -1;
        
        xv{n} = repmat([curt.dist(n);...
            curt.dist(n);...
            curt.dist(n+1);...
            curt.dist(n+1)],...
            [1 NL]);
        
        zv{n} = zeros(4,NL);
        for i = 1 : NL
            zv{n}(:,i) = [data.layerface_Z(i3z); ...
                data.layerface_Z(i3z+1); ...
                data.layerface_Z(i3z+1); ...
                data.layerface_Z(i3z)];
            i3z = i3z + 1;
        end
        
        SAL{n} = data.(varname)(i3:i3+NL-1);
    end
    
    model.x = cell2mat(xv);
    model.z = cell2mat(zv);
    
    model.SAL = cell2mat(SAL');
    
    
    hfig = figure('position',[47 54 1768 917],'color','k');
    
    axes('position',[0.075 0.05 0.8 0.8],'color','k'); % Bottom Left
    
    P1 = patch(model.x /1000,model.z,model.SAL','edgecolor','none');hold on
    F1 = fill(fillX,fillY,[0.6 0.6 0.6]);
    
    
    %plot(xlimit,[-0.5 -0.5],'w','linewidth',2);
    
    xlim(xlimit);
    ylim(ylimit);
    xlabel('Distance(km)','fontsize',12,'FontWeight','bold','color','w');
    ylabel('Depth (mAHD)','fontsize',12,'FontWeight','bold','color','w');
    set(gca,'YColor','w','XColor','w','box','on');
    text(0.05,0.1,title,'Color','w','units','normalized','fontsize',16,'FontWeight','bold');
    
    txtDate = text(0.7,0.1,datestr(timesteps(TL),'dd mmm yyyy HH:MM'),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'color','w');
    
    caxis(cax);
    
    cb = colorbar;
    
    set(cb,'position',[0.88 0.05 0.01 0.8],'YColor','w');
    colorTitleHandle = get(cb,'Title');
    set(colorTitleHandle ,'String','','color','w','fontsize',8);
    inc = inc + 1;
        writeVideo(hvid,getframe(hfig));

        
        
    close
    
   end
 
          close(hvid);

