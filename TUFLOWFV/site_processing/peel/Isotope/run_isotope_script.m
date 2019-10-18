

ncfile = 'D:\Simulations\Peel\Peel_WQ_model_v7_2016_2017_Nth_Corner_Construction\Output\sim_2016_2017_Open_diag.nc';

addmodel =0;




ylimits = [];


% WQ_DIAG_ISO_del15NNOx
% WQ_DIAG_ISO_del18ONOx

 outdir = 'Images/WQ_DIAG_ISO_del18ONOx/';
 
 for i = 2016:2017
     for j = 1:12
         
         varname = 'WQ_DIAG_ISO_del18ONOx';
 
         sdate = datenum(i,j,01);
         edate = datenum(i,j+2,01);
         
         
         disp(datestr(sdate,'yyyy-mmm'));
 
         
         filename = ['WQ_DIAG_ISO_del18ONOx ',num2str(i),' ',datestr(sdate,'mm'),'.png'];
         
         
         plottfv_peel_isotope_transect(varname,outdir,sdate,edate,'savename',filename,'ylim',[-10 100],'addmodel',0,'ncfile',ncfile);
     end
 end
 
 outdir = 'Images/WQ_DIAG_ISO_del15NNOx/';
 
 for i = 2016:2017
     for j = 1:12
         
         varname = 'WQ_DIAG_ISO_del15NNOx';
 
         sdate = datenum(i,j,01);
         edate = datenum(i,j+2,01);
         
         
         disp(datestr(sdate,'yyyy-mmm'));
 
         
         filename = ['WQ_DIAG_ISO_del15NNOx ',num2str(i),' ',datestr(sdate,'mm'),'.png'];
         
         
         plottfv_peel_isotope_transect(varname,outdir,sdate,edate,'savename',filename,'ylim',[-10 100],'addmodel',0,'ncfile',ncfile);
     end
 end
 
 


% outdir = 'Images/SAL/';
% for i = 2016:2017
%     for j = 1:12
%         varname = 'SAL';
%         
%         sdate = datenum(i,j,01);
%         edate = datenum(i,j+1,01);
%         
%         
%         disp(datestr(sdate,'yyyy-mmm'));
% 
%         
%         filename = ['SAL ',num2str(i),' ',datestr(sdate,'mmm'),'.png'];
%         
%         
%         plottfv_peel_isotope_transect(varname,outdir,sdate,edate,'savename',filename,'ylim',[0 75],'addmodel',1,'ncfile',ncfile);
%     end
% end
% 
% outdir = 'Images/WQ_OXY_OXY/';
% for i = 2016:2017
%    for j = 1:12
%        varname = 'WQ_OXY_OXY';
%        
%        sdate = datenum(i,j,01);
%        edate = datenum(i,j+1,01);
%        
%        
%        disp(datestr(sdate,'yyyy-mmm'));
% 
%        
%        filename = ['WQ_OXY_OXY ',num2str(i),' ',datestr(sdate,'mm'),'.png'];
%        
%        
%        plottfv_peel_isotope_transect(varname,outdir,sdate,edate,'savename',filename,'ylim',[0 350],'addmodel',1,'ncfile',ncfile);
%    end
% end