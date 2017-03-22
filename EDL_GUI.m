function varargout = EDL_GUI(varargin)
% EDL_GUI MATLAB code for EDL_GUI.fig
%      EDL_GUI, by itself, creates a new EDL_GUI or raises the existing
%      singleton*.
%
%      H = EDL_GUI returns the handle to a new EDL_GUI or the handle to
%      the existing singleton*.
%
%      EDL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDL_GUI.M with the given input arguments.
%
%      EDL_GUI('Property','Value',...) creates a new EDL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EDL_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EDL_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EDL_GUI

% Last Modified by GUIDE v2.5 01-Mar-2017 17:52:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EDL_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @EDL_GUI_OutputFcn, ...
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


% --- Executes just before EDL_GUI is made visible.
function EDL_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EDL_GUI (see VARARGIN)

% Choose default command line output for EDL_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EDL_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EDL_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.NaCl.ElectrolyteConcentration=5+(get(hObject,'Value')-get(hObject,'Min'))/(get(hObject,'Max')-get(hObject,'Min'))*95;
handles.NaCl=handles.NaCl.Solver;

str=get(handles.plot_option,'String');
val=get(handles.plot_option,'Value');

if val==1
    plot(handles.NaCl.xmesh,handles.NaCl.PotentialProfiles)
  
    xlabel('Position m')
    ylabel('Potential V')
    title(['ElectrolyteConcentration ',num2str(handles.NaCl.ElectrolyteConcentration),'mM, ElectrodePotential ',num2str(handles.NaCl.Potential),'V'])
else
    plot(handles.NaCl.xmesh_charge,handles.NaCl.ChargeDensity)
    
    xlabel('Position m')
    ylabel('ChargeDensity C/m^3')
    title(['ElectrolyteConcentration ',num2str(handles.NaCl.ElectrolyteConcentration),'mM, ElectrodePotential ',num2str(handles.NaCl.Potential),'V'])
end
text_str = sprintf(['Debye Length ',num2str(handles.NaCl.Debye),'m\nPotential at OHP ',num2str(handles.NaCl.InnerPotential),'V\nDifferential Capacitance ',num2str(handles.NaCl.diff_C),' F/m^2']);
set(handles.text3,'string',text_str)
guidata(hObject,handles);



% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.NaCl.Potential=-.8+(get(hObject,'Value')-get(hObject,'Min'))/(get(hObject,'Max')-get(hObject,'Min'))*1.6;
handles.NaCl=handles.NaCl.Solver;


val=get(handles.plot_option,'Value');

if val==1
    plot(handles.NaCl.xmesh,handles.NaCl.PotentialProfiles)
    
    xlabel('Position m')
    ylabel('Potential V')
    title(['ElectrolyteConcentration ',num2str(handles.NaCl.ElectrolyteConcentration),'mM, ElectrodePotential ',num2str(handles.NaCl.Potential),'V'])
else
    plot(handles.NaCl.xmesh_charge,handles.NaCl.ChargeDensity)
    
    xlabel('Position m')
    ylabel('ChargeDensity C/m^3')
    title(['ElectrolyteConcentration ',num2str(handles.NaCl.ElectrolyteConcentration),'mM, ElectrodePotential ',num2str(handles.NaCl.Potential),'V'])
end

text_str = sprintf(['Debye Length ',num2str(handles.NaCl.Debye),'m\nPotential at OHP ',num2str(handles.NaCl.InnerPotential),'V\nDifferential Capacitance ',num2str(handles.NaCl.diff_C),' F/m^2']);
set(handles.text3,'string',text_str)
guidata(hObject,handles);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
keyboard;


