function varargout = table_main(varargin)
% TABLE_MAIN MATLAB code for table_main.fig
%      TABLE_MAIN, by itself, creates a new TABLE_MAIN or raises the existing
%      singleton*.
%
%      H = TABLE_MAIN returns the handle to a new TABLE_MAIN or the handle to
%      the existing singleton*.
%
%      TABLE_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABLE_MAIN.M with the given input arguments.
%
%      TABLE_MAIN('Property','Value',...) creates a new TABLE_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before table_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to table_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help table_main

% Last Modified by GUIDE v2.5 18-Apr-2022 09:54:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @table_main_OpeningFcn, ...
                   'gui_OutputFcn',  @table_main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before table_main is made visible.
function table_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to table_main (see VARARGIN)

% Choose default command line output for table_main
clear global scom scan_timer vid line_timer gray_timer axPos frame frame_timer;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes table_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = table_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function inputPort_Callback(hObject, eventdata, handles)
% hObject    handle to inputPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputPort as text
%        str2double(get(hObject,'String')) returns contents of inputPort as a double


% --- Executes during object creation, after setting all properties.
function inputPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputBaudrate_Callback(hObject, eventdata, handles)
% hObject    handle to inputBaudrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputBaudrate as text
%        str2double(get(hObject,'String')) returns contents of inputBaudrate as a double


% --- Executes during object creation, after setting all properties.
function inputBaudrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputBaudrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonConnect.
function buttonConnect_Callback(hObject, eventdata, handles)
set(hObject,'Enable','off');
global scom;
scom = instrfind('Type', 'serial', 'Port', 'COM1', 'Tag', '');
if isempty(scom)
    port = get(handles.inputPort,'String');
    baudrate = str2double(get(handles.inputBaudrate,'String'));
    scom = serial(port,'BaudRate',baudrate,'Parity','none','DataBits',8,'StopBits',1);
    scom.Terminator = 'CR';
    scom.InputBufferSize = 1024;
    scom.OutputBufferSize = 1024;
    scom.Timeout = 0.5;
else
    fclose(scom);
    scom = scom(1);
end
fopen(scom);
fprintf('Port Opened\n');
set(hObject,'Enable','on');



% hObject    handle to buttonConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonDisconnect.
function buttonDisconnect_Callback(hObject, eventdata, handles)
global scom;
if isempty(scom)
    scom = instrfind('Type', 'serial', 'Port', 'COM3', 'Tag', '');
end
if isempty(scom)
    fprintf('Port Not Opened\n')
else
    fclose(scom);
    fprintf('Port Closed\n');
end
clear global scom;

% hObject    handle to buttonDisconnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function inputXPos_Callback(hObject, eventdata, handles)
% hObject    handle to inputXPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputXPos as text
%        str2double(get(hObject,'String')) returns contents of inputXPos as a double


% --- Executes during object creation, after setting all properties.
function inputXPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputXPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputYPos_Callback(hObject, eventdata, handles)
% hObject    handle to inputYPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputYPos as text
%        str2double(get(hObject,'String')) returns contents of inputYPos as a double


% --- Executes during object creation, after setting all properties.
function inputYPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputYPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonGetPos.
function buttonGetPos_Callback(hObject, eventdata, handles)
[pos,~] = QueryPos;
set(handles.inputXPos,'String', pos(1));
set(handles.inputYPos,'String', pos(2));
% set(handles.inputZPos,'String', pos(3));
% hObject    handle to buttonGetPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function inputZPos_Callback(hObject, eventdata, handles)
% hObject    handle to inputZPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputZPos as text
%        str2double(get(hObject,'String')) returns contents of inputZPos as a double


