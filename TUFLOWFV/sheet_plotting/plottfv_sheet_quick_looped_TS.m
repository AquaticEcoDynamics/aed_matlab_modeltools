clear all; close all; fclose all;

addpath(genpath('tuflowfv'));


%ncfile = 'Z:\Busch\Studysites\Fitzroy\Geike_v3\Output\Fitzroy_wl.nc';
ncfile = 'Z:\PEEL\2016_Local\run_2016_2018.nc';

outdir = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Peel\4_Simulations\PeelHarveyCatchmentModelResults\Nectar\Peel_v11\2016 Crash\Snapshot\';

%varname = 'WQ_DIAG_LND_SB';
varname = 'WQ_PHY_CRYPT';

cax = [0 250];

title = 'CRYPT';

% These two slow processing down. Only set to 1 if required
create_movie = 0; % 1 to save movie, 0 to just display on screen
save_images = 1;

plot_interval = 1;


%shp = shaperead('Matfiles/Udated_Wetlands.shp');

clip_depth = 0.05;% In m
%clip_depth = 999;% In m

isTop = 1;

%____________




if create_movie | save_images
    
    if ~exist(outdir,'dir')
        mkdir(outdir);
    end
end


if create_movie
    sim_name = [outdir,varname,'.mp4'];
    
    hvid = VideoWriter(sim_name,'MPEG-4');
    set(hvid,'Quality',100);
    set(hvid,'FrameRate',8);
    framepar.resolution = [1024,768];
    
    open(hvid);
end
%__________________


dat = tfv_readnetcdf(ncfile,'time',1);
timesteps = dat.Time;

dat = tfv_readnetcdf(ncfile,'timestep',1);
clear funcions


vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

first_plot = 1;


[~,indBB] = min(abs(timesteps - datenum(2016,11,01)));
tdat = tfv_readnetcdf(ncfile,'timestep',length(timesteps));
    clear functions
vars = fieldnames(tdat);

avars = vars([16 20:end]);

for i = 1:length(avars)

%for i = indBB:plot_interval:length(timesteps)%1:plot_interval:length(timesteps)
    
    varname = avars{i};
    
 first_plot = 1;

 
    
    if isTop
      if strcmpi(varname,'H') == 0 & ...
        strcmpi(varname,'D') == 0 
        
        cdata = tdat.(varname)(tdat.idx3(tdat.idx3 > 0));
      else
          
        cdata = tdat.(varname);
      end
    else
    
    bottom_cells(1:length(tdat.idx3)-1) = tdat.idx3(2:end) - 1;
    bottom_cells(length(tdat.idx3)) = length(tdat.idx3);
    
    cdata = tdat.(varname)(bottom_cells);
    
    end
    
   Depth = tdat.D;
    
    
    if clip_depth < 900
    
        Depth(Depth < clip_depth) = 0;
    
        cdata(Depth == 0) = NaN;
    end
    
    if strcmpi(varname,'WQ_TRC_RET') == 1
        cdata = cdata ./ 86400;
    end
    
    if first_plot
        
        hfig = figure('visible','on','position',[304         166        1271         812]);
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635 6.35 20.32 15.24])
        
        axes('position',[0 0 1 1]);
        

        
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');hold on
        
        
        %plot(332260.0,6076740.0,'*k');
        
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        %mapshow(shp,'EdgeColor','k','facecolor','none');hold on
        
        x_lim = get(gca,'xlim');
        y_lim = get(gca,'ylim');
        
        %caxis(cax);
        
        cb = colorbar;
        
        set(cb,'position',[0.1 0.2 0.01 0.25],...
            'units','normalized','ycolor','k');
        
        colorTitleHandle = get(cb,'Title');
        %set(colorTitleHandle ,'String',regexprep(varname,'_',' '),'color','k','fontsize',10);
        
        
        axis off
        axis equal
        
        text(0.1,0.5,regexprep(varname,'_',' '),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'fontweight','Bold',...
            'color','k');
        
        txtDate = text(0.1,0.1,datestr(timesteps(end),'dd mmm yyyy HH:MM'),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',21,...
            'color','k');
        
        first_plot = 0;
        
        
%           xlim([387966.19196582          393472.220545519]);
%           ylim([6392278.87159036          6395796.49173727]);

%         xlim([294562.612607759          363234.552262931]);
%         ylim([6045021.04244045          6088893.28083541]);
        set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'centimeters');
    set(gcf,'paperposition',[0.635                      6.35                     20.32                     15.24])
    else
        
        set(patFig,'Cdata',cdata);
        drawnow;
        
        set(txtDate,'String',datestr(timesteps(end),'dd mmm yyyy HH:MM'));
        
        %caxis(cax);

    end
%     
%     if create_movie
%         
%        % F = fig2frame(hfig,framepar); % <-- Use this
%         
%         % Add the frame to the video object
%     writeVideo(hvid,getframe(hfig));
%     end
    
    if save_images
    
        img_dir = [outdir];
        if ~exist(img_dir,'dir')
            mkdir(img_dir);
        end
        
        img_name =[img_dir,'Images_2/',num2str(i),'_',varname,'_',datestr(timesteps(i),'yyyymmddHHMM'),'.png'];
        
        saveas(gcf,img_name);
        
    end
    clear data cdata
    
    close;
end  

create_html_for_directory(outdir);

% end
% 
% if create_movie
%     % Close the video object. This is important! The file may not play properly if you don't close it.
%     close(hvid);
% end
% 
% clear all;