% --------------------------------------------------------------------
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function GCS_Callback(hObject, eventdata, handles)
% hObject    handle to GCS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function steric_PB_Callback(hObject, eventdata, handles)
% hObject    handle to steric_PB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function PVC_Callback(hObject, eventdata, handles)
% hObject    handle to PVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function to_csv_Callback(hObject, eventdata, handles)
% hObject    handle to to_csv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hChildren = get(handles.axes1,'Children');
 xData1 = get(hChildren(1),'XData');
 yData1 = get(hChildren(1),'YData');
 Data1=zeros(length(xData1),2);
 Data1(:,1)=xData1;
 Data1(:,2)=yData1;
 [Savefile,Savepath] = uiputfile('*.csv','export to csv');
 if Savefile==0
else
 Savefilename=fullfile(Savepath,Savefile);
 csvwrite(Savefilename,Data1);
 end


% --------------------------------------------------------------------
function superposition_Callback(hObject, eventdata, handles)
% hObject    handle to superposition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[Openfilename, Openpathname, filterindex] = uigetfile( ...
  '*.csv', ...
   'Select the reverse_plot data', ...
   'MultiSelect', 'on');
if Openpathname==0
else
    cla(handles.axes1)
    axes(handles.axes1);
    
   
    hold all
     
   
     for i=1:length(Openfilename)
         Openfname=fullfile(Openpathname,Openfilename{i});
         data=csvread(Openfname);
         plot(data(:,1),data(:,2))
     end
     legend(Openfilename)
     hold off
end


% --------------------------------------------------------------------
function PVC_output_Callback(hObject, eventdata, handles)
% hObject    handle to PVC_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Potential=linspace(-1,1,100);
handles.C=zeros(1,100);
for i=1:100
    handles.NaCl.Potential=handles.Potential(i);
    handles.NaCl=handles.NaCl.Solver;
    handles.C(i)=handles.NaCl.diff_C;
end
 plot(handles.Potential,handles.C)
 xlabel('Potential V')
 ylabel('Differential Capacitance F/m^2')


% --- Executes on selection change in plot_option.
function plot_option_Callback(hObject, eventdata, handles)
% hObject    handle to plot_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



val=get(handles.plot_option,'Value');

if val==1
    plot(handles.NaCl.xmesh,handles.NaCl.PotentialProfiles)
    
    xlabel('Position m')
    ylabel('Potential V')
    title(['ElectrolyteConcentration ',num2str(handles.NaCl.ElectrolyteConcentration),'mM, ElectrodePotential ',num2str(handles.NaCl.Potential),'V'])
else
    plot(handles.NaCl.xmesh_charge,handles.NaCl.ChargeDensity)
    
    xlabel('Position m')
    ylabel('ChargeDensity C/m^3')
    title(['ElectrolyteConcentration ',num2str(handles.NaCl.ElectrolyteConcentration),'mM, ElectrodePotential ',num2str(handles.NaCl.Potential),'V'])
end
guidata(hObject,handles);


% Hints: contents = cellstr(get(hObject,'String')) returns plot_option contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plot_option


% --- Executes during object creation, after setting all properties.
function plot_option_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plot_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

NaCl=EDL;
NaCl.ElectrolyteConcentration=5;
NaCl.Potential=-.8;
handles.NaCl=NaCl;
guidata(hObject,handles);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles.NaCl.C_inner=str2double(get(handles.edit1,'string'));
handles.NaCl=handles.NaCl.Solver;

val=get(handles.plot_option,'Value');

if val==1
    plot(handles.NaCl.xmesh,handles.NaCl.PotentialProfiles)
    
    xlabel('Position m')
    ylabel('Potential V')
    title(['ElectrolyteConcentration ',num2str(handles.NaCl.ElectrolyteConcentration),'mM, ElectrodePotential ',num2str(handles.NaCl.Potential),'V'])
else
    plot(handles.NaCl.xmesh_charge,handles.NaCl.ChargeDensity)
    
    xlabel('Position m')
    ylabel('ChargeDensity C/m^3')
    title(['ElectrolyteConcentration ',num2str(handles.NaCl.ElectrolyteConcentration),'mM, ElectrodePotential ',num2str(handles.NaCl.Potential),'V'])
end
guidata(hObject,handles);


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