% --- Executes during object creation, after setting all properties.
function inputZPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputZPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonSetPos.
function buttonSetPos_Callback(hObject, eventdata, handles)
x = str2double(get(handles.inputXPos,'String'));
y = str2double(get(handles.inputYPos,'String'));
%z = str2double(get(handles.inputZPos,'String'));
%SetPos('xyz',[x,y,z]);
SetPos('xy',[x,y]);
% IsBusy(hObject);
[pos,~] = QueryPos;
set(handles.inputXPos,'String', pos(1));
set(handles.inputYPos,'String', pos(2));
%set(handles.inputZPos,'String', pos(3));
% hObject    handle to buttonSetPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over buttonConnect.
function buttonConnect_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to buttonConnect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonXStepMove.
function buttonXStepMove_Callback(hObject, eventdata, handles)
step = str2double(get(handles.inputXStepMove,'String'));
MovPos('x', step);
% IsBusy(hObject);
[pos,~] = QueryPos;
set(handles.inputXPos,'String', pos(1));
% hObject    handle to buttonXStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonYStepMove.
function buttonYStepMove_Callback(hObject, eventdata, handles)
step = str2double(get(handles.inputYStepMove,'String'));
MovPos('y', step);
% IsBusy(hObject);
[pos,~] = QueryPos;
set(handles.inputYPos,'String', pos(2));
% hObject    handle to buttonYStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonZStepMove.
function buttonZStepMove_Callback(hObject, eventdata, handles)
step = str2double(get(handles.inputZStepMove,'String'));
MovPos('z', step);
% IsBusy(hObject);
[pos,~] = QueryPos;
set(handles.inputZPos,'String', pos(3));
% hObject    handle to buttonZStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function inputXStepMove_Callback(hObject, eventdata, handles)
% hObject    handle to inputXStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputXStepMove as text
%        str2double(get(hObject,'String')) returns contents of inputXStepMove as a double


% --- Executes during object creation, after setting all properties.
function inputXStepMove_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputXStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputYStepMove_Callback(hObject, eventdata, handles)
% hObject    handle to inputYStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputYStepMove as text
%        str2double(get(hObject,'String')) returns contents of inputYStepMove as a double


% --- Executes during object creation, after setting all properties.
function inputYStepMove_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputYStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputZStepMove_Callback(hObject, eventdata, handles)
% hObject    handle to inputZStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputZStepMove as text
%        str2double(get(hObject,'String')) returns contents of inputZStepMove as a double


% --- Executes during object creation, after setting all properties.
function inputZStepMove_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputZStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputXScanStep_Callback(hObject, eventdata, handles)
% hObject    handle to inputXScanStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputXScanStep as text
%        str2double(get(hObject,'String')) returns contents of inputXScanStep as a double


% --- Executes during object creation, after setting all properties.
function inputXScanStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputXScanStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputYScanStep_Callback(hObject, eventdata, handles)
% hObject    handle to inputYScanStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputYScanStep as text
%        str2double(get(hObject,'String')) returns contents of inputYScanStep as a double


% --- Executes during object creation, after setting all properties.
function inputYScanStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputYScanStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputScanInterval_Callback(hObject, eventdata, handles)
% hObject    handle to inputScanInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputScanInterval as text
%        str2double(get(hObject,'String')) returns contents of inputScanInterval as a double


% --- Executes during object creation, after setting all properties.
function inputScanInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputScanInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputXScanCount_Callback(hObject, eventdata, handles)
% hObject    handle to inputXScanCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputXScanCount as text
%        str2double(get(hObject,'String')) returns contents of inputXScanCount as a double


% --- Executes during object creation, after setting all properties.
function inputXScanCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputXScanCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputYScanCount_Callback(hObject, eventdata, handles)
% hObject    handle to inputYScanCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputYScanCount as text
%        str2double(get(hObject,'String')) returns contents of inputYScanCount as a double


% --- Executes during object creation, after setting all properties.
function inputYScanCount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputYScanCount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputScanTolerance_Callback(hObject, eventdata, handles)
% hObject    handle to inputScanTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputScanTolerance as text
%        str2double(get(hObject,'String')) returns contents of inputScanTolerance as a double


% --- Executes during object creation, after setting all properties.
function inputScanTolerance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputScanTolerance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonScanStop.
function buttonScanStop_Callback(hObject, eventdata, handles)
global scan_timer
if ~isempty(scan_timer)
    index = get(handles.inputCal, 'String');
    StepScan(scan_timer,[],1,index,handles,[],[],[],[],[],[],[],[],[]);
else
    fprintf('Not Scanning\n');
end
% hObject    handle to buttonScanStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonScanStart.
function buttonScanStart_Callback(hObject, eventdata, handles)
set(hObject,'Enable','off');
global scan_timer;
if ~isempty(scan_timer)
    fprintf('Already Running!\n')
