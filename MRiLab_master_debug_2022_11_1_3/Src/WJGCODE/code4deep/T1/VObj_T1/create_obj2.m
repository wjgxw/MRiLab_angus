%create model for MRiLab
% by Angus XMU 
% 2019.7.15
clear
clc

load('../../../BrainHighResolution')
%% parameters
row = 500;
col = 500;
slice = 1;
fov = 0.22;
fovz = 3e-3; %3 mm
%% process
load('mask500.mat');
I_final2 = imresize(I_final2,[row,col],'nearest');
mask = I_final2;
% mask = circshift(mask,[0,-260]);
% mask = circshift(mask,[0,-150]);
mask = circshift(mask,[0,-90]);
imshow(mask,[])
Rho_final = zeros(row,col,1);
T2_final = zeros(row,col,1);
T2star_final = zeros(row,col,1);
T1_final = zeros(row,col,1);

T2_temp = mask.*1;%mask*0.02*loopi;
T2star_temp = T2_temp;
T1_temp = mask.*2;%mask*0.02*loopi;
Rho_temp = mask.*1;%mask*0.02*loopi;
Rho_final = Rho_final+Rho_temp;
T2_final = T2_final+T2_temp;
T2star_final = T2star_final+T2star_temp;
T1_final = T1_final+T1_temp;

VObj.Rho = repmat(Rho_final,[1,1,slice]);
VObj.T1 = repmat(T1_final,[1,1,slice]);
VObj.T2 = repmat(T2_final,[1,1,slice]);
VObj.T2Star = repmat(T2star_final,[1,1,slice]);
VObj.ECon = [];
VObj.MassDen = [];
VObj.XDim=row;
VObj.YDim=col;
VObj.ZDim=slice;
VObj.XDimRes = fov/row;
VObj.YDimRes = fov/col;
VObj.ZDimRes = fovz/slice;
save mask500VObj VObj



