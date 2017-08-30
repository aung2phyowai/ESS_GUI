% Usage: session_plus
%
% Copyright (C) 2017, University of Oldenburg, Germany.
% Author : Manuela Jaeger M.Sc., manuela.jaeger@uni-oldenburg.de, Neuropsychology Lab, University of Oldenburg, Germany 
% Date   : 02.03.2017 
% Updated:  <>

% Add a new session
s=s+1;
db.sessionTaskInfo(s)=db_clean.sessionTaskInfo(1);

db.sessionTaskInfo(s).dataRecording.startDateTime=datestr(now,'yyyymmddTHHMMSS');
db.sessionTaskInfo(s).dataRecording.recordingParameterSetLabel=db.recordingParameterSet.recordingParameterSetLabel;
db.sessionTaskInfo(s).sessionNumber=num2str(s);
db.sessionTaskInfo(s).subject.channelLocations=db.sessionTaskInfo(s-1).subject.channelLocations;

session_num(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0 1-(s*session_lim) 0.05 session_lim], ...
    'Style', 'edit', ...
    'Fontsize', 14, ...
    'Foregroundcolor', [0 0 1], ...
    'String', db.sessionTaskInfo(s).sessionNumber,... 
    'Callback','for a=1:s; db.sessionTaskInfo(a).sessionNumber=strtrim(get(session_num(a),''String'')); end');

date_session(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0.25 1-(s*session_lim) 0.11 session_lim], ...
    'Style', 'edit', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String', datestr(datenum(db.sessionTaskInfo(s).dataRecording.startDateTime,'yyyymmddTHHMMSS'),'dd.mm.yyyy HH:MM:SS'),...
    'Callback','for a=1:s; db.sessionTaskInfo(a).dataRecording.startDateTime=datestr(datenum(strtrim(get(date_session(a),''String'')),''dd.mm.yyyy HH:MM:SS''),''yyyymmddTHHMMSS''); end');

[tf]=ismember(db.sessionTaskInfo(s).taskLabel,taskLabel_item);
if tf == 0
    if isempty(db.sessionTaskInfo(s).taskLabel);
        db.sessionTaskInfo(s).taskLabel={' '};
    end
    taskLabel_item=[taskLabel_item(1:taskLabel_item_length) db.sessionTaskInfo(s).taskLabel];
end
taskLabel_session(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0.05 1-(s*session_lim) 0.07 session_lim], ...
    'Style', 'popup', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String',taskLabel_item,...
    'HorizontalAlignment','center',...
    'Callback','for a=1:s; db.sessionTaskInfo(a).taskLabel=taskLabel_item{get(taskLabel_session(a),''Value'')}; end');
    [tf, loc]=ismember(db.sessionTaskInfo(s).taskLabel,taskLabel_item);
    if loc ~= 0
    set(taskLabel_session(s),'Value',loc)
    end

labId_session(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0.12 1-(s*session_lim) 0.05 session_lim], ...
    'Style', 'edit', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String', db.sessionTaskInfo(s).labId,...
    'Callback','for a=1:s; db.sessionTaskInfo(a).labId=strtrim(get(labId_session(a),''String'')); end');

eventfile_session(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0.44 1-(s*session_lim) 0.18 session_lim], ...
    'Style', 'edit', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String', db.sessionTaskInfo(s).dataRecording.eventInstanceFile,...
    'Callback','for a=1:s; db.sessionTaskInfo(a).dataRecording.eventInstanceFile=strtrim(get(eventfile_session(a),''String'')); end');

file_session(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0.8 1-(s*session_lim) 0.18 session_lim], ...
    'Style', 'edit', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String', db.sessionTaskInfo(s).dataRecording.filename,...
    'Callback','for a=1:s; db.sessionTaskInfo(a).dataRecording.filename=strtrim(get(file_session(a),''String'')); end');

ofnap_session(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0.62 1-(s*session_lim) 0.18 session_lim], ...
    'Style', 'edit', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String', db.sessionTaskInfo(s).dataRecording.originalFileNameAndPath,...
    'Callback','for a=1:s; db.sessionTaskInfo(a).dataRecording.originalFileNameAndPath=strtrim(get(ofnap_session(a),''String'')); end');

rpsl_session(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0.36 1-(s*session_lim) 0.08 session_lim], ...
    'Style', 'edit', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'String', db.sessionTaskInfo(s).dataRecording.recordingParameterSetLabel,...
    'Callback','for a=1:s; db.sessionTaskInfo(a).dataRecording.recordingParameterSetLabel=strtrim(get(rpsl_session(a),''String'')); end');

sub_info(s) = uicontrol(...
    'Parent', session_panel2, ...
    'Units','normalized', 'Position', [0.17 1-(s*session_lim) 0.08 session_lim], ...
    'Style', 'push', ...
    'Fontsize', 10, ...
    'Foregroundcolor', [0 0 1], ...
    'Backgroundcolor', [0.8 0.8 0.8], ...
    'String', sprintf('Subject %.0f',s),...
    'Callback',{@subject});

% reload session_gui every 20th session to adapt session panel size
if mod(s,20)==0
    session_gui
    val=2/s;
    set(session_panel2,'Position',[0 (-session_tab_lim+1)*val 1 session_tab_lim])
    set(session_slider,'Value',val)
end

%eof