else
    index = get(handles.inputCal, 'String');
    scanInterval = str2double(get(handles.inputScanInterval,'String'));
    scanXCount = str2double(get(handles.inputXScanCount,'String'));
    scanYCount = str2double(get(handles.inputYScanCount,'String'));
    tolerance = str2double(get(handles.inputScanTolerance,'String'));
    scanXStep = str2double(get(handles.inputXScanStep,'String'));
    scanYStep = str2double(get(handles.inputYScanStep,'String'));
    path = get(handles.inputSaveLocation,'String');
    isGray = get(handles.checkboxApplyGrayscale,'Value');
    bound = str2double(get(handles.inputIntensityHigherBound,'String'));
    pauseInterval = str2double(get(handles.inputPauseInterval,'String'));
    scan_timer = timer('StartDelay',1,'Period',scanInterval,'ExecutionMode','fixedRate','TasksToExecute',scanYCount * scanXCount + 1);
    scan_timer.TimerFcn = {@StepScan, 0, index, handles, pauseInterval, scanXCount, scanYCount, scanXStep, scanYStep, tolerance, path, isGray, bound};
    start(scan_timer);
end
set(handles.buttonScanPause,'SelectionHighlight','off');
set(handles.buttonScanPause,'SelectionHighlight','off');
set(handles.buttonScanPause,'Enable','on');
% hObject    handle to buttonScanStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function inputExposure_Callback(hObject, eventdata, handles)
% hObject    handle to inputExposure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputExposure as text
%        str2double(get(hObject,'String')) returns contents of inputExposure as a double


% --- Executes during object creation, after setting all properties.
function inputExposure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputExposure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonPreview.
function buttonPreview_Callback(hObject, eventdata, handles)
% hObject    handle to buttonPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off');
global vid axPos;
global line_timer gray_timer frame_timer;
if ~isempty(line_timer)
    stop(line_timer);
    delete(line_timer);
    clear global line_timer;
end
if ~isempty(gray_timer)
    stop(gray_timer);
    delete(gray_timer);
    clear global gray_timer;
end
if ~isempty(frame_timer)
    stop(frame_timer);
    delete(frame_timer);
end
if isempty(axPos)
    axPos = get(handles.axesPreview, 'Position');
else
    set(handles.axesPreview, 'Position', axPos);
end

if ~isempty(vid)
    stoppreview(vid);
end

vinfo = imaqhwinfo;
adaptor = vinfo.InstalledAdaptors{1};
vformatno = get(handles.popupDevice, 'Value');
vformatlist = get(handles.popupDevice,'String');
vformat = vformatlist{vformatno};

vid = videoinput(adaptor, 1, vformat);
set(vid,'ReturnedColorSpace','grayscale');
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',1);
vid.FrameGrabInterval=1;

%

% Change following lines into comments only in testing
% TBD

src=getselectedsource(vid);
src.ExposureTime = str2double(get(handles.inputExposure,'String'));

%

axes(handles.axesPreview);
vidRes=vid.VideoResolution;
nBands=vid.NumberOfBands;
vid.ROIPosition = [0 0 vidRes(2) vidRes(1)];
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage);

interval = str2double(get(handles.inputExposure,'String'));
frame_timer = timer('Period',interval,'ExecutionMode','fixedRate');
frame_timer.TimerFcn = @(~,~)Frame;
pause(1);
start(frame_timer);
set(hObject,'Enable','on');

function Frame
global vid frame;
frame = getsnapshot(vid);



%{

% --- Executes on button press in buttonUpdateExT.
function buttonUpdateExT_Callback(hObject, eventdata, handles)
% hObject    handle to buttonUpdateExT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
global hImage;
stoppreview(vid);
% vid = videoinput('hamamatsu', 1, 'MONO16_2304x2304_SlowMode');
vid = videoinput('winvideo', 1, 'RGB24_960x540');
set(vid,'ReturnedColorSpace','grayscale');
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',1);
vid.FrameGrabInterval=1;
axes(handles.axesPreview);
% set(handles.axesPreview, 'Units', 'pixels', 'Position', [7, 68, 300, 300]);
vidRes=vid.VideoResolution;
nBands=vid.NumberOfBands;
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage);

%}

% --- Executes on button press in buttonSelectROI.
function buttonSelectROI_Callback(hObject, eventdata, handles)
% hObject    handle to buttonSelectROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off');
global vid axPos gray_timer frame_timer;
if isempty(gray_timer)
    axes(handles.axesPreview);
else
    axes(handles.axesGray);
    stop(gray_timer);
