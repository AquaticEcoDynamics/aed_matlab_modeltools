clear all; close all;

addpath(genpath('../tuflowfv'));

% Add more conf's to create more movies....
conf(1).var = 'WQ_DIAG_TOT_TURBIDITY';

% %%Linux
% conf(1).nc = '/Projects2/Jayden/Cockburn_2022_2/Output/Cockburn_2021_2022_gpu_ALL.nc';
% conf(1).geo = '/Projects2/Jayden/Cockburn_2022_2/Input/Cockburn_2021_2022_gpu_geo.nc';
% conf(1).output_dir = '/Projects2/Jayden/Cockburn_2022_2/Movies/';
% conf(1).polyline = '/Projects2/Jayden/plotting/Curtain_polyline_100m_QC.shp';

conf(1).nc = 'X:/Jayden/Cockburn_2022_2/Output/Cockburn_2021_2022_gpu_ALL.nc';
conf(1).geo = 'X:/Jayden/Cockburn_2022_2/Input/Cockburn_2021_2022_gpu_geo.nc';
conf(1).output_dir = 'X:/Jayden/Cockburn_2022_2/Movies/';
conf(1).polyline = 'X:/Jayden/plotting/Curtain_polyline_100m_QC.shp';

conf(1).conv = 1;
conf(1).label = 'Turbidity (NTU)';

conf(1).starttime = datenum(2021,07,01);
conf(1).endtime = datenum(2021,08,01);
conf(1).caxis = [0 1];



for i = 1:length(conf)
   tic
    if ~exist(conf(1).output_dir,'dir')
        mkdir(conf(1).output_dir);
    end
        
    
    shp = shaperead(conf(i).polyline);
    for kk = 1:length(shp)
        line(kk,1) = shp(kk).X;
        line(kk,2)  = shp(kk).Y;
    end
    ncfile = conf(1).nc;
    
