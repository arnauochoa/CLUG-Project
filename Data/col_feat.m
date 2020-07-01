function [col, colnames] = col_feat()

%*************************************************************************
%     Copyright c2019 Ecole Nationale de l'Aviation Civile              
%                                                                       
%     Questions and comments should be directed to Carl Milner at:      
%     milner@recherche.enac.fr                                          
%*************************************************************************
%
% sets config parameters for features

% created 2020 Mar 30 by Carl Milner


col          = [];
                                       

n            = 0;                       


                                        % id features
n            = n + 1;
col.prn      = n;                       % prn
colnames{n}  = 'prn';

n            = n + 1;
col.const    = n;                       % const
colnames{n}  = 'const';



                                        % signal features
n            = n + 1;
col.s        = n;                       % signal to noise ratio at user
colnames{n}  = 's';

% n            = n + 1;
% col.ds       = n;                       % signal to noise ratio difference with reference station
% colnames{n}  = 'ds';
% 
% n            = n + 1;
% col.svar     = n;                       % signal to noise ratio variation
% colnames{n}  = 's_var';


                                        % geometry features

n            = n + 1;
col.el       = n;                       % elevation
colnames{n}  = 'el';                                        
                                       
n            = n + 1;
col.az       = n;                       % az
colnames{n}  = 'az';

n            = n + 1;
col.daz      = n;                       % relative azimuth to heading
colnames{n}  = 'daz';

                                        % detection features
% n            = n + 1;
% col.cmc      = n;                       % code minus carrier change
% colnames{n}  = 'cmc';

                     

                                        % topographic features
n            = n + 1;
col.maxtopo  = n;                       % max mask
colnames{n}  = 'maxtopo';

n            = n + 1;
col.maxtopor = n;                       % max mask right
colnames{n}  = 'maxtopor';

n            = n + 1;
col.maxtopol = n;                       % max mask left
colnames{n}  = 'maxtopol';

n            = n + 1;
col.visibility = n;                       % visibility
colnames{n}  = 'visibility';

col.max      = n;

