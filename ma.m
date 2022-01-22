function varargout = ma(varargin)
% MA MATLAB code for ma.fig
%      MA, by itself, creates a new MA or raises the existing
%      singleton*.
%
%      H = MA returns the handle to a new MA or the handle to
%      the existing singleton*.
%
%      MA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MA.M with the given input arguments.
%
%      MA('Property','Value',...) creates a new MA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ma_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ma_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ma

% Last Modified by GUIDE v2.5 17-Jan-2022 10:21:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ma_OpeningFcn, ...
                   'gui_OutputFcn',  @ma_OutputFcn, ...
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


% --- Executes just before ma is made visible.
function ma_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ma (see VARARGIN)

% Choose default command line output for ma
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ma wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ma_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
global hImage;
vid = videoinput('hamamatsu', 1, 'MONO16_2304x2304_SlowMode');
set(vid,'ReturnedColorSpace','grayscale');
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',1);
vid.FrameGrabInterval=1;
src=getselectedsource(vid);
axes(handles.axes1);
set(handles.axes1, 'Units', 'pixels', 'Position', [19.4, 64.2, 256, 144]);
vidRes=vid.VideoResolution;
nBands=vid.NumberOfBands;
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
global hImage;
stoppreview(vid);
vid = videoinput('hamamatsu', 1, 'MONO16_2304x2304_SlowMode');
set(vid,'ReturnedColorSpace','grayscale');
set(vid,'TriggerRepeat',Inf);
set(vid,'FramesPerTrigger',1);
vid.FrameGrabInterval=1;
src=getselectedsource(vid);
num = str2double(get(handles.edit1,'String'));
src.ExposureTime = num;
% Get Axes
axes(handles.axes1);
set(handles.axes1, 'Units', 'pixels', 'Position', [19.4, 64.2, 256, 144]);
vidRes=vid.VideoResolution;
nBands=vid.NumberOfBands;
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
preview(vid,hImage);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
global hImage;
global tmp;
axes(handles.axes2);
frame=getsnapshot(vid);
imagesc(frame);title('Select the ROI');
tmp = imrect();
setColor(tmp,'red');
tmp = round(wait(tmp));
stoppreview(vid);
vid.ROIPosition = [tmp(1) tmp(2) tmp(3) tmp(4)];
preview(vid);
frame=getsnapshot(vid);
axes(handles.axes2);
set(handles.axes2, 'Units', 'pixels', 'Position', [25, 64.2, 144*tmp(3)/tmp(4), 144]);
imagesc(frame);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
global tmp;
axes(handles.axes2);
set(handles.axes2, 'Units', 'pixels', 'Position', [25, 64.2, 144*tmp(3)/tmp(4),144]);
while (1)
	frame=getsnapshot(vid);	
    imshow(frame);
	drawnow;
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global vid;
global hImage;
addpath('internal functions');
linewidth = 15;
axes(handles.axes2);
frame=getsnapshot(vid);
imshow(frame);
tmp = imline();
setColor(tmp,'red');
tmp = wait(tmp);
line_x = [tmp(1,1) tmp(2,1)];
line_y = [tmp(1,2) tmp(2,2)];
while (1)
	axes(handles.axes2);
	frame=getsnapshot(vid);	
    imshow(frame);
    c = adjustSpectralLine(frame, line_x, line_y, linewidth);
    spectrum = mean(c)'; 
	axes(handles.axes3);
    plot(spectrum);title('Dynamic Intensity Curve');
% 	imhist(frame);title('直方�?);
	drawnow;
end


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
uiwait;

% --- Executes on button press in Continue.
function Continue_Callback(hObject, eventdata, handles)
uiresume();

% --- Executes on button press in Finish.
function Finish_Callback(hObject, eventdata, handles)
close(gcf);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2);
frame=getsnapshot(vid);
incontrast(frame);