%     sim_name = [conf(1).output_dir,conf(1).var,'.avi']; %Linux
%     hvid = VideoWriter(sim_name,'Uncompressed AVI');%Linux
    
     sim_name = [conf(1).output_dir,conf(1).var,'.mp4']; %Windows
    hvid = VideoWriter(sim_name,'MPEG-4'); %Windows only
    set(hvid,'Quality',100);%Windows only
    
    set(hvid,'FrameRate',6);
    framepar.resolution = [1024,768];
    
    open(hvid);
    
    dat = tfv_readnetcdf(ncfile,'time',1);
    timesteps = dat.Time;
    
    thetime = find(timesteps >= conf(i).starttime & timesteps <= conf(i).endtime);
    
    dat = tfv_readnetcdf(ncfile,'timestep',1);
    
    
    vert(:,1) = dat.node_X;
    vert(:,2) = dat.node_Y;
    
    faces = dat.cell_node';
    
    %--% Fix the triangles
    faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);
    
    geo = tfv_readnetcdf(conf(i).geo);
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
    fillY =[-20;curt.base;-20];
    
    XImage = imread(['background.png']);
    R =  worldfileread(['background.pgw']);
    
    first_plot = 1;
    
    for TL = 1:length(thetime)
        TS = thetime(TL);
        
         disp([num2str((TL/length(thetime))*100),'% compeleted']);
        
        tdat = tfv_readnetcdf(ncfile,'timestep',TS);
        clear functions
        
        cdata = tdat.(conf(i).var)(tdat.idx3(tdat.idx3 > 0)) .* conf(i).conv;
        
        bottom_cells(1:length(tdat.idx3)-1) = tdat.idx3(2:end) - 1;
        
        bottom_cells(length(tdat.idx3)) = length(tdat.(conf(i).var));
        
        cdata_bot = tdat.(conf(i).var)(bottom_cells') .* conf(i).conv;
        
        Depth = tdat.D;
        
        Depth(Depth < 0.05) = 0;
        
        cdata(Depth == 0) = NaN;
        
        % Build Patch Grid_________________________________________________
        N = length(geodata.X);
        
        for n = 1 : (N - 1)
            i2 = cells_idx2(n);
            % Traditionl
            NL = tdat.NL(i2);
            i3 = tdat.idx3(i2);
            i3z = i3 + i2 -1;
            
            xv{n} = repmat([curt.dist(n);...
                curt.dist(n);...
                curt.dist(n+1);...
                curt.dist(n+1)],...
                [1 NL]);
            
            zv{n} = zeros(4,NL);
            for ii = 1 : NL
                zv{n}(:,ii) = [tdat.layerface_Z(i3z); ...
                    tdat.layerface_Z(i3z+1); ...
                    tdat.layerface_Z(i3z+1); ...
                    tdat.layerface_Z(i3z)];
                i3z = i3z + 1;
            end
            
            tt.var1{n} = tdat.(conf(i).var)(i3:i3+NL-1);
            
            
        end
        
        model.x = cell2mat(xv);
        model.z = cell2mat(zv);
        
        % Add the conversions
        model.var1 = cell2mat(tt.var1') .* conf(i).conv;
        if first_plot
            hfig = figure('visible','off','position',[894    63   742   915]);
            
            set(gcf, 'PaperPositionMode', 'manual');
            set(gcf, 'PaperUnits', 'centimeters');
            xSize = 30;
            ySize = 45;
            xLeft = (21-xSize)/2;
            yTop = (30-ySize)/2;
            set(gcf,'paperposition',[0 0 xSize ySize]);
            
            ax1 = axes('position',[0 0.55 0.5 0.4]);
            
            h(1) = mapshow(XImage,R);
            axis off
            axis equal
            box off
            
            xl = get(gca,'xlim');
            yl = get(gca,'ylim');
            hold on
            
            h(2) = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
            set(gca,'box','on');
            
            set(findobj(gca,'type','surface'),...
                'FaceLighting','phong',...
                'AmbientStrength',.3,'DiffuseStrength',.8,...
                'SpecularStrength',.9,'SpecularExponent',25,...
                'BackFaceLighting','unlit');
            
            ax2.Visible = 'off';
            ax2.XTick = [];
            ax2.YTick = [];
            xlim(xl);
            ylim(yl);
            
            caxis(conf(i).caxis);
            cb = colorbar;
            set(cb,'location','southoutside','position',[0.1 0.53 0.3 0.01],...
            'units','normalized','ycolor','k','fontsize',8);
        
            ax2 = axes('position',[0.5 0.55 0.5 0.4]);
            
            h(3) = mapshow(XImage,R);
            axis off
            axis equal
            box off
            
            xl = get(gca,'xlim');
            yl = get(gca,'ylim');
            hold on
            
            h(4) = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata_bot);shading flat
            set(gca,'box','on');
            
            set(findobj(gca,'type','surface'),...
                'FaceLighting','phong',...
                'AmbientStrength',.3,'DiffuseStrength',.8,...
                'SpecularStrength',.9,'SpecularExponent',25,...
                'BackFaceLighting','unlit');
            
            ax2.Visible = 'off';
            ax2.XTick = [];
            ax2.YTick = [];
            xlim(xl);
            ylim(yl);
            caxis(conf(i).caxis);
            
            cb = colorbar;
            set(cb,'location','southoutside','position',[0.6 0.53 0.3 0.01],...
            'units','normalized','ycolor','k','fontsize',8);        
            
        
            AA2 = axes('position',[0.05 0.1 0.9 0.35]); % Middle
        
            P2 = patch(model.x /1000,model.z,model.var1','edgecolor','none');hold on
            F1 = fill(fillX,fillY,[0.6 0.6 0.6]);
        
            xlim([0 45]);
            ylim([-20 3]); 
            caxis(conf(i).caxis);
            cb = colorbar;
        
            set(cb,'position',[0.96 0.1 0.01 0.35],'YColor','k');
            xlabel('Distance from Garden Island (km)','fontsize',12,'FontWeight','bold','color','k');
            
            txt1 = text(0.1,1.1,conf(i).label,'units','normalized','fontsize',16,'fontweight','bold');
            
            txt3 = text(0.01,1.4,'Surface','units','normalized','fontsize',12,'fontweight','bold','color','w');
            txt4 = text(0.51,1.4,'Bottom','units','normalized','fontsize',12,'fontweight','bold','color','w');
            
            txt2 = text(0.7,1.1,datestr(double(timesteps(TS)),'dd-mm-yyyy HH:MM:SS'),'units','normalized','fontsize',16,'fontweight','bold');
            
            first_plot = 0;
        else
            
            set(h(2),'Cdata',cdata);
            set(h(4),'Cdata',cdata_bot);
  
            set(txt2,'String',datestr(double(timesteps(TS)),'dd mmm yyyy HH:MM'));
            set(P2,'Cdata',model.var1','Xdata',model.x / 1000,'Ydata',model.z);
            
        end
        writeVideo(hvid,getframe(hfig));
    end
    close(hvid);
   % eval(['!HandBrakeCLI -i ',sim_name,' -o',regexprep(sim_name,'avi','mp4')]); %Linux
    
    toc
end

        