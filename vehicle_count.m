function varargout = vehicle_count(varargin)
% VEHICLE_COUNT MATLAB code for vehicle_count.fig
%      VEHICLE_COUNT, by itself, creates a new VEHICLE_COUNT or raises the existing
%      singleton*.
%
%      H = VEHICLE_COUNT returns the handle to a new VEHICLE_COUNT or the handle to
%      the existing singleton*.
%
%      VEHICLE_COUNT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VEHICLE_COUNT.M with the given input arguments.
%
%      VEHICLE_COUNT('Property','Value',...) creates a new VEHICLE_COUNT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vehicle_count_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vehicle_count_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vehicle_count

% Last Modified by GUIDE v2.5 15-Feb-2023 14:21:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vehicle_count_OpeningFcn, ...
                   'gui_OutputFcn',  @vehicle_count_OutputFcn, ...
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


% --- Executes just before vehicle_count is made visible.
function vehicle_count_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vehicle_count (see VARARGIN)

% Choose default command line output for vehicle_count
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vehicle_count wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vehicle_count_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function value_Callback(hObject, eventdata, handles)
% hObject    handle to value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value as text
%        str2double(get(hObject,'String')) returns contents of value as a double


% --- Executes during object creation, after setting all properties.
function value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, filepath] = uigetfile('*.jpg', 'Select an image file');
set(handles.path, 'String', strcat(filepath, filename));

    I = imread(strcat(filepath,filename)); 
    
    imshow(I, 'Parent', handles.img_area);
    axis off;  
    axis image; 


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.path, 'String', '');
set(handles.value, 'String', '');
set(handles.value2, 'String', '');



% --- Executes on button press in count.
function count_Callback(hObject, eventdata, handles)
% hObject    handle to count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    filename = get(handles.path, 'String');
    I = imread(filename); 

    
L=rgb2gray(I);
background=imopen(L,strel('disk',50));
I2=L-background;
se = strel('ball',15,15);
I2=imerode(L,se);
I3=imadjust(I2);
level=graythresh(I3);
bw=im2bw(I3,level);
bw=bwareaopen(bw,100);
I7=imcomplement(bw);
I8=imfill(I7,'hole');
bw2=imopen(I8,strel('disk',25));
cc=bwconncomp(bw2,4);
set(handles.value,'String',num2str(cc.NumObjects) );
if cc.NumObjects == 14
    set(handles.value2,'String', 'Maximum Limit Reached');
else
    set(handles.value2,'String', num2str(14 - cc.NumObjects));
end
    
    


function path_Callback(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of path as text
%        str2double(get(hObject,'String')) returns contents of path as a double


% --- Executes during object creation, after setting all properties.
function path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function value2_Callback(hObject, eventdata, handles)
% hObject    handle to value2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value2 as text
%        str2double(get(hObject,'String')) returns contents of value2 as a double


% --- Executes during object creation, after setting all properties.
function value2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
