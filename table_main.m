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

% Last Modified by GUIDE v2.5 15-Feb-2022 01:15:19

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
clear global scom scan_timer vid line_timer axPos;
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
global scom;
scom = instrfind('Type', 'serial', 'Port', 'COM3', 'Tag', '');
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
pos = QueryPos;
set(handles.inputXPos,'String', pos(1));
set(handles.inputYPos,'String', pos(2));
set(handles.inputZPos,'String', pos(3));
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
z = str2double(get(handles.inputZPos,'String'));
SetPos('xyz',[x,y,z]);
IsBusy(hObject);
pos = QueryPos;
set(handles.inputXPos,'String', pos(1));
set(handles.inputYPos,'String', pos(2));
set(handles.inputZPos,'String', pos(3));
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
pos = QueryPos;
x = str2double(pos(1));
step = str2double(get(handles.inputXStepMove,'String'));
SetPos('x', x + step);
IsBusy(hObject);
pos = QueryPos;
set(handles.inputXPos,'String', pos(1));
% hObject    handle to buttonXStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonYStepMove.
function buttonYStepMove_Callback(hObject, eventdata, handles)
pos = QueryPos;
y = str2double(pos(2));
step = str2double(get(handles.inputYStepMove,'String'));
SetPos('y', y + step);
IsBusy(hObject);
pos = QueryPos;
set(handles.inputYPos,'String', pos(2));
% hObject    handle to buttonYStepMove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonZStepMove.
function buttonZStepMove_Callback(hObject, eventdata, handles)
pos = QueryPos;
z = str2double(pos(3));
step = str2double(get(handles.inputZStepMove,'String'));
SetPos('z', z + step);
IsBusy(hObject);
pos = QueryPos;
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
    stop(scan_timer);
    delete(scan_timer); 
    index = get(uiHandles.inputSaveIndex, 'String');
    set(uiHandles.inputSaveIndex,'String',num2str(index + 1));
    fprintf('Scan Interrupted\n')
end
% hObject    handle to buttonScanStop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonScanStart.
function buttonScanStart_Callback(hObject, eventdata, handles)
global scan_timer;
if ~isempty(timerfind)
    fprintf('Already Running!\n')
else
    %global scanInterval scanXCount scanYCount 
    scanInterval = str2double(get(handles.inputScanInterval,'String')) / 1000;
    scanXCount = str2double(get(handles.inputXScanCount,'String'));
    scanYCount = str2double(get(handles.inputYScanCount,'String'));
    tolerance = str2double(get(handles.inputScanTolerance,'String'));
    scanXStep = str2double(get(handles.inputXScanStep,'String'));
    scanYStep = str2double(get(handles.inputYScanStep,'String'));
    scan_timer = timer('StartDelay',1,'Period',scanInterval,'ExecutionMode','fixedRate','TasksToExecute',scanYCount * scanXCount + 1);
    scan_timer.TimerFcn = {@StepScan, handles, scanInterval, scanXCount, scanYCount, scanXStep, scanYStep, tolerance};
    start(scan_timer);
end
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
global vid axPos;
global line_timer;
if ~isempty(line_timer)
    stop(line_timer);
    delete(line_timer);
    clear global line_timer;
end
if ~isempty(vid)
    stoppreview(vid);
end
if isempty(axPos)
    axPos = get(handles.axesPreview, 'Position');
else
    set(handles.axesPreview, 'Position', axPos);
end

% vid = videoinput('hamamatsu', 1, 'MONO16_2304x2304_FasterMode');
vid = videoinput('winvideo', 1, 'RGB24_960x540');
set(vid,'ReturnedColorSpace','grayscale');
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',1);
vid.FrameGrabInterval=1;

%{

% Change following lines into comments only in testing
% TBD

src=getselectedsource(vid);
src.ExposureTime = str2double(get(handles.inputExposure,'String'));
intensityHigherBound = str2double(get(handles.inputIntensityHigherBound,'String'));

%}