end
stop(frame_timer);
rectangleROI = imrect();
setColor(rectangleROI,'red');
rectangleROI = round(wait(rectangleROI));
axes(handles.axesPreview);
stoppreview(vid);
vidRes = vid.VideoResolution;
nBands=vid.NumberOfBands;
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
vid.ROIPosition = [rectangleROI(1) rectangleROI(2) rectangleROI(3) rectangleROI(4)];
newPos = [axPos(1), axPos(2) + axPos(4) - round(axPos(4)*vidRes(2)/rectangleROI(4)), round(axPos(3)*vidRes(1)/rectangleROI(3)), round(axPos(4)*vidRes(2)/rectangleROI(4))];
preview(vid,hImage);
pause(1);
start(frame_timer);
set(handles.axesPreview, 'Position', newPos);
if ~isempty(gray_timer)
    start(gray_timer);
end
set(hObject,'Enable','on');


% --- Executes on button press in buttonDrawLine.
function buttonDrawLine_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDrawLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off');
global  line_timer gray_timer;
if ~isempty(line_timer)
    stop(line_timer);
    delete(line_timer);
end
if isempty(gray_timer)
    axes(handles.axesPreview);
else
    axes(handles.axesGray);
    stop(gray_timer);
end
addpath('internal functions');
linewidth = 15;
lineSignal = imline();
setColor(lineSignal,'red');
lineSignal = wait(lineSignal);
line_x = [lineSignal(1,1) lineSignal(2,1)];
line_y = [lineSignal(1,2) lineSignal(2,2)];

%{

global vid;
axes(handles.axesPreview);
vidRes = vid.VideoResolution;
nBands=vid.NumberOfBands;
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage);

%}


lineinterval = str2double(get(handles.inputExposure,'String'));
ax = handles.axesLine;

line_timer = timer('Period',lineinterval,'ExecutionMode','fixedRate');
line_timer.TimerFcn = {@LineFrame, line_x, line_y, linewidth, ax};
start(line_timer);
if ~isempty(gray_timer)
    start(gray_timer);
end
set(hObject,'Enable','on');

function LineFrame(~,~, line_x, line_y, linewidth, ax)

global frame;
c = adjustSpectralLine(frame, line_x, line_y, linewidth);
spectrum = mean(c); 
plot(ax,spectrum);
drawnow;



function inputIntensityHigherBound_Callback(hObject, eventdata, handles)
% hObject    handle to inputIntensityHigherBound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputIntensityHigherBound as text
%        str2double(get(hObject,'String')) returns contents of inputIntensityHigherBound as a double


% --- Executes during object creation, after setting all properties.
function inputIntensityHigherBound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputIntensityHigherBound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonCal.
function buttonCal_Callback(hObject, eventdata, handles)
% hObject    handle to buttonCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off');
global frame;
calIndex = get(handles.inputCal,'String');
if get(handles.checkboxApplyGrayscale,'Value')
    bound = str2double(get(handles.inputIntensityHigherBound,'String'));
    frame_adj = imadjust(frame,[0 bound],[0 1]);
else
    frame_adj = frame;
