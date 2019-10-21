clear all; close all;

load compwqi.mat;

load modwqi.mat;

[XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT,A] = tfv_get_node_from_2dm('Peelv4_Sed_Oxy_Coolup_hole_UM_50m_polygon_min05m.2dm');

vert(:,1) = XX;
vert(:,2) = YY;

sim_name = ['Peel_HSI_Comp.mp4'];

hvid = VideoWriter(sim_name,'MPEG-4');
set(hvid,'Quality',100);
set(hvid,'FrameRate',6);
framepar.resolution = [1024,768];

open(hvid);

hfig = figure('position',[520         472        1243         488]);

for i = 1:length(cdates)
    [~,ind] = min(abs(mdates - cdates(i)));
    
    if i == 1
        
        
        ax1 = axes('position',[0 0 0.5 1]);
        
        p1 = patch('faces',faces',...
            'vertices',vert,...
            'FaceVertexCData',modwqi(:,ind));shading flat;hold on
        
        axis equal;
        axis off;
        
        caxis([0 1]);
        xlim([363259.910246608          399494.598580347]);
        ylim([6369841.83612477          6398293.20846084]);
        
        cb1 = colorbar;
        set(cb1,'position',[0.4,0.2,0.01,0.3]);
        
        text(0.8,0.55,'HSI Index',...
            'units','normalized','fontsize',10,'fontweight','bold');  

         text(0.15,0.4,{'Flow x 1';'WQ x 1'},...
            'units','normalized','fontsize',14,'fontweight','bold');  
        
        ts = text(1,0.1,datestr(cdates(i),'dd-mm HH:MM'),...
            'units','normalized','fontsize',14,'fontweight','bold');
        %_____________________________________________
        
        ax2 = axes('position',[0.5 0 0.5 1]);
        
        p2 = patch('faces',faces',...
            'vertices',vert,...
            'FaceVertexCData',compwqi(:,i));shading flat;hold on
        
         text(0.15,0.4,{'Flow x 0.66';'WQ x 0.5'},...
            'units','normalized','fontsize',14,'fontweight','bold');  
        
        axis equal;
        axis off;
        caxis([0 1]);
        
        xlim([363259.910246608          399494.598580347]);
        ylim([6369841.83612477          6398293.20846084]);
        cb2 = colorbar;
         text(0.8,0.55,'HSI Index',...
            'units','normalized','fontsize',10,'fontweight','bold');  

        set(cb2,'position',[0.9,0.2,0.01,0.3]);
        
        

    else
        set(p1,'Cdata',modwqi(:,ind));
        drawnow;
        set(p2,'Cdata',compwqi(:,i));
        drawnow;
        set(ts,'String',datestr(cdates(i),'dd-mm HH:MM'));

    end
    
    writeVideo(hvid,getframe(hfig));
    
    
end
close(hvid);

