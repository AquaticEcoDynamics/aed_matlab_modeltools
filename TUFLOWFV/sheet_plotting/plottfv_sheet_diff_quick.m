clear all; close all; fclose all;

addpath(genpath('tuflowfv'));


%ncfile = 'Z:\Busch\Studysites\Fitzroy\Geike_v3\Output\Fitzroy_wl.nc';
ncfile = 'I:\Erie_plotting\erie_AED.nc';
ncfile2 = 'I:\Erie_plotting\erie_grandriver_75_AED.nc';
ncfile3 = 'I:\Erie_plotting\erie_grandriver_50_AED.nc';

outdir = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Erie\Model_Results\V9_A4_Movies_Scenario\';

%varname = 'WQ_DIAG_LND_SB';
varname = 'WQ_PHS_FRP';

cax = [0 0.01];

conv = 31/1000;%14/1000;

title = 'FRP Diff';

% These two slow processing down. Only set to 1 if required
create_movie = 1; % 1 to save movie, 0 to just display on screen
save_images = 0;

plot_interval = 4;


%shp = shaperead('../../../Lake-Erie-2019/matlab/modeltools/gis/Udated_Wetlands.shp');

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

dat2 = tfv_readnetcdf(ncfile2,'time',1);
timesteps2 = dat2.Time;

dat3 = tfv_readnetcdf(ncfile3,'time',1);
timesteps3 = dat3.Time;


dat = tfv_readnetcdf(ncfile,'timestep',1);
clear funcions


vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

first_plot = 1;

[~,indBB] = min(abs(timesteps - datenum(2016,11,01)));



for i = 15:plot_interval:length(timesteps2)%1:plot_interval:length(timesteps)
    
    [~,indbb] = min(abs(timesteps2 - timesteps(i)));
    [~,indbb1] = min(abs(timesteps3 - timesteps(i)));
    
    tdat = tfv_readnetcdf(ncfile,'timestep',i);
    tdat2 = tfv_readnetcdf(ncfile2,'timestep',indbb);
    tdat3 = tfv_readnetcdf(ncfile3,'timestep',indbb1);
    
    clear functions
    
 
    
    if isTop
      if strcmpi(varname,'H') == 0
        
        
        cdata1 = tdat.(varname)(tdat.idx3(tdat.idx3 > 0));
        cdata2 = tdat2.(varname)(tdat2.idx3(tdat2.idx3 > 0));
        cdata3 = tdat3.(varname)(tdat3.idx3(tdat3.idx3 > 0));
        cdata = cdata1 - cdata2;
        cdata_1 = cdata1 - cdata3;
      else
          
        cdata = tdat.(varname);
      end
    else
        
        disp('Bottom');
    
    bottom_cells(1:length(tdat.idx3)-1) = tdat.idx3(2:end) - 1;
    bottom_cells(length(tdat.idx3)) = length(tdat.idx3);
    
    cdata1 = tdat.(varname)(bottom_cells);
    cdata2 = tdat2.(varname)(bottom_cells);
    cdata3 = tdat3.(varname)(bottom_cells);
    cdata = cdata1 - cdata2;
    cdata_1 = cdata1 - cdata3;
    end
    
%    Depth = tdat.D;
%     
%     
%     if clip_depth < 900
%     
%         Depth(Depth < clip_depth) = 0;
%     
%         cdata(Depth == 0) = NaN;
%     end
    
    if strcmpi(varname,'WQ_TRC_RET') == 1
        cdata = cdata ./ 86400;
    end
    
    cdata = cdata * conv;
    cdata_1 = cdata_1 * conv;
    if first_plot
        
        hfig = figure('visible','on','position',[307          491.666666666667                      1652                       554]);
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635 6.35 20.32 15.24])
        
        axes('position',[0 0 0.5 1]);
        

        
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');hold on
        
        
%         plot(281633.0, 6212426.0,'*k');
%         plot(281838.05, 6212888.35,'*r');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        %mapshow(shp,'EdgeColor','k','facecolor','none');hold on
        
        x_lim = get(gca,'xlim');
        y_lim = get(gca,'ylim');
        
        caxis(cax);
        
        cb = colorbar;
        
        set(cb,'position',[0.45 0.1 0.01 0.25],...
            'units','normalized','ycolor','k');
        
        colorTitleHandle = get(cb,'Title');
        %set(colorTitleHandle ,'String',regexprep(varname,'_',' '),'color','k','fontsize',10);
        
        
        text(0.1,0.9,'Grand River 75%','fontsize',22,'fontweight','Bold','units','normalized');
        
        axis off
        axis equal
        
        text(0.9,0.45,title,...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'fontweight','Bold',...
            'color','k');
        
        txtDate = text(0.6,0.1,datestr(timesteps(i),'dd mmm yyyy HH:MM'),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',14,...
            'color','k');
        
        first_plot = 0;
  
        
           xlim([572817.014255968               675161.4375]);
           ylim([4694180.37023946          4759564.84834658]);
           
           axes('position',[0.5 0 0.5 1]);
           
            patFig1 = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata_1);shading flat
         set(gca,'box','on');hold on
        
        
%         plot(281633.0, 6212426.0,'*k');
%         plot(281838.05, 6212888.35,'*r');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        %mapshow(shp,'EdgeColor','k','facecolor','none');hold on
        
        x_lim = get(gca,'xlim');
        y_lim = get(gca,'ylim');
        
        caxis(cax);
        
        cb = colorbar;
        
        set(cb,'position',[0.95 0.1 0.01 0.25],...
            'units','normalized','ycolor','k');
        
        colorTitleHandle = get(cb,'Title');
        %set(colorTitleHandle ,'String',regexprep(varname,'_',' '),'color','k','fontsize',10);
        text(0.1,0.9,'Grand River 50%','fontsize',22,'fontweight','Bold','units','normalized');
        
        axis off
        axis equal
        
        text(0.9,0.45,title,...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',16,...
            'fontweight','Bold',...
            'color','k');
        
        txtDate1 = text(0.6,0.1,datestr(timesteps(i),'dd mmm yyyy HH:MM'),...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',14,...
            'color','k');
        
        first_plot = 0;
  
        
           xlim([572817.014255968               675161.4375]);
           ylim([4694180.37023946          4759564.84834658]);
           

%         xlim([294562.612607759          363234.552262931]);
%         ylim([6045021.04244045          6088893.28083541]);
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635                      6.35                     20.32                     15.24])
    
    else
        
        set(patFig,'Cdata',cdata);
        drawnow;
       set(patFig1,'Cdata',cdata_1);
        drawnow;       
        set(txtDate,'String',datestr(timesteps(i),'dd mmm yyyy HH:MM'));
         set(txtDate1,'String',datestr(timesteps(i),'dd mmm yyyy HH:MM'));
       
        %caxis(cax);

    end
    
    if create_movie
        
       % F = fig2frame(hfig,framepar); % <-- Use this
        
        % Add the frame to the video object
    writeVideo(hvid,getframe(hfig));
    end
    
    if save_images
    
        img_dir = [outdir,varname,'/'];
        if ~exist(img_dir,'dir')
            mkdir(img_dir);
        end
        
        img_name =[img_dir,datestr(timesteps(i),'yyyymmddHHMM'),'.png'];
        
        saveas(gcf,img_name);
        
    end
    clear data cdata
    
end

if create_movie
    % Close the video object. This is important! The file may not play properly if you don't close it.
    close(hvid);
end

clear all;