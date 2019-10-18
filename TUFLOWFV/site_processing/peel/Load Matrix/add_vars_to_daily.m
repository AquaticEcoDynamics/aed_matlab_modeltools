clear all; close all;

load daily.mat;

sites = fieldnames(daily);

for i = 1:length(sites)
    
    dates = daily.(sites{i}).D.Date;
    for j = 1:length(dates)
        
        daily.(sites{i}).Cyano.Data(j) = calc_hab(daily.(sites{i}).V_x.Data_Top(j),daily.(sites{i}).V_y.Data_Top(j),...
            daily.(sites{i}).TEMP.Data_Top(j),daily.(sites{i}).TEMP.Data_Bot(j),...
            daily.(sites{i}).SAL.Data_Top(j),daily.(sites{i}).SAL.Data_Bot(j),...
            daily.(sites{i}).WQ_NIT_AMM.Data_Top(j),daily.(sites{i}).WQ_NIT_NIT.Data_Top(j),...
            daily.(sites{i}).WQ_PHS_FRP.Data_Top(j),0);
        
         daily.(sites{i}).Dino.Data(j) = calc_hab(daily.(sites{i}).V_x.Data_Top(j),daily.(sites{i}).V_y.Data_Top(j),...
            daily.(sites{i}).TEMP.Data_Top(j),daily.(sites{i}).TEMP.Data_Bot(j),...
            daily.(sites{i}).SAL.Data_Top(j),daily.(sites{i}).SAL.Data_Bot(j),...
            daily.(sites{i}).WQ_NIT_AMM.Data_Top(j),daily.(sites{i}).WQ_NIT_NIT.Data_Top(j),...
            daily.(sites{i}).WQ_PHS_FRP.Data_Top(j),1);
        
        daily.(sites{i}).WQI.Data(j) = calc_hsi(daily.(sites{i}).WQ_OXY_OXY.Data_Bot(j),daily.(sites{i}).WQ_DIAG_PHY_TCHLA.Data_Top(j),...
            max(daily.(sites{i}).WQ_DIAG_TOT_TN.Data_Bot(j),daily.(sites{i}).WQ_DIAG_TOT_TN.Data_Top(j)),...
            max(daily.(sites{i}).WQ_PHS_FRP.Data_Bot(j),daily.(sites{i}).WQ_PHS_FRP.Data_Top(j)));
        
    end
    daily.(sites{i}).Cyano.Date = dates;
    daily.(sites{i}).Dino.Date = dates;
    daily.(sites{i}).WQI.Date = dates;
end

save daily_all.mat daily -mat;


plot(daily.Harvey_North.WQI.Date,daily.Harvey_North.WQI.Data,'r.');hold on
plot(daily.Peel_Estuary_3.WQI.Date,daily.Peel_Estuary_3.WQI.Data,'b.');hold on

plot(daily.Harvey_South.WQI.Date,daily.Harvey_South.WQI.Data,'k.');hold on


datetick('x');
