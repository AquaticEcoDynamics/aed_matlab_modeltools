clear all; close all;

aed = shaperead('E:\Github 2018\AED_Scripts\Matlab\TFV\Polygon Region Plotting\GIS\peel_polygons.shp');

load Export_Locations.mat;

dirlist = dir('Y:\Peel Final Report\Processed_v12_joined/');


bias_vars = {'SAL';'TEMP';'WQ_OXY_OXY';'WQ_NIT_AMM';'WQ_DIAG_PHY_TCHLA'};
bias_conv = [1 1 32/1000 14/1000 1];
load peel.mat;

fdata = peel;


sitenames = fieldnames(fdata);

for i = 1:length(sitenames)
    vars = fieldnames(fdata.(sitenames{i}));
    X(i) = fdata.(sitenames{i}).(vars{1}).X;
    Y(i) = fdata.(sitenames{i}).(vars{1}).Y;
end



for v = 1:length(bias_vars)
    
    mkdir(bias_vars{v});
    
    thedate = [];
    theTop = [];
    theBot = [];
    for i = 3:length(dirlist)
        disp(dirlist(i).name);
        
        load(['Y:\Peel Final Report\Processed_v12_joined/',dirlist(i).name,'/',bias_vars{v},'.mat']);
        thedate = [thedate;savedata.Time];
        theTop = [theTop savedata.(bias_vars{v}).Top];
        theBot = [theBot savedata.(bias_vars{v}).Bot];
        
    end
    
    theTop = theTop * bias_conv(v);
    theBot = theBot * bias_conv(v);
    
    mX = savedata.X;
    mY = savedata.Y;
    %%
    fid = fopen([bias_vars{v},'_','BIAS.csv'],'wt');
    
    fprintf(fid,'Site,Name,AED,Date,Surface,Bottom\n');
    for j = 1:length(shp)
        
        
        for k = 1:length(aed)
            if strcmpi(aed(k).Name,shp(j).AED_Name) == 1
                aed_inc = k;
            end
        end
        
        
        
        
        
        inpol = inpolygon(X,Y,aed(aed_inc).X,aed(aed_inc).Y);
        
        sss = find(inpol == 1);
        
        
        [f_date_top,f_top,f_date_bot,t_bot] = get_all_field_data(fdata,sss,bias_vars{v},bias_conv(v));
        
        
        
        
        
        
        mod_pol = inpolygon(mX,mY,shp(j).X,shp(j).Y);
        
        
        
        
        for l = 1:length(shp(j).Dates)
            fprintf(fid,'%s,%s,%s,%s,',shp(j).Codes{l},shp(j).Name,shp(j).AED_Name,datestr(shp(j).Dates(l)));
            
            mod_data_top = -999;
            mod_data_bot = -999;
            mean_ftop = -999;
            mean_fbot = -999;
            bias_t = -999;
            bias_b = -999;
            
            if ~isempty(t_bot)
                
                [~,mInd] = min(abs(thedate - shp(j).Dates(l)));
                
                if abs(thedate(mInd) - shp(j).Dates(l)) < 30
                    
                    mod_data_top = mean(mean(theTop(mod_pol,(mInd-20:mInd+20))));
                    mod_data_bot = mean(mean(theBot(mod_pol,(mInd-20:mInd+20))));
                    
                    
                    
                    
                    
                    
                    sss = find(f_date_top >= (thedate(mInd) - 2) & ...
                        f_date_top <= (thedate(mInd) + 2));
                    if ~isempty(sss)
                        bias_t = mean(f_top(sss))- mod_data_top;
                        mean_ftop = mean(f_top(sss));
                    end
                    
                    ttt = find(f_date_bot >= (thedate(mInd) - 2) & ...
                        f_date_bot <= (thedate(mInd) + 2));
                    if ~isempty(ttt)
                        bias_b = mean(t_bot(ttt)) - mod_data_bot;
                        mean_fbot =  mean(t_bot(ttt));
                        
                    end
                    
                    
                    
                end
                
                
                
                
                
            end
            fprintf(fid,'%4.4f,%4.4f,%4.4f,%4.4f,%4.4f,%4.4f\n',bias_t,bias_b,mod_data_top,mean_ftop,mod_data_bot, mean_fbot);
            
            
        end
        
        
        
        
    end
    fclose(fid);
    
    %%
    
    
    
    
    
    
    
    
    
    
    
end



