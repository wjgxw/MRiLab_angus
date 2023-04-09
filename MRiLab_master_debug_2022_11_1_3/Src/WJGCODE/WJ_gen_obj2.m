% without gaussian filter
% generate deep learning samples 
% 2018.6.26 created by ANGUS XMU 
% 2018.11.18 add T2STAR
% 2019.5.20 add ADC
% 2019.6.29 add random ADC range
% 2020.7.25 T1>T2 and T1<3000 ms
%generate geomotrary randomly 

% = Base + random  texture
function out_obj = WJ_gen_obj2(sample_idx)
% loopj : the number of samples you want to generate
% you should change some paramerers
% 1. dirname: this directory should contain some images, you can download
% from the website
% 2. save_file: this parameter determine the output filename of your
% generated samples
%3. other parameter can be modified to adapt to your task.
%% parameters
warning ('off')
rng('shuffle');%the random seed
slice = 1;   % the slice number
ratio = 0.6;  % the weighting of texture
row = 500;      %   row=440 fov=22cm the resolution is 0.5ms
col = row;
fov = 0.22;     % Field of view
num = 200;      % the number of mask
T2max = 250; %250 % the maximum T2 value
ADC_max = 3.5e-3;   % the maximum ADC value,  handbook of MRI p961
%% generate samples with optical images
load('MY_OBJ1.mat')
output_dir = '/data3/wj/data_texture0.6T1/';
dirname = '/data3/wj/image/';
dirs=dir([dirname,'*.jpg']);
VObj.XDim = row;
VObj.YDim = col;
VObj.ZDim = slice;
VObj.XDimRes = fov/row;
VObj.YDimRes = fov/col;
VObj.ZDimRes=1e-3;
%% mask
temp_brain_mask = zeros(row,col);
temp_brain_mask(floor(row*0.1):floor(row*0.9),floor(col*0.1):floor(col*0.9))=1;  
%% generate samples
% the random shape should not be appear in the board of the fov
range = find(sum(temp_brain_mask,2)>0);
top = range(1)+row/20;
bottom = range(end)-row/10;
range = find(sum(temp_brain_mask,1)>0);
left = range(1)+col/20;
right = range(end)-col/10;
range = [top,bottom,left,right];
%the blank virtual object
temp_mask = zeros(row,col);
final_T1 = zeros(row,col);
final_T2 = zeros(row,col);
final_T2STAR = zeros(row,col);
final_Rho = zeros(row,col);
final_ADC = zeros(row,col);
thres_area = sum(temp_brain_mask(:))*0.1;
T2max_temp = T2max;%unifrnd(70,T2max);%T2max_temp = unifrnd(100,T2max);
ADC_max_temp = ADC_max;%unifrnd(0.5e-3,ADC_max);
for loopj = 1:num
    [final_T1,final_T2,final_T2STAR,final_Rho,final_ADC,temp_mask] =  WJGshape2(final_T1,final_T2,final_T2STAR,final_Rho,final_ADC,temp_mask,row,col,dirname,dirs,1,ratio,range,T2max_temp,ADC_max_temp);%circle
    [final_T1,final_T2,final_T2STAR,final_Rho,final_ADC,temp_mask] =  WJGshape2(final_T1,final_T2,final_T2STAR,final_Rho,final_ADC,temp_mask,row,col,dirname,dirs,3,ratio,range,T2max_temp,ADC_max_temp);%square
    [final_T1,final_T2,final_T2STAR,final_Rho,final_ADC,temp_mask] =  WJGshape2(final_T1,final_T2,final_T2STAR,final_Rho,final_ADC,temp_mask,row,col,dirname,dirs,4,ratio,range,T2max_temp,ADC_max_temp);% triangle  
    residual_mask = temp_brain_mask.*abs(temp_mask-temp_brain_mask);%%
    if (sum(residual_mask(:))<thres_area) 
        break;
    end
end
%% T1
final_T1 = final_T1.*temp_brain_mask;
final_T1 = (final_T1<=final_T2).*0+(final_T1>final_T2).*final_T1;
final_T1 = final_T1/1000;      %T1
%% T2 
final_T2 = final_T2.*temp_brain_mask;
final_T2 = final_T2/1000;    %T2
%% T2star    
final_T2STAR = final_T2STAR.*temp_brain_mask;
final_T2STAR = final_T2STAR/1000;    %T2
final_T2STAR = (final_T2STAR>=final_T2).*final_T2+(final_T2STAR<final_T2).*final_T2STAR;    %T2star should be less than T2
%% Rho	0-1
final_Rho = final_Rho.*temp_brain_mask;
final_Rho = final_Rho*1;    
%% ADC	
final_ADC = final_ADC.*temp_brain_mask;
%% generate models
Rho = final_Rho;
T1 = final_T1.*(final_Rho>0);     % setting all T1=2s
T2 = final_T2.*(final_Rho>0);
T2STAR = final_T2STAR.*(final_Rho>0);%	
ADC = final_ADC.*(final_ADC>0);
ECon = [];
MassDen  = [];
%     subplot(231);imagesc(T1,[0,3]);colormap(jet);axis off ;colorbar
%     subplot(232);imagesc(final_T2,[0,0.3]); colormap(jet);axis off ;colorbar
%     subplot(233);imagesc(final_Rho,[0,1]); colormap(jet);axis off ;colorbar
%     subplot(234);imagesc(final_T2STAR,[0,0.3]);colormap(jet);axis off ;colorbar
%     subplot(235);imagesc(final_ADC);colormap(jet);axis off ;colorbar
VObj.Rho = abs(Rho);VObj.T1 = abs(T1);VObj.T2 = abs(T2);VObj.T2Star = abs(T2STAR);VObj.ECon = abs(ECon);VObj.MassDen = abs(MassDen);VObj.WJG_ADC = abs(ADC);
out_obj = VObj;

save_file = [output_dir,num2str(sample_idx)];
save(save_file,'VObj')
sample_idx
