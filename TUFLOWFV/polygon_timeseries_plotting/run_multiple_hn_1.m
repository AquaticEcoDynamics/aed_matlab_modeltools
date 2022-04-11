clear all; close all;


%Cattai Validation 2013 & 2017
%________________________________
%plottfv_polygon Cattai_2017_WQ_val
%plottfv_polygon Cattai_2013_WQ_val

%Cattai Yearly Scenarios
%________________________________
%plottfv_polygon Cattai_2013_WQ
%plottfv_polygon Cattai_2013_WQ_2015

%HN Yearly Scenarios
%________________________________
%plottfv_polygon Hawkesbury_2013_WQ_SC; %Hawkesbury 2013
%plottfv_polygon Hawkesbury_2013_WQ_SC_CC; %Cattai 2013 (Different ylim)
%plottfv_polygon Hawkesbury_2013_WQ_SC_2015;%Hawkesbury 2014
%plottfv_polygon Hawkesbury_2013_WQ_SC_2015_CC; %Cattai 2014 (Different ylim)
%
%
%%HN Validations
%plottfv_polygon Hawkesbury_2013_WQ_SC_val;
%plottfv_polygon Hawkesbury_2013_WQ_SC_val_CC;



%%HN Comparsion
%%________________________________
plottfv_polygon Hawkesbury_2013_WQ_SC_Comparison;
plottfv_polygon Hawkesbury_2013_WQ_SC_Comparison_CC;

%cd ../transect_plot
%
%%Scenario Transec Plots
%%plottfv_transect Cattai_2013_WQ_SC
%plottfv_transect Hawkesbury_2013_WQ_SC_Cattai
%plottfv_transect Hawkesbury_2013_WQ_SC

