%create model for MRiLab
% by Angus XMU 
% 2019.5.19
clc
clear 
close all
mask_I = double(rgb2gray(imread('BrainTissue.bmp')));
load('../Src/WJGCODE/MY_OBJ1.mat')
[row,col] = size(VObj.Rho);
mask_I = round(imresize(mask_I,[row,col],'nearest'));
% figure;imshow(mask_I,[])
%index 
%background 255,cir1 0,cir2  195, cir3  127
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%change Rho%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change Rho
Rho = 1*(mask_I~=255)+0*(mask_I==255);
VObj.Rho = Rho;
% imshow(Rho,[])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%change T1%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change T1
T1 = 2*(mask_I~=255)+0*(mask_I==255);
VObj.T1 = T1;
% imshow(T1,[])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%change T2%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change T2
T2 = 0.2*(mask_I~=255)+0*(mask_I==255);
VObj.T2 = T2;
% imshow(T2,[])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%change T2Star%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change T2Star
T2Star = 0.2*(mask_I~=255)+0*(mask_I==255);
VObj.T2Star = T2Star;
% imshow(T2Star,[])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%changeECon%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change ECon
VObj.ECon = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%change MassDen%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change MassDen
VObj.MassDen = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%change ADC%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%change ADC  mm^2 S-1
WJG_ADC =  1.5*10^-3*(mask_I==0)+2*10^-3*(mask_I==195)+2.5*10^-3*(mask_I==127)+0*(mask_I==255);
VObj.WJG_ADC = WJG_ADC;
% imshow(WJG_ADC,[])

save WJG_diffusion VObj



