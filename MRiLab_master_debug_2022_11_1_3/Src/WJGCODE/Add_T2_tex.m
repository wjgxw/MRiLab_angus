function [T1_out,T2_out,T2STAR_out,Rho_out,ADC_out] =  Add_T2_tex(T1,T2,T2STAR,Rho,ADC,dirname,dirs,new_mask,ratio,T2max,ADC_max)

sigma = 8;    %gaussian filter
gausFilter = fspecial('gaussian',[8 8],sigma);

%minimum T2 = 16 ms maxium T2 = 400 ms
% minimum T2* =15 T2 maximum T2* = T2
%tissuse parameters
%        T1  T2 T2*[ms]  M0 CS[rad/sec]      Label

T2min = 20; %11     %2020.5.14
T2_temp = unifrnd(T2min,T2max);
T1_min = T2_temp;
T1_max = 3000;
T1_temp = unifrnd(T1_min,T1_max);  %2020.7.6
T2STARmin = 5;
T2STARmax = T2_temp;
T2STAR_temp =  unifrnd(T2STARmin,T2STARmax);
Rho_temp = unifrnd(0.1,1,1);
ADC_temp = unifrnd(0.4e-3,ADC_max,1);        %mm^2 S-1
samples = length(dirs);
[row,col] = size(T1);

%% T1
T1_base = double(ones(row,col)*T1_temp);% 
T1_base = abs(imresize(T1_base,[row,col],'nearest'));
% T1_base = abs(imfilter(T1_base,gausFilter,'replicate'));
frame_i = randi([1,samples],1); 
filename = [dirname,dirs(frame_i).name];
II1 = double(rgb2gray(imread(filename)))/255*T1_temp;% 
II1 = abs(imresize(II1,[row,col],'nearest'));
II1 = abs(imfilter(II1,gausFilter,'replicate'));
T1_out = new_mask.*II1*ratio+(new_mask.*T1_base*(1-ratio))+T1;  
% T1_out = T1_out.*(T1_out>=T1_min)+ T1_min.*(T1_out<T1_min);
%% T2
T2_base = double(ones(row,col)*T2_temp);% 
T2_base = abs(imresize(T2_base,[row,col],'nearest'));
% T2_base = abs(imfilter(T2_base,gausFilter,'replicate'));
frame_i = randi([1,samples],1); 
filename = [dirname,dirs(frame_i).name];
II2 = double(rgb2gray(imread(filename)))/255*T2_temp;% 
II2 = abs(imresize(II2,[row,col],'nearest'));
II2 = abs(imfilter(II2,gausFilter,'replicate'));
T2_out = new_mask.*II2*ratio+(new_mask.*T2_base*(1-ratio))+T2; 
% T2_out = T2_out.*(T2_out>=T2min)+ T2min.*((T2_out<T2min)&(T2_out~=0));

%% T2STAR
T2STAR_base = double(ones(row,col)*T2STAR_temp);% 
T2STAR_base = abs(imresize(T2STAR_base,[row,col],'nearest'));
% T2STAR_base = abs(imfilter(T2STAR_base,gausFilter,'replicate'));
frame_i = randi([1,samples],1); 
filename = [dirname,dirs(frame_i).name];
II3 = double(rgb2gray(imread(filename)))/255*T2STAR_temp;% 
II3 = abs(imresize(II3,[row,col],'nearest'));
II3 = abs(imfilter(II3,gausFilter,'replicate'));
T2STAR_out = new_mask.*II3*ratio+(new_mask.*T2STAR_base*(1-ratio))+T2STAR; 
% T2STAR_out = T2STAR_out.*(T2STAR_out>=T2STARmin)+ T2STARmin.*((T2STAR_out<T2STARmin)&(T2STAR_out~=0));

%% Rho
Rho_base = double(ones(row,col)*Rho_temp);% 
Rho_base = abs(imresize(Rho_base,[row,col],'nearest'));
% Rho_base = abs(imfilter(Rho_base,gausFilter,'replicate'));
frame_i = randi([1,samples],1); 
filename = [dirname,dirs(frame_i).name];
II4 = double(rgb2gray(imread(filename)))/255*Rho_temp;% 
II4 = abs(imresize(II4,[row,col],'nearest'));
II4 = abs(imfilter(II4,gausFilter,'replicate'));
ratio = ratio/2;
Rho_out = new_mask.*II4*ratio+(new_mask.*Rho_base*(1-ratio))+Rho; 

%% ADC
ADC_base = double(ones(row,col)*ADC_temp);% 
ADC_base = abs(imresize(ADC_base,[row,col],'nearest'));
% ADC_base = abs(imfilter(ADC_base,gausFilter,'replicate'));
frame_i = randi([1,samples],1); 
filename = [dirname,dirs(frame_i).name];
II5 = double(rgb2gray(imread(filename)))/255*ADC_temp;% 
II5 = abs(imresize(II5,[row,col],'nearest'));
II5 = abs(imfilter(II5,gausFilter,'replicate'));
ADC_out = new_mask.*II5*ratio+(new_mask.*ADC_base*(1-ratio))+ADC; 






