clear all; close all;

load export_Locations.mat;


for i = 1:length(shp)
    if strcmpi(shp(i).Name,'Val44') == 1
        stop
    end
end

load('Y:\Peel Final Report\Processed v11/');


inp = inpolygon(savedata.X,savedata.Y,shp(i).X,shp(i).Y);

savedata.D(inp,1)


%count = 0;

% for i = 1:length(shp)
%     if isempty(shp(i).Dates)
%         disp(shp(i).Name);
%     end
%     
%     count = count + length(shp(i).Dates);
% end
% 
% [snum,sstr] = xlsread('Spreadsheets/Copy of Export Template_CH 9 July 2019.xlsx',...
%     'Offshore template','A8:E10000');
% 
% Name = sstr(:,1);
% ID = sstr(:,2);
% 
% mdates(:,1) = datenum(snum(:,1),snum(:,2),snum(:,3));
% 
% 
% [snum,sstr] = xlsread('Spreadsheets/Copy of Export Template_CH 9 July 2019.xlsx',...
%     'Nearshore template','A8:E10000');
% 
% Name = [Name;sstr(:,1)];
% ID = [ID;sstr(:,2)];
% mdates = [mdates;datenum(snum(:,1),snum(:,2),snum(:,3))];
% %length(Name)
% 
% sName = [];
% sID = [];
% sDate = [];
% 
% for i = 1:length(shp)
%     sDate = [sDate;shp(i).Dates];
%     sName = [sName;shp(i).Codes];
%     for j = 1:length(shp(i).Dates)
%         sID = [sID;{shp(i).Name}];
%     end
% end
% 
% 
% stop



% for i = 1:length(Name)
%     nfound = 0;
%     for j = 1:length(shp)
%         sss = find(strcmpi(shp(j).Codes,Name{i}) == 1 & shp(j).Dates == mdates(i));
%         if ~isempty(sss)
%             nfound = 1;
%         end
%     end
%     if nfound == 0
%         disp([Name{i},' ',ID{i},' ',datestr(mdates(i))]);
%         nfound2 = 0;
%         for k = 1:length(shp)
%             ttt = find(strcmpi(shp(k).Name,ID{i})==1);
%             if ~isempty(ttt)
%                 nfound2 = 1;
%             end
%         end
%         if nfound2 == 0
%             disp(ID{i});
%         end
%             
%     end
% end

% for i = 1:length(shp)
%     if strcmpi(shp(i).Name,'Val91') == 1
%         stop
%     end
% end


