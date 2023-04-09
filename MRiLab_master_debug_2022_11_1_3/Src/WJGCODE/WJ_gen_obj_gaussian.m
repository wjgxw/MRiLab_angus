% generate deep learning samples 
% 2018.6.26 created by ANGUS XMU 
%  2018.11.18 add T2STAR
% 2018.12.3 generate samples from existing ones 

%generate geomotrary randomly 

% = Base+random  texture
function out_obj = WJ_gen_obj_gaussian(slice,loopj)
%slice ; % the slice number
global VCtl;
gausFilter = fspecial('gaussian',[16,16],4); 
rng('shuffle');%the random seed
dirname = VCtl.FILE_path;
dirs=dir([dirname,'*.mat']);
filename = [dirname,dirs(loopj).name];

load(filename);
VObj.XDimRes = VCtl.FOVFreq/VObj.XDim;
VObj.YDimRes = VCtl.FOVPhase/VObj.YDim;

VObj.T1 = imfilter(VObj.T1,gausFilter,'conv');
VObj.T2 = imfilter(VObj.T2,gausFilter,'conv');
VObj.T2Star = imfilter(VObj.T2Star,gausFilter,'conv');
VObj.Rho = imfilter(VObj.Rho,gausFilter,'conv');
VObj.WJG_ADC = imfilter(VObj.WJG_ADC,gausFilter,'conv');
out_obj = VObj;
