function [mface,mcolor,agencyname] = sort_agency_information(agency)


switch agency
    
    % Peel Swan
    case 'WIR'
        mface = 'ok';
        mcolor = [255/255 61/255 9/255];
        
    case 'MAFRL'
         mface = 'pk';
        mcolor = [232/255 90/255 24/255];
    case 'SCU'
         mface = 'dk';
        mcolor = [255/255 111/255 4/255];
    case 'MU'
         mface = 'sk';
        mcolor = [232/255 90/255 24/255];
     % Erie   
    case     'ECCC'
         mface = 'ok';
        mcolor = [255/255 61/255 9/255];
        
    case 'ECCC-CGM'
         mface = 'sk';
        mcolor = [255/255 61/255 9/255];
        
    case 'ECCC-PAR'
         mface = 'pk';
        mcolor = [255/255 61/255 9/255];
        
    case 'ECCC-WQ'
         mface = 'hk';
        mcolor = [255/255 61/255 9/255];
        
    case 'EPA'
         mface = 'dk';
        mcolor = [255/255 61/255 9/255];
        
    case 'OTHER (NYSDEC, OMNR and USGS)'
         mface = '^k';
        mcolor = [255/255 61/255 9/255];
        
    otherwise
           mface = 'ok';
        mcolor = [255/255 61/255 9/255];
        
end

agencyname = agency;
        
        
       