
clear all; close all;

%% loading data

read_nc=1; % 1: read from nc file, 0: read from mat file

if read_nc
infile='Z:\PEEL\run_1979_1981_MH.nc';

oxy=ncread(infile,'WQ_OXY_OXY');
temp=ncread(infile,'TEMP');
sal=ncread(infile,'SAL');
D=ncread(infile,'D');
mac=ncread(infile,'WQ_DIAG_MAC_MAC');

dat = tfv_readnetcdf(infile,'time',1);
time=dat.Time;

dat2 = tfv_readnetcdf(infile,'timestep',1);

vert(:,1) = dat2.node_X;
vert(:,2) = dat2.node_Y;

faces = dat2.cell_node';
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

surf_ind = dat2.idx3;

bottom_ind(1:length(dat2.idx3)-1) = dat2.idx3(2:end) - 1;
bottom_ind(length(dat2.idx3)) = length(dat2.idx3);

oxyB=oxy(bottom_ind,:);
tempB=temp(bottom_ind,:);
salB=sal(bottom_ind,:);
macB=mac(bottom_ind,:);

save('Crab_Index.mat','time','oxyB','salB','tempB','macB','D','vert','faces','bottom_ind','-mat','-v7.3');

else
    load Crab_Index.mat;
end



%% calculation
    oxyB=oxyB*32/1000; % convert DO to mg/L
    
    CI=zeros(size(oxyB)); % larval habitat
    CI2=zeros(size(oxyB)); % adult crab habitat
    
    fT=zeros(size(oxyB));
    fS=zeros(size(oxyB));    
    fO=zeros(size(oxyB));
    fM=zeros(size(oxyB));
    fD=zeros(size(oxyB));
    
    % calculate the larval habitat index
    t1=20;t2=22.5;t3=25;t4=40; % temp thresholds
    s1=5;s2=20;s3=25;s4=45; % sal thresholds
    o1=2; o2=4; % oxy thresholds
    d1=0; d2=2; % depth thresholds
    
    for mm=1:size(oxyB,1) 
        for nn=1:size(oxyB,2)
            % cal fT
            if tempB(mm,nn)<t1
                fT(mm,nn)=0;
            elseif tempB(mm,nn)<t2
                fT(mm,nn)=(tempB(mm,nn)-t1)/(t2-t1);
            elseif tempB(mm,nn)<=t3
                fT(mm,nn)=1;
            elseif tempB(mm,nn)<t4
                fT(mm,nn)=(t4-tempB(mm,nn))/(t4-t3);
            else
                fT(mm,nn)=0;
            end
            % cal fS
            if salB(mm,nn)<s1
                fS(mm,nn)=0;
            elseif salB(mm,nn)<s2
                fS(mm,nn)=(salB(mm,nn)-s1)/(s2-s1);
            elseif salB(mm,nn)<=s3
                fS(mm,nn)=1;
            elseif salB(mm,nn)<s4
                fS(mm,nn)=(s4-salB(mm,nn))/(s4-s3);
            else
                fS(mm,nn)=0;
            end
            % cal fO
            if oxyB(mm,nn)<o1
                fO(mm,nn)=0;
            elseif oxyB(mm,nn)<o2
                fO(mm,nn)=(oxyB(mm,nn)-o1)/(o2-o1);
            else
                fO(mm,nn)=1;
            end
            % cal fM
            if macB(mm,nn)>0
                fM(mm,nn)=1;
            else
                fM(mm,nn)=0.5;
            end
            
            % cal fD
            if (D(mm,nn)<d1 || D(mm,nn)>d2)
                fD(mm,nn)=0;
            else 
                fD(mm,nn)=1;
            end
            
            % cal CI
            CI(mm,nn)=fT(mm,nn)*fS(mm,nn)*fO(mm,nn)*fM(mm,nn)*fD(mm,nn);
        end
    end

    % calculate the adult crab habitat index
    t1=13;t2=22.5;t3=25;t4=40; % temp thresholds
    s1=20;s2=30;s3=35;s4=45; % sal thresholds
    o1=2; o2=4; %oxy threshold
    d1=1; d2=3; % depth thresholds
    
    
    for mm=1:size(oxyB,1) 
        for nn=1:size(oxyB,2)
            % cal fT
            if tempB(mm,nn)<t1
                fT(mm,nn)=0;
            elseif tempB(mm,nn)<t2
                fT(mm,nn)=(tempB(mm,nn)-t1)/(t2-t1);
            elseif tempB(mm,nn)<=t3
                fT(mm,nn)=1;
            elseif tempB(mm,nn)<t4
                fT(mm,nn)=(t4-tempB(mm,nn))/(t4-t3);
            else
                fT(mm,nn)=0;
            end
            % cal fS
            if salB(mm,nn)<s1
                fS(mm,nn)=0;
            elseif salB(mm,nn)<s2
                fS(mm,nn)=(salB(mm,nn)-s1)/(s2-s1);
            elseif salB(mm,nn)<=s3
                fS(mm,nn)=1;
            elseif salB(mm,nn)<s4
                fS(mm,nn)=(s4-salB(mm,nn))/(s4-s3);
            else
                fS(mm,nn)=0;
            end
            % cal fO
            if oxyB(mm,nn)<o1
                fO(mm,nn)=0;
            elseif oxyB(mm,nn)<o2
                fO(mm,nn)=(oxyB(mm,nn)-o1)/(o2-o1);
            else
                fO(mm,nn)=1;
            end
            % cal fM
            if macB(mm,nn)>0
                fM(mm,nn)=1;
            else
                fM(mm,nn)=0.5;
            end
            
            % cal fD
            if (D(mm,nn)<d1 || D(mm,nn)>d2)
                fD(mm,nn)=0;
            else 
                fD(mm,nn)=1;
            end
            
            % cal CI
            CI2(mm,nn)=fT(mm,nn)*fS(mm,nn)*fO(mm,nn)*fM(mm,nn)*fD(mm,nn);
        end
    end

    
    %% plotting
    
    
        hfig = figure('visible','on','position',[304         166        800         1000]);
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635 6.35 18.24 18.32 ])
        
        pos1=[0.08 0.58 0.4 0.4];
        pos2=[0.52 0.58 0.4 0.4];
        pos3=[0.08 0.08 0.4 0.4];
        pos4=[0.52 0.08 0.4 0.4];
        %pos5=[0.95 0.28 0.3 0.05];
        
        cax=[0 0.5];
        
        dv=datevec(time);
        dm=dv(:,2);  % fine the months of date
        
        axes('position',pos1);
        
        inds=find(4<=dm & dm<=6);
        
        cdata=mean(CI(:,inds),2);
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');

        caxis(cax);

        axis off; axis equal;
        
        text(0.1,0.9,'Crab Larval Habitat Index - Apr-Jun',...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',8,...
            'fontweight','Bold',...
            'color','k');

       axes('position',pos2);
        
        inds=find(7<=dm & dm<=9);
        
        cdata=mean(CI(:,inds),2);
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');

        caxis(cax);

        axis off;  axis equal;
        
        text(0.1,0.9,'Crab Larval Habitat Index - Jul-Sep',...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',8,...
            'fontweight','Bold',...
            'color','k');
        
        axes('position',pos3);
        
        inds=find(10<=dm & dm<=12);
        
        cdata=mean(CI(:,inds),2);
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');

        caxis(cax);

        axis off; axis equal;
        
        text(0.1,0.9,'Crab Larval Habitat Index - Oct-Dec',...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',8,...
            'fontweight','Bold',...
            'color','k');
        
        axes('position',pos4);
        
        inds=find(1<=dm & dm<=3);
        
        cdata=mean(CI(:,inds),2);
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');

        caxis(cax);
        
        cb = colorbar;
        
        set(cb,'position',[0.9 0.1 0.01 0.25],...
            'units','normalized','ycolor','k');

        axis off; axis equal;
        
        text(0.1,0.9,'Crab Larval Habitat Index -Jan-Mar',...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',8,...
            'fontweight','Bold',...
            'color','k');
 
    img_name ='Larval_index.png';
        
        saveas(gcf,img_name);
        
        
    %% plotting
    
    
        hfig = figure('visible','on','position',[304         166        800         1000]);
        
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        set(gcf,'paperposition',[0.635 6.35 18.24 18.32 ])
        
        pos1=[0.08 0.58 0.4 0.4];
        pos2=[0.52 0.58 0.4 0.4];
        pos3=[0.08 0.08 0.4 0.4];
        pos4=[0.52 0.08 0.4 0.4];
        pos5=[0.95 0.28 0.3 0.05];
        
        cax=[0 0.8];
        
        axes('position',pos1);
        
        inds=find(4<=dm & dm<=6);
        
        cdata=mean(CI2(:,inds),2);
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');

        caxis(cax);

        axis off;axis equal;
        
        text(0.1,0.9,'Crab Adult Habitat Index - Apr-Jun',...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',8,...
            'fontweight','Bold',...
            'color','k');

       axes('position',pos2);
        
        inds=find(7<=dm & dm<=9);
        
        cdata=mean(CI2(:,inds),2);
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');

        caxis(cax);

        axis off; axis equal;
        
        text(0.1,0.9,'Crab Adult Habitat Index - Jul-Sep',...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',8,...
            'fontweight','Bold',...
            'color','k');
        
               axes('position',pos3);
               
