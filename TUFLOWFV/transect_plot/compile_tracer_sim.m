function [data1] = compile_tracer_sim(ncfile)

shp = shaperead('../../../SCERM/matlab/tracer_simulation/ERZ_v2.shp');

data = tfv_readnetcdf(ncfile);

%%

zone.Ocean.WQ_DIAG_TOT_TN = 1;
zone.Ocean.WQ_DIAG_TOT_TP = 2;

for i = 1:12
    zone.(['ERZ_',num2str(i)]).WQ_DIAG_TOT_TN = (i*2)+1;
    zone.(['ERZ_',num2str(i)]).WQ_DIAG_TOT_TP = (i*2)+2;
end


%%

zone.ERZ_1.Upstream = [];
zone.ERZ_1.Downstream = [2:1:12];

zone.ERZ_2.Upstream = [1];
zone.ERZ_2.Downstream = [3:1:12];

zone.ERZ_3.Upstream = [1:2];
zone.ERZ_3.Downstream = [4:1:12];

zone.ERZ_4.Upstream = [1:3];
zone.ERZ_4.Downstream = [5:1:12];

zone.ERZ_5.Upstream = [1:4];
zone.ERZ_5.Downstream = [6:1:12];

zone.ERZ_6.Upstream = [];
zone.ERZ_6.Downstream = [1:5 7:12];

zone.ERZ_7.Upstream = [6];
zone.ERZ_7.Downstream = [1:5 8:12];

zone.ERZ_8.Upstream = [6:7];
zone.ERZ_8.Downstream = [1:5 9:12];

zone.ERZ_9.Upstream = [1:8];
zone.ERZ_9.Downstream = [10:12];

zone.ERZ_10.Upstream = [1:9];
zone.ERZ_10.Downstream = [11:12];

zone.ERZ_11.Upstream = [1:10];
zone.ERZ_11.Downstream = [12];

zone.ERZ_12.Upstream = [1:11];
zone.ERZ_12.Downstream = [];

%%
data1 = [];

data1.WQ_DIAG_TOT_TN.ocean = data.TRACE_1;
data1.WQ_DIAG_TOT_TP.ocean = data.TRACE_2;

data1.WQ_DIAG_TOT_TN.local(1:size(data.TRACE_1,1),1:size(data.TRACE_1,2)) = 0;
data1.WQ_DIAG_TOT_TP.local(1:size(data.TRACE_1,1),1:size(data.TRACE_1,2)) = 0;

data1.WQ_DIAG_TOT_TN.upstream(1:size(data.TRACE_1,1),1:size(data.TRACE_1,2)) = 0;
data1.WQ_DIAG_TOT_TP.upstream(1:size(data.TRACE_1,1),1:size(data.TRACE_1,2)) = 0;

data1.WQ_DIAG_TOT_TN.downstream(1:size(data.TRACE_1,1),1:size(data.TRACE_1,2)) = 0;
data1.WQ_DIAG_TOT_TP.downstream(1:size(data.TRACE_1,1),1:size(data.TRACE_1,2)) = 0;

%%

for i = 1:length(data.cell_X)
    disp(i);
    erz_zone = [];
    for k = 1:length(shp)
        inpol = find(inpolygon(data.cell_X(i),data.cell_Y(i),shp(k).X,shp(k).Y)==1);
        
        if ~isempty(inpol)
            
            erz_zone = shp(k).Id;
        end
    end
        
    sss = find(data.idx2 == i);
    
    data1.WQ_DIAG_TOT_TN.local(sss,:) = data.(['TRACE_',num2str(zone.(['ERZ_',num2str(erz_zone)]).WQ_DIAG_TOT_TN)])(sss,:);
    data1.WQ_DIAG_TOT_TP.local(sss,:) = data.(['TRACE_',num2str(zone.(['ERZ_',num2str(erz_zone)]).WQ_DIAG_TOT_TP)])(sss,:);
    
    ups = zone.(['ERZ_',num2str(erz_zone)]).Upstream;
    dws = zone.(['ERZ_',num2str(erz_zone)]).Downstream;
    
    if ~isempty(ups)
        for k = 1:length(ups)
            data1.WQ_DIAG_TOT_TN.upstream(sss,:) = data1.WQ_DIAG_TOT_TN.upstream(sss,:) + ...
                data.(['TRACE_',num2str(zone.(['ERZ_',num2str(ups(k))]).WQ_DIAG_TOT_TN)])(sss,:);
            data1.WQ_DIAG_TOT_TP.upstream(sss,:) = data1.WQ_DIAG_TOT_TP.upstream(sss,:) + ...
                data.(['TRACE_',num2str(zone.(['ERZ_',num2str(ups(k))]).WQ_DIAG_TOT_TP)])(sss,:);
        end
    end
    if ~isempty(dws)
        for k = 1:length(dws)
            data1.WQ_DIAG_TOT_TN.downstream(sss,:) = data1.WQ_DIAG_TOT_TN.downstream(sss,:) + ...
                data.(['TRACE_',num2str(zone.(['ERZ_',num2str(dws(k))]).WQ_DIAG_TOT_TN)])(sss,:);
            data1.WQ_DIAG_TOT_TP.downstream(sss,:) = data1.WQ_DIAG_TOT_TP.downstream(sss,:) + ...
                data.(['TRACE_',num2str(zone.(['ERZ_',num2str(dws(k))]).WQ_DIAG_TOT_TP)])(sss,:);
        end
    end
    
end

save data1.mat data1 -mat -v7.3;