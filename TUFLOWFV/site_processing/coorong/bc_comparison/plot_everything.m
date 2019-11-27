clear all; close all;

    
dirlist = dir(['BC2/','*.csv']);

for i = 1:length(dirlist)
    disp(dirlist(i).name);
    data.(['bc_',regexprep(dirlist(i).name,'.csv','')]) = tfv_readBCfile(['BC2/',dirlist(i).name]);
    
end

save data.mat data -mat -v7.3;
    
mkdir('Images_All_2/BC/');

sites = fieldnames(data);

vars = fieldnames(data.(sites{1}));
%vars(end+1) = {'wl'};

%datearray = datenum(2007,01:6:85,01);
datearray = datenum(2014,01:06:37,01);

for i = 1:length(vars)
    figure
    if strcmpi(vars{i},'Date') == 0
        
        for j = 1:length(sites)
            name = regexprep(sites{j},'_','');
            
            if isfield(data.(sites{j}),vars{i})
                
                xdata = data.(sites{j}).Date;
                ydata = data.(sites{j}).(vars{i});
                
                plot(xdata,ydata,'displayname',name);hold on
                
                
            end
        end
        
        xlim([datearray(1) datearray(end)]);
        
        set(gca,'XTick',datearray,'XTickLabel',datestr(datearray,'dd-mm-yy'),'fontsize',6);
        
        ylabel(upper(regexprep(vars{i},'_',' ')),'fontsize',8);
        
        title(vars{i});
        
        legend('location','NW');
        
        %--% Paper Size
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 21;
        ySize = 8;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])
        
        %print(gcf,['Images_All/Guaged/',vars{i},'.eps'],'-depsc2','-painters');
        print(gcf,['Images_All_2/BC/',vars{i},'.png'],'-dpng','-zbuffer');
        
        close all;
        
    end
end

convert_html;