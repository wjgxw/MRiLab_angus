% MatrixUser, a multi-dimensional matrix analysis software package
% https://sourceforge.net/projects/matrixuser/
% 
% The MatrixUser is a matrix analysis software package developed under Matlab
% Graphical User Interface Developing Environment (GUIDE). It features 
% functions that are designed and optimized for working with multi-dimensional
% matrix under Matlab. These functions typically includes functions for 
% multi-dimensional matrix display, matrix (image stack) analysis and matrix 
% processing.
%
% Author:
%   Fang Liu <leoliuf@gmail.com>
%   University of Wisconsin-Madison
%   Aug-30-2014



function MU_func10N(Temp,Event,handles)
handles = guidata(handles.MU_matrix_display);

MergeM=get(handles.Matrix_name_edit,'String');
if isfloat(handles.TMatrix(1))
    set(handles.Matrix_name_edit,'String',['10.^[' MergeM ']']);
else
    set(handles.Matrix_name_edit,'String',['10.^double([' MergeM '])']);
end
MU_calc_matrix(handles);

end