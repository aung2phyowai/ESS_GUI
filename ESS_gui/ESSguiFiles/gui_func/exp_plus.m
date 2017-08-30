% Usage: exp_plus
%
% Copyright (C) 2017, University of Oldenburg, Germany.
% Author : Manuela Jaeger M.Sc., manuela.jaeger@uni-oldenburg.de, Neuropsychology Lab, University of Oldenburg, Germany 
% Date   : 02.03.2017 
% Updated:  <>

% Add experimenter
k=k+1;
db.experimentersInfo(k).name=(' ');
db.experimentersInfo(k).role=(' ');

if k<=6
exp_name_stud(k) = uicontrol(...
    'Parent', fig1, ...
    'Units','normalized', 'Position', [0.25 0.23-((k-1)*0.04) 0.2 0.04], ...
    'Style', 'edit', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String', db.experimentersInfo(k).name,...
    'Callback','for a=1:k; db.experimentersInfo(a).name=strtrim(get(exp_name_stud(a),''String'')); end');

exp_role_stud(k) = uicontrol(...
    'Parent', fig1, ...
    'Units','normalized', 'Position', [0.63 0.23-((k-1)*0.04) 0.2 0.04], ...
    'Style', 'edit', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String', db.experimentersInfo(k).role,...
    'Callback','for a=1:k; db.experimentersInfo(a).role=strtrim(get(exp_role_stud(a),''String'')); end');
else
    k=6;
end