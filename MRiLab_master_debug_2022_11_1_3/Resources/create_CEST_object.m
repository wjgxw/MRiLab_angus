%CEST
% angus XMU 
% 2018.4.3
clc
clear all
close all
load('D:\MRiLab_master\Resources\VObj\CEST')
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�Rho%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %����Rho
Rho = VObj.Rho;
[row,col,slice,type] = size(Rho);
WJG_Rho = zeros(row*2,col*2,slice,type);
%�޸�Rho
temp_Rho = Rho;
Rho3 = Rho(:,:,:,3);
temp_Rho(:,:,:,3) =Rho3*0.25;	WJG_Rho(1:end/2,1:end/2,:,:) = temp_Rho;
temp_Rho(:,:,:,3) =Rho3*0.5;	WJG_Rho(end/2+1:end,1:end/2,:,:) =temp_Rho;
temp_Rho(:,:,:,3) =Rho3*0.8;    WJG_Rho(1:end/2,end/2+1:end,:,:) = temp_Rho;
temp_Rho(:,:,:,3) =Rho3*1;      WJG_Rho(end/2+1:end,end/2+1:end,:,:) = temp_Rho;
Rho = WJG_Rho;
VObj.Rho = Rho;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T1%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %����T1
T1 = VObj.T1;
[row,col,slice,type] = size(T1);
WJG_T1 = zeros(row*2,col*2,slice,type);
%�޸�T1
temp_T1 = T1;
WJG_T1(1:end/2,1:end/2,:,:) = temp_T1;
WJG_T1(end/2+1:end,1:end/2,:,:) =temp_T1;
WJG_T1(1:end/2,end/2+1:end,:,:) = temp_T1;
WJG_T1(end/2+1:end,end/2+1:end,:,:) = temp_T1;
T1 = WJG_T1;
VObj.T1 = T1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T2%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %����T2
T2 = VObj.T2;
[row,col,slice,type] = size(T2);
WJG_T2 = zeros(row*2,col*2,slice,type);
%�޸�T2
temp_T2 = T2;
WJG_T2(1:end/2,1:end/2,:,:) = temp_T2;
WJG_T2(end/2+1:end,1:end/2,:,:) =temp_T2;
WJG_T2(1:end/2,end/2+1:end,:,:) = temp_T2;
WJG_T2(end/2+1:end,end/2+1:end,:,:) = temp_T2;
T2 = WJG_T2;
VObj.T2 = T2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T2Star%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %����T2
T2Star = VObj.T2Star;
[row,col,slice,type] = size(T2Star);
WJG_T2Star = zeros(row*2,col*2,slice,type);
%�޸�T2
temp_T2Star = T2Star;
WJG_T2Star(1:end/2,1:end/2,:,:) = temp_T2Star;
WJG_T2Star(end/2+1:end,1:end/2,:,:) =temp_T2Star;
WJG_T2Star(1:end/2,end/2+1:end,:,:) = temp_T2Star;
WJG_T2Star(end/2+1:end,end/2+1:end,:,:) = temp_T2Star;
T2Star = WJG_T2Star;
VObj.T2Star = T2Star;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�K%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %����K
K = VObj.K;
[row,col,slice,type] = size(K);
WJG_K = zeros(row*2,col*2,slice,type);
%�޸�K   ������
temp_K = K;
K4 = K(:,:,:,4);
temp_K(:,:,:,4) =K4*4;	WJG_K(1:end/2,1:end/2,:,:) = temp_K;
temp_K(:,:,:,4) =K4*2;    WJG_K(end/2+1:end,1:end/2,:,:) =temp_K;
temp_K(:,:,:,4) =K4*1.25;     WJG_K(1:end/2,end/2+1:end,:,:) = temp_K;
temp_K(:,:,:,4) =K4*1;      WJG_K(end/2+1:end,end/2+1:end,:,:) = temp_K;
K = WJG_K;
VObj.K = K;

VObj.XDim = 2*row;
VObj.YDim = 2*col;

save WJG_CEST VObj