end
path = get(handles.inputSaveLocation,'String');
filename=[path,'\', calIndex,'.tif'];
imwrite(frame_adj, filename,'tif');
set(handles.inputCal, 'String', num2str(str2double(calIndex)+1));
set(hObject,'Enable','on');



function inputCal_Callback(hObject, eventdata, handles)
% hObject    handle to inputCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputCal as text
%        str2double(get(hObject,'String')) returns contents of inputCal as a double


% --- Executes during object creation, after setting all properties.
function inputCal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputSaveIndex_Callback(hObject, eventdata, handles)
% hObject    handle to inputSaveIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputSaveIndex as text
%        str2double(get(hObject,'String')) returns contents of inputSaveIndex as a double


% --- Executes during object creation, after setting all properties.
function inputSaveIndex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputSaveIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonChooseLocation.
function buttonChooseLocation_Callback(hObject, eventdata, handles)
% hObject    handle to buttonChooseLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = uigetdir('./','Choose Saving Directory');
set(handles.inputSaveLocation,'String',pathname);



function inputSaveLocation_Callback(hObject, eventdata, handles)
% hObject    handle to inputSaveLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputSaveLocation as text
%        str2double(get(hObject,'String')) returns contents of inputSaveLocation as a double


% --- Executes during object creation, after setting all properties.
function inputSaveLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputSaveLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonDeleteTimer.
function buttonDeleteTimer_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDeleteTimer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off');
global line_timer gray_timer frame_timer;
buttonScanStop_Callback(hObject, eventdata, handles);
for timer = [line_timer gray_timer frame_timer]
    if ~isempty(timer)
        stop(timer);
        delete(timer);
    end
end
timers = timerfind;
if ~isempty(timers)
    stop(timers);
    delete(timers);
end
clear global line_timer gray_timer frame_timer;
fprintf('All timer deleted\n');
set(hObject,'Enable','on');


% --- Executes on button press in buttonExit.
function buttonExit_Callback(hObject, eventdata, handles)
% hObject    handle to buttonExit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off');
buttonDeleteTimer_Callback(hObject, eventdata, handles);
buttonDisconnect_Callback(hObject, eventdata, handles);
global vid;
if ~isempty(vid)
    stoppreview(vid);
    delete(vid);
end
clear global vid axPos frame;
close();


% --- Executes on button press in buttonScanPause.
function buttonScanPause_Callback(hObject, eventdata, handles)
set(hObject,'Enable','off');
global scan_timer;
if isempty(scan_timer)
    fprintf('No scanning tasks found\n');
else
    stop(scan_timer);
    fprintf('Scan Paused\n');
end
set(handles.buttonScanResume,'Enable','on');
set(handles.buttonScanCal,'Enable','on');
% hObject    handle to buttonScanPause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonScanCal.
function buttonScanCal_Callback(hObject, eventdata, handles)
global frame;
index = get(handles.inputCal, 'String');
calI = get(handles.textIndexI,'String');
calJ = get(handles.textIndexJ,'String');
count = get(handles.textCount,'String');
if get(handles.checkboxApplyGrayscale,'Value')
    bound = str2double(get(handles.inputIntensityHigherBound,'String'));
    frame_adj = imadjust(frame,[0 bound],[0 1]);
else
    frame_adj = frame;
end
path = get(handles.inputSaveLocation,'String');
filename=[path,'\',index,'_Cal_before_',calJ,'_',calI,'_#',count,'.tif'];
imwrite(frame_adj, filename,'tif');
fprintf('Calibration image taken\n');

% hObject    handle to buttonScanCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonScanResume.
function buttonScanResume_Callback(hObject, eventdata, handles)
set(hObject,'Enable','off');
global scan_timer;
if isempty(scan_timer)
    fprintf('No scanning tasks found\n');
else
    start(scan_timer);
    fprintf('Scan Resumed\n');
end
set(handles.buttonScanPause,'Enable','on');
set(handles.buttonScanCal,'Enable','off');
% hObject    handle to butto
% hObject    handle to buttonScanResume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonUpdateGrayscale.
function buttonUpdateGrayscale_Callback(hObject, eventdata, handles)
% hObject    handle to buttonUpdateGrayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Enable','off');
global  gray_timer;
if ~isempty(gray_timer)
    stop(gray_timer);
    delete(gray_timer);
end

interval = str2double(get(handles.inputExposure,'String'));
bound = str2double(get(handles.inputIntensityHigherBound,'String'));
ax = handles.axesGray;

gray_timer = timer('Period',interval,'ExecutionMode','fixedRate');
gray_timer.TimerFcn = {@GrayFrame, bound, ax};
start(gray_timer);
set(hObject,'Enable','on');

function GrayFrame(~,~, bound, ax)

global frame;
frame_adj = imadjust(frame,[0 bound],[0 1]);
imshow(frame_adj, 'Parent', ax);


% --- Executes on button press in checkboxApplyGrayscale.
function checkboxApplyGrayscale_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxApplyGrayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkboxApplyGrayscale



function inputPauseInterval_Callback(hObject, eventdata, handles)
% hObject    handle to inputPauseInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputPauseInterval as text
%        str2double(get(hObject,'String')) returns contents of inputPauseInterval as a double


% --- Executes during object creation, after setting all properties.
function inputPauseInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputPauseInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupDevice.
function popupDevice_Callback(hObject, eventdata, handles)
% hObject    handle to popupDevice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupDevice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupDevice


% --- Executes during object creation, after setting all properties.
function popupDevice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupDevice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

vinfo = imaqhwinfo;
adaptor = vinfo.InstalledAdaptors{1};
vinfo = imaqhwinfo(adaptor,'DeviceInfo');
formatsList = vinfo.SupportedFormats;
set(hObject,'String',formatsList);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
