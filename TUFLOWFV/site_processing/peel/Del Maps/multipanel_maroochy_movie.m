clear all; close all;

load GHG_data_CH4.mat;
load GHG_data_CO2.mat;
load GHG_data_N2O.mat;

[XX,YY,ZZ,nodeID,faces,X,Y,Z,ID,MAT,A] = tfv_get_node_from_2dm('Maroochy.2dm');

vert(:,1) = XX;
vert(:,2) = YY;

xl = ([495075.131029805          509640.532724819]);
yl = ([7047864.1183083          7066600.95471542]);


sa(:,1) = mean(pCO2_Ma,1);
sa(:,2) = mean(CH4_Ma,1);
sa(:,3) = mean(N2O_Ma,1);


datearray = datenum(2016,01:01:03,01,12,00,00);


sim_name = ['Maroochy_Conc.mp4'];

hvid = VideoWriter(sim_name,'MPEG-4');
set(hvid,'Quality',100);
set(hvid,'FrameRate',6);
framepar.resolution = [1024,768];

open(hvid);


hfig = figure('position',[72.3333333333333          381.666666666667                      1524                       896]);

for i = 1:length(timesteps)
    
    if i == 1
        
        
        ax1 = axes('position',[0.1 0.3 0.25 0.6]);
        
        mapshow('background.jpg');hold on
        
        p1 = patch('faces',faces','vertices',vert,'FaceVertexCData',pCO2_Ma(:,i));shading flat;hold on
        
        axis equal;
        axis off;
        
        xlim([xl]);
        ylim([yl]);
        
        caxis([0 2500]);
        
        cb1 = colorbar('location','southoutside');
        
        text(0.1,1.01,'pCO_2 (\muATM)','fontsize',16,'units','normalized','fontweight','bold');
        
        
        
        %________________
        ax2 = axes('position',[0.35 0.3 0.25 0.6]);
        mapshow('background.jpg');hold on
        p2 = patch('faces',faces','vertices',vert,'FaceVertexCData',CH4_Ma(:,i));shading flat;hold on
        
        axis equal;
        axis off;
        
        xlim([xl]);
        ylim([yl]);
        cb2 = colorbar('location','southoutside');
        caxis([0 1000]);
        text(0.1,1.01,'CH_4 (\muATM)','fontsize',16,'units','normalized','fontweight','bold');
        
        %________________
        ax3 = axes('position',[0.6 0.3 0.25 0.6]);
        mapshow('background.jpg');hold on
        p3 = patch('faces',faces','vertices',vert,'FaceVertexCData',N2O_Ma(:,i));shading flat;hold on
        
        axis equal;
        axis off;
        cb3 = colorbar('location','southoutside');
        
        xlim([xl]);
        ylim([yl]);
        caxis([0 0.5]);
        text(0.1,1.01,'N_20 (\muATM)','fontsize',16,'units','normalized','fontweight','bold');
        
        
        
        
        %_____________
        
        
        ax4 = axes('position',[0.1 0.05 0.8 0.15]);
        
        p4 = area(timesteps,sa(:,1:2));
        legend({'\muCO_2';'CH_4'});
        
        set(gca,'xtick',datearray,'xticklabel',datestr(datearray,'mmm'));
        xlim([timesteps(1) timesteps(end)]);
        
        
        hold on;
        
        p6 = plot([timesteps(i) timesteps(i)],[0 3000],'--k');
        
        
        yyaxis right
        p5 = plot(timesteps,sa(:,3),'r');hold on
        
        ax = gca;
        ax.YColor = 'r';
        xlim([timesteps(1) timesteps(end)]);
        ylabel('N_2O');
        ax.YLim = [0.3 0.5];
        ts = text(0.7,1.1,datestr(timesteps(i),'dd-mm-yyyy HH:MM'),...
            'units','normalized','fontsize',16,'fontweight','bold');
        
        
    else
        
        
        set(p1,'Cdata',pCO2_Ma(:,i));
        drawnow;
        set(p2,'Cdata',CH4_Ma(:,i));
        drawnow;
        set(p3,'Cdata',N2O_Ma(:,i));
        drawnow;
        set(ts,'String',datestr(timesteps(i),'dd mmm yyyy HH:MM'));
        
        
        set(p6,'Visible','off')
        p6 = plot(ax4,[timesteps(i) timesteps(i)],[0 3000],'--k');
        

        
    end
    
    writeVideo(hvid,getframe(hfig));
end

close(hvid);
