%clear all; close all;

base_dir = 'Y:\Peel Final Report\Processed_v12_joined\run_2016_2018_joined\';

oxy = load([base_dir,'WQ_OXY_OXY.mat']);
age = load([base_dir,'WQ_TRC_AGE.mat']);
sal = load([base_dir,'SAL.mat']);
D =   load([base_dir,'D.mat']);


shp = shaperead('rivers.shp');

outdir = '2016/';

if ~exist(outdir,'dir')
    mkdir(outdir);
end

datearray = datenum(2016,04,01:07:365,12,00,00);

period = '2016-18';

for i = 1:length(datearray)
    
    filename = [outdir,datestr(datearray(i),'yyyymmddHHMMSS'),'_M2','.csv'];
    
    fid1 = fopen(filename,'wt');
    
    filename = [outdir,datestr(datearray(i),'yyyymmddHHMMSS'),'_M1','.csv'];
    
    fid2 = fopen(filename,'wt');
    
    filename = [outdir,datestr(datearray(i),'yyyymmddHHMMSS'),'_M3','.csv'];
    
    fid3 = fopen(filename,'wt');
    
    fprintf(fid1,'Cell,Age,Oxy,Sal,Hypoxia,Period\n');
    fprintf(fid2,'Cell,Age,Oxy,Sal,Hypoxia,Period\n');
    fprintf(fid3,'Cell,Age,Oxy,Sal,Hypoxia,Period\n');
    
    [~,ind]  = min(abs(age.savedata.Time - datearray(i)));
    
    A_age = age.savedata.WQ_TRC_AGE.Bot(:,ind) / 86400;
    A_oxy = oxy.savedata.WQ_OXY_OXY.Bot(:,ind) * (32/1000);
    A_sal = sal.savedata.SAL.Bot(:,ind);
    A_depth = D.savedata.D(:,ind);
    
    
    hypo = calc_hypo(oxy,datearray(i));
    
    X = sal.savedata.X;
    Y = sal.savedata.Y;
   
    
    for j = 1:length(A_age)
        
        if inpolygon(X(j),Y(j),shp.X,shp.Y) & A_depth(j) <=  1.5
            fprintf(fid1,'%d,%4.4f,%4.4f,%4.4f,%4.4f,%s\n',j,A_age(j),A_oxy(j),A_sal(j),hypo(j),period);
        else
            if inpolygon(X(j),Y(j),shp.X,shp.Y) & A_depth(j) >  1.5
                fprintf(fid2,'%d,%4.4f,%4.4f,%4.4f,%4.4f,%s\n',j,A_age(j),A_oxy(j),A_sal(j),hypo(j),period);
            else
                fprintf(fid3,'%d,%4.4f,%4.4f,%4.4f,%4.4f,%s\n',j,A_age(j),A_oxy(j),A_sal(j),hypo(j),period);
            end
        end
        
        
    end
    fclose(fid1);
    fclose(fid2);
    fclose(fid3);
end
    
    
    
    