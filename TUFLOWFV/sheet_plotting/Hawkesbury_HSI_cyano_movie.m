%clear all; close all;

addpath(genpath('functions'));

grid_nc = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A2sc_2013/output/HN_Cal_2013_2014_3D_wq_WQ.nc';

HSI = load('/Volumes/AED/Hawkesbury/HN_Cal_v6_A2sc_2013/output/proc_cyano_V.mat');

%shp = shaperead('MatGrids/Murray_Ag.shp');

sim_name = '/Volumes/AED/Hawkesbury/Movie.mp4';

hvid = VideoWriter(sim_name,'MPEG-4');
set(hvid,'Quality',100);
set(hvid,'FrameRate',6);
framepar.resolution = [1024,768];

open(hvid);






mdate = data.tdate;

dat = tfv_readnetcdf(grid_nc,'timestep',1);

vert(:,1) = dat.node_X;
vert(:,2) = dat.node_Y;

faces = dat.cell_node';

%--% Fix the triangles
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);




first_plot = 1;

hfig = figure('position',[535.6 605 1676 670]);




for i = 1:length(mdate)

    if first_plot
        
        %__________________________________________________________________________
        ax3 = axes('position',[0.6 0.05 0.3 0.9])
        
        %mapshow(shp,'facecolor','none');hold on
        
        
        patFig2 = patch('faces',faces,'vertices',vert,'FaceVertexCData',data.CYANO_data(:,i));shading flat
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');
        
        caxis([0 1]);
        
%        xlim([353942.743609022          378473.130349353]);
%        ylim([6127303.24809411          6176364.02157477]);
         text(0,0.8,'HSI Index','fontsize',16,'units','normalized','horizontalalignment','left');

        cb = colorbar;
        set(cb,'position',[0.9 0.2 0.01 0.4]);
        
        axis off;
        
        first_plot = 0;
        
        tx = text(0,0,datestr(mdate(i),'dd-mm-yyyy HH:MM'),'fontsize',21,'fontweight','bold','units','normalized');
    else

        
        set(patFig2,'Cdata',data.CYANO_data(:,i));
        drawnow;
        
        set(tx,'String',datestr(mdate(i),'dd-mm-yyyy HH:MM'));
        
    end
    
    
        writeVideo(hvid,getframe(hfig));

end

close(hvid);

