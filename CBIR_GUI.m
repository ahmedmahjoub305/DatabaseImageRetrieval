function varargout = CBIR_GUI(varargin)
% CBIR_GUI MATLAB code for CBIR_GUI.fig
%      CBIR_GUI, by itself, creates a new CBIR_GUI or raises the existing
%      singleton*.
%
%      H = CBIR_GUI returns the handle to a new CBIR_GUI or the handle to
%      the existing singleton*.
%
%      CBIR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CBIR_GUI.M with the given input arguments.
%
%      CBIR_GUI('Property','Value',...) creates a new CBIR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CBIR_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CBIR_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CBIR_GUI

% Last Modified by GUIDE v2.5 13-Sep-2019 20:07:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CBIR_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @CBIR_GUI_OutputFcn, ...
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


% --- Executes just before CBIR_GUI is made visible.
function CBIR_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CBIR_GUI (see VARARGIN)

% Choose default command line output for CBIR_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CBIR_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CBIR_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
working_path = 'D:\Mahjoub Stuff\University Education\Degree studies\Year 3\Trimester 2\MM Technology & application\Assignment\dataset';
cd(working_path);
addpath(pwd);


global im;
[name, path] = uigetfile({'*.jpg'},'Select Query Image');
im = fullfile(path, name);
imshow(imread(im),'Parent', handles.axes1);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%open the workpath
global im
working_path = 'D:\Mahjoub Stuff\University Education\Degree studies\Year 3\Trimester 2\MM Technology & application\Assignment\dataset';
cd(working_path);
addpath(pwd);

load('database_cbir.mat', 'database');
input = str2double(get(handles.edit1,'String'));% Retrieve the input and change it to string
numIm = length(database)  ;% this give the number of images in database

%QueryFeatures = getColourHistHSV(im);
%QueryFeatures = getColourHistRGB(im);
QueryFeatures = getCNN(im);
Dist = zeros(1,numIm);

for i=1:numIm
    
    %ImagesFeatures = database(i).featHSV; 
    %ImagesFeatures = database(i).featRGB; 
    ImagesFeatures = database(i).featCNN;
  
  Dist(i) =  get_euclidian_dist(QueryFeatures,ImagesFeatures);
end
[sorted_dist,ImagesFeatures] = sort(Dist);

im_id = ImagesFeatures(2);           % for 2nd most similar use idx(3)
                                     %To exclude the query image we should not use idx(1)
imfile = database(im_id).imageName ;
imQ = imread(imfile);

figure(2), imshow(imfile) , title('Most Similar Image to Query (Exclude the query image)')

%sort the from the smallest dissimilarity to the 10th smallest
% id_list = [ImagesFeatures(1) ImagesFeatures(2) .....ImagesFeatures(10)] ;


ci = 0; nr = input;
id_list = ImagesFeatures(1:input) ;
figure();
for j=1:input
    if abs(id_list(j) - id_list(1)) < 100
        ci = ci+1;
    end
    id = id_list(j) ;
    imfile = database(id_list(j)).imageName ;
    label = database(id).label;
    str = sprintf('%d',label);  
    subplot(floor(input/3),4,j) , imshow(imfile) , title(str) ;
    %sorted_dist(id_list(j))
end

%this will calculate the precision of the labels once the dissimilarity is
%computed and sorted. ci is the number of matcing labels. nr is the total
%image diplayed
precision = ci/nr

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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

load('database_cbir.mat', 'database');
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