inds=find(10<=dm & dm<=12);
        cdata=mean(CI2(:,inds),2);
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');

        caxis(cax);

        axis off; axis equal;
        
        text(0.1,0.9,'Crab Adult Habitat Index - Oct-Dec',...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',8,...
            'fontweight','Bold',...
            'color','k');
        
        axes('position',pos4);
        
        inds=find(1<=dm & dm<=3);
        
        cdata=mean(CI2(:,inds),2);
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',cdata);shading flat
        set(gca,'box','on');
        
        set(findobj(gca,'type','surface'),...
            'FaceLighting','phong',...
            'AmbientStrength',.3,'DiffuseStrength',.8,...
            'SpecularStrength',.9,'SpecularExponent',25,...
            'BackFaceLighting','unlit');

        caxis(cax);
        
        cb = colorbar;
        
        set(cb,'position',[0.9 0.1 0.01 0.25],...
            'units','normalized','ycolor','k');

        axis off; axis equal;
        
        text(0.1,0.9,'Crab Adult Habitat Index -Jan-Mar',...
            'Units','Normalized',...
            'Fontname','Candara',...
            'Fontsize',8,...
            'fontweight','Bold',...
            'color','k');

        img_name ='Adult_index.png';
        
        saveas(gcf,img_name);
        
         %% do other plots
%         
%         do_index(fT,[0 1],time,faces,vert,'temp_index');
%          do_index(fS,[0 1],time,faces,vert,'sal_index');
%           do_index(fO,[0 1],time,faces,vert,'DO_index');
%            do_index(fD,[0 1],time,faces,vert,'depth_index');
%             do_index(fM,[0 1],time,faces,vert,'mac_index');
%            
%         