axes(handles.axesPreview);
% set(handles.axesPreview, 'Units', 'pixels', 'Position', [7, 68, 300, 300]);
vidRes=vid.VideoResolution;
nBands=vid.NumberOfBands;
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage);

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
global vid axPos;
axes(handles.axesPreview);
% frame=getsnapshot(vid);
% imagesc(frame);
% title('Select the ROI');
rectangleROI = imrect();
setColor(rectangleROI,'red');
rectangleROI = round(wait(rectangleROI));
stoppreview(vid);
vidRes = vid.VideoResolution;
nBands=vid.NumberOfBands;
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
vid.ROIPosition = [rectangleROI(1) rectangleROI(2) rectangleROI(3) rectangleROI(4)];
newPos = [axPos(1), axPos(2) + axPos(4) - round(axPos(4)*vidRes(2)/rectangleROI(4)), round(axPos(3)*vidRes(1)/rectangleROI(3)), round(axPos(4)*vidRes(2)/rectangleROI(4))];
preview(vid,hImage);
% frame=getsnapshot(vid);
% axes(handles.axesROI);
set(handles.axesPreview, 'Position', newPos);
% set(handles.axesROI, 'Units', 'pixels', 'Position', [16, 73, 300*rectangleROI(3)/rectangleROI(4), 300]);
% imagesc(frame);

%{

% --- Executes on button press in buttonROIDyCam.
function buttonROIDyCam_Callback(hObject, eventdata, handles)
% hObject    handle to buttonROIDyCam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
num1 = str2double(get(handles.inputIntensityHigherBound,'String'));
% set(handles.axesROI, 'Units', 'pixels', 'Position', [16, 73, 300*rectangleROI(3)/rectangleROI(4),300]);
while (1)
    axes(handles.axesROI);
	frame=getsnapshot(vid);	
    frame_ad = imadjust(frame,[0 num1],[0 1]);
    imshow(frame_ad);
	drawnow;
end

%}

% --- Executes on button press in buttonDrawLine.
function buttonDrawLine_Callback(hObject, eventdata, handles)
% hObject    handle to buttonDrawLine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid line_timer;
if ~isempty(line_timer)
    stop(line_timer);
    delete(line_timer);
    clear global line_timer;
end
% num1 = str2double(get(handles.inputIntensityHigherBound,'String'));
% i=0;
addpath('internal functions');
linewidth = 15;
%frame=getsnapshot(vid);
%frame_ad = imadjust(frame,[0 num1],[0 1]);
%imshow(frame_ad);
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

%{

axes(handles.axesLine);
while (1)
%     preview(vid);
%     i=i+1;
	% axes(handles.axesROI);
	frame=getsnapshot(vid);	
    % frame_ad = imadjust(frame,[0 num1],[0 1]);
    % imshow(frame_ad);
    c = adjustSpectralLine(frame, line_x, line_y, linewidth);
    spectrum = mean(c); 
    plot(spectrum);
    % title('Dynamic Intensity Curve');
	drawnow;
%     start(vid);
%     stoppreview(vid);
%     filename=['F:\matlab control\',num2str(i),'.tif'];
%     imwrite(getdata(vid), filename,'tif');
%     stop(vid);

end

%}

lineinterval = str2double(get(handles.inputExposure,'String'));
ax = handles.axesLine;
line_timer = timer('Period',lineinterval,'ExecutionMode','fixedRate');
line_timer.TimerFcn = {@LineFrame, line_x, line_y, linewidth, ax};
start(line_timer);

function LineFrame(~,~, line_x, line_y, linewidth, ax)

global vid;
frame=getsnapshot(vid);
filename=['C:\Users\Arthur Li\Documents\MATLAB\Brillouin Scan\test.tif'];
imwrite(frame, filename,'tif');
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
global vid;
num2 = str2double(get(handles.inputCal,'String'));
preview(vid);
frame=getsnapshot(vid);
axes(handles.axesROI);
% set(handles.axesROI, 'Units', 'pixels', 'Position', [12, 138, 144*rectangleROI(3)/rectangleROI(4),144]);
imshow(frame);
drawnow;
start(vid);
stoppreview(vid);
filename=['F:\20200211_1\cab\',num2str(num2),'.tif'];
imwrite(getdata(vid), filename,'tif');
stop(vid);
preview(vid);



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
