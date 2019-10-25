clear all; close all;

files = {...
    'run_1979_1981',...
    'run_1980_1983',...
    'run_1990_1992',...
    'run_1995_1997',...
    'run_2004_2007',...
    'run_2007_2009',...
    'run_2012_2014',...
    'run_2016_1_DIAG',...
    'run_2017_DIAG',...
    };

for i = 1:10
    monthgoup(:,i) = [i i+1 i+2];
end
outdir = 'TP_Images\';

thevar = 'WQ_DIAG_TOT_TP';

% files = {...
%     'run_1979_1981_rst',...
%     'run_1980_1983_rst',...
%     'run_1990_1992_rst',...
%     'run_1995_1997_rst',...
%     'run_2004_2007_rst',...
%     'run_2007_2009_rst',...
%     'run_2012_2014_rst',...
%     'run_2016_DIAG',...
%     'run_2017_DIAG',...
%     };

basedir = 'J:\Matfiles_All\';


if ~exist(outdir,'dir')
    mkdir(outdir);
end


for i = 1:length(files)
    data(i) = load([basedir,files{i},'\',thevar,'.mat']);
end

infile='Z:\PEEL\run_1979_1981_MH.nc';
dat2 = tfv_readnetcdf(infile,'timestep',1);

vert(:,1) = dat2.node_X;
vert(:,2) = dat2.node_Y;

faces = dat2.cell_node';
faces(faces(:,4)== 0,4) = faces(faces(:,4)== 0,1);

for i = 1:10 %the number of monthgroups
    
    therange = monthgoup(:,i)';
    
    figure('position',[820.333333333333          89.6666666666667                      1598                      1248]);
    
    for j = 1:length(data)
        
        dvec = datevec(data(j).savedata.Time);
        
        sss = find(dvec(:,2) == therange(1) | dvec(:,2) == therange(2) | dvec(:,2) == therange(3) );
        
        thedata = data(j).savedata.(thevar).Top(:,sss);
        
        
        ss = find(thedata > 5000);
        
        if ~isempty(ss)
             TN = mean((thedata(:,1:end-1)),2);
        else
            TN = mean((thedata),2);
        end
        %TN(TN > 100) = NaN;
        TN = TN * 31/1000;
        
        subplot(3,3,j)
        
        
        patFig = patch('faces',faces,'vertices',vert,'FaceVertexCData',TN);shading flat
        set(gca,'box','on');
        axis off; axis equal;
        xlim([359539.955342554          397099.047835535]);
        ylim([6371426.53686695           6399903.3471592]);
        
        caxis([0 0.1]);
        
        text(0.1,0.1,[datestr(min(datenum(dvec(sss,1),dvec(sss,2),dvec(sss,3))),'ddmmyyyy'),' ',...
            datestr(max(datenum(dvec(sss,1),dvec(sss,2),dvec(sss,3))),'ddmmyyyy')],'units','normalized','fontsize',8);
        
        title([datestr(datenum(2018,therange(1),01),'mmm'),' ',...
            datestr(datenum(2018,therange(2),01),'mmm'),' ',...
            datestr(datenum(2018,therange(3),01),'mmm')],'fontsize',8);
            
        colorbar
        
    end
    
    %--% Paper Size
%     set(gcf, 'PaperPositionMode', 'manual');
%     set(gcf, 'PaperUnits', 'centimeters');
%     xSize = 40;
%     ySize = 40;
%     xLeft = (21-xSize)/2;
%     yTop = (30-ySize)/2;
%     set(gcf,'paperposition',[0 0 xSize ySize])
    
    
    fname = [outdir,'group_',num2str(i),'.png'];
    
    saveas(gcf,fname);
    
    close;
end
    
    
    
    
    
