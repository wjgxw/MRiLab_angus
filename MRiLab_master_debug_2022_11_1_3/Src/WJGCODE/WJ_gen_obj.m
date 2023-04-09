% generate deep learning samples 
% 2018.6.26 created by ANGUS XMU 
%  2018.11.18 add T2STAR
% 2018.12.3 generate samples from existing ones 
% 2021.12.24 dirname changed to global VCtl.dirs

%generate geomotrary randomly 

% = Base+random  texture
function [filename,out_obj] = WJ_gen_obj(slice,loopj)
%slice ; % the slice number
global VCtl;
% rng('shuffle');%the random seed
dirname = VCtl.FILE_path;
% dirs=dir([dirname,'*.mat']);

filename = [dirname,VCtl.dirs(loopj).name];
load(filename);
% VObj.XDimRes = VCtl.FOVFreq/VObj.XDim;
% VObj.YDimRes = VCtl.FOVPhase/VObj.YDim;
% VObj.T1 = (VObj.T1>0.01).*1;
VObj.T1 = VObj.T1 ;
VObj.T2 = (VObj.T2<=0.3).*VObj.T2+(VObj.T2>0.3).*0.3 ;
VObj.T2Star = (VObj.T2Star<=VObj.T2).*VObj.T2Star+(VObj.T2Star>VObj.T2).*VObj.T2 ;
VObj.Rho = (VObj.Rho>=1).*1+(VObj.Rho<1).*VObj.Rho;

% VObj.T2Star = VObj.T2Star ;
out_obj = VObj;
filename = VCtl.dirs(loopj).name(1:end-4);
