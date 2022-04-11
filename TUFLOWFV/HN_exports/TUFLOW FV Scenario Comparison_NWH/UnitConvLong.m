
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%Parameter Conversion from AED to human language
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [ConversionFactor,ParamStdName,ParamUnit,ParamYLim] = UnitConvLong(Parameter)
    switch Parameter
        case 'D'
            ConversionFactor = 1;
            ParamStdName = 'Depth';
            ParamUnit = '(m)';
            ParamYLim = inf;
        case 'H'
            ConversionFactor = 1;
            ParamStdName = 'Water Level';
            ParamUnit = '(mAHD)';
            ParamYLim = inf;
        case 'SAL'
            ConversionFactor = 1;
            ParamStdName = 'Salinity';
            ParamUnit = '(g/L)';
            ParamYLim = 5;
        case 'TEMP'
            ConversionFactor = 1;
            ParamStdName = 'Temperature';
            ParamUnit = '(^oC)';
            ParamYLim = 27;
        case 'WQ_DIAG_OXY_SAT'
            ConversionFactor = 1;
            ParamStdName = 'Dissolved Oxygen Saturation';
            ParamUnit = '(%)';
            ParamYLim = 130;
        case 'WQ_DIAG_TOT_TSS'
            ConversionFactor = 1;
            ParamStdName = 'TSS';
            ParamUnit = '(mg/L)';
            ParamYLim = 120;
        case 'WQ_OXY_OXY'
            ConversionFactor = 0.032;
            ParamStdName = 'Dissolved Oxygen';
            ParamUnit = '(mg/L)';
            ParamYLim = 10;
        case 'WQ_SIL_RSI'
            ConversionFactor = 0.028;
            ParamStdName = 'Silicates';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_NIT_AMM'
            ConversionFactor = 0.014;
            ParamStdName = 'Ammonia';
            ParamUnit = '(mg/L)';
            ParamYLim = 0.15;
        case 'WQ_NIT_NIT'
            ConversionFactor = 0.014;
            ParamStdName = 'NOx';
            ParamUnit = '(mg/L)';
            ParamYLim = 1.5;
        case 'WQ_PHS_FRP'
            ConversionFactor = 0.031;
            ParamStdName = 'FRP';
            ParamUnit = '(mg/L)';
            ParamYLim = 0.06;
        case 'WQ_PHS_FRP_ADS'
            ConversionFactor = 0.031;
            ParamStdName = 'Adsorbed FRP';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_DOC'
            ConversionFactor = 0.012;
            ParamStdName = 'Dissolved Organic Carbon';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_POC'
            ConversionFactor = 0.012;
            ParamStdName = 'Particulate Organic Carbon';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_DON'
            ConversionFactor = 0.014;
            ParamStdName = 'Dissolved Organic Nitrogen';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_PON'
            ConversionFactor = 0.014;
            ParamStdName = 'Particulate Organic Nitrogen';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_DOP'
            ConversionFactor = 0.031;
            ParamStdName = 'Dissolved Organic Phosphorus';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_POP'
            ConversionFactor = 0.031;
            ParamStdName = 'Particulate Organic Phosphorus';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_DIAG_PHY_TCHLA'
            ConversionFactor = 1;
            ParamStdName = 'Total Chlorophyll-a';
            ParamUnit = '(\mug/L)';
            ParamYLim = 30;
        case 'WQ_DIAG_TOT_TN'
            ConversionFactor = 0.014;
            ParamStdName = 'Total Nitrogen';
            ParamUnit = '(mg/L)';
            ParamYLim = 3;
        case 'WQ_DIAG_TOT_TP'
            ConversionFactor = 0.031;
            ParamStdName = 'Total Phosphorus';
            ParamUnit = '(mg/L)';
            ParamYLim = 0.2;
        case 'WQ_PHY_GRN'
            ConversionFactor = 1;
            ParamStdName = 'Green Phytoplankton';
            ParamUnit = '(\mug/L)';
            ParamYLim = inf;
        case 'WQ_PHY_BGA'
            ConversionFactor = 1;
            ParamStdName = 'Blue-green Phytoplankton';
            ParamUnit = '(\mug/L)';
            ParamYLim = inf;
        case 'WQ_PHY_FDIAT'
            ConversionFactor = 1;
            ParamStdName = 'Freshwater Diatom';
            ParamUnit = '(\mug/L)';
            ParamYLim = inf;
        case 'WQ_PHY_MDIAT'
            ConversionFactor = 1;
            ParamStdName = 'Marine Diatom';
            ParamUnit = '(\mug/L)';
            ParamYLim = inf;
        case 'WQ_TRC_TR1'
            ConversionFactor = 1;
            ParamStdName = 'Ecoli';
            ParamUnit = '(cfu/100mL)';
            ParamYLim = inf;
        case 'WQ_TRC_TR2'
            ConversionFactor = 1;
            ParamStdName = 'Enterococci';
            ParamUnit = '(cfu/100mL)';
            ParamYLim = inf;
        otherwise
            error('Parameter not recognised')            
    end        
end