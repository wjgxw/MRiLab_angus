%�������ڻ���ѧϰ��ѵ������
%ֱ�Ӷ�ԭʼ��ͼģ�����ö��Ź�ѧͼ����е���
% by �⽡ XMU 
% 2018.4.5
%modified 2018.5.19
clc;clear all;close all;
%����������ɼ���ͼ��
num = 10;%����ͼ������
percent = 0.65;%ԭͼ�ı���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����MRiLabģ��
load('BrainHighResolution')
ori_slice = VObj.ZDim;
%�޸Ĳ���
col = 256;
VObj.YDim=col;
row = 256;
VObj.XDim=row;
slice = 500;
VObj.ZDim=slice;
%����Rho
Rho = VObj.Rho;
out_Rho = zeros(VObj.XDim,VObj.YDim,VObj.ZDim);
%����T1
T1 = VObj.T1;
out_T1 = zeros(VObj.XDim,VObj.YDim,VObj.ZDim);
%����T2
T2 =  VObj.T2;
out_T2 = zeros(VObj.XDim,VObj.YDim,VObj.ZDim);
%����T2Star
out_T2Star = zeros(VObj.XDim,VObj.YDim,VObj.ZDim);
%����ECon
ECon = zeros(VObj.XDim,VObj.YDim,VObj.ZDim,3);
%����MassDen
MassDen =zeros(VObj.XDim,VObj.YDim,VObj.ZDim);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������Ȼͼ����������ѵ������
%������Ȼͼ��
dirname = 'D:\Users\How\Desktop\angus\dataset\image\';
dirs=dir([dirname,'*.jpg']);
samples = length(dirs);

for loopi = 1:min([samples,slice])%��Ҫ�����Ի�ø�������
    rand_slice = randi([30,ori_slice],1);   %ǰ  �㲻Ҫ
    temp_brain_mask = Rho(:,:,rand_slice);%������Ĥ
    temp_brain_mask = abs(imresize(temp_brain_mask,[row,col],'nearest'));
    level = graythresh(temp_brain_mask);
    temp_brain_mask = im2bw(temp_brain_mask,level);
    se1=strel('disk',3);%�����Ǵ���һ���뾶Ϊ5��ƽ̹��Բ�̽ṹԪ��
    temp_brain_mask=imclose(temp_brain_mask,se1);%�ȿ��������;
%     imshow(temp_brain_mask,[])
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T1%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    weight = randi([1,100],[1,10]); %����10����������ڶ�ͼ����м�Ȩ���
    weight = weight/sum(weight(:))*(1-percent);%���� %������ǿ��
    final_T1 = T1(:,:,rand_slice)*percent;  
    final_T1 = abs(imresize(final_T1,[row,col],'nearest'));
    II1 = zeros(row,col);
    for loopj = 1:num
        frame_i = randi([1,samples],1); 
        filename = [dirname,dirs(frame_i).name];
        temp_I = abs(imresize(double(rgb2gray(imread(filename))),[row,col],'nearest'));
        temp_I = temp_I/max(temp_I(:));%��һ��
%         imshow(temp_I,[])
        II1 = II1 + temp_I*weight(loopj);
    end
    final_T1 = final_T1+II1*5;%T1��Χ0~5s 
    final_T1 = final_T1.*temp_brain_mask;
    out_T1(:,:,loopi) = final_T1;
    if(max(final_T1(:))>5.5)
        disp('T1 out of range')
        break;
    end
%     subplot(231);imshow(T1(:,:,rand_slice),[]); colormap(jet);title('T1');pause(0.001);
%     subplot(234);imshow(final_T1,[]); colormap(jet);title('T1');pause(0.001);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T2%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    weight = randi([1,100],[1,10]); %����10����������ڶ�ͼ����м�Ȩ���
    weight = weight/sum(weight(:))*(1-percent);%���� %������ǿ��
    final_T2 = T2(:,:,rand_slice)*percent;
    final_T2 = abs(imresize(final_T2,[row,col],'nearest'));
    II2 = zeros(row,col);
    for loopj = 1:num
        frame_i = randi([1,samples],1); 
        filename = [dirname,dirs(frame_i).name];
        temp_I = abs(imresize(double(rgb2gray(imread(filename))),[row,col],'nearest'));
        temp_I = temp_I/max(temp_I(:));%��һ��
        II2 = II2 + temp_I*weight(loopj);
    end
    final_T2 = final_T2+II2*2.2;%T2��Χ0~2.2s 
    final_T2 = final_T2.*temp_brain_mask;
    out_T2(:,:,loopi) = final_T2;
    if(max(final_T2(:))>2.3)
        disp('T2 out of range')
        break;
    end
%     subplot(232);imshow(T2(:,:,rand_slice),[]); colormap(jet);title('T2');pause(0.001);
%     subplot(235);imshow(final_T2,[]); colormap(jet);title('T2');pause(0.001);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�Rho%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    weight = randi([1,100],[1,10]); %����10����������ڶ�ͼ����м�Ȩ���
    weight = weight/sum(weight(:))*(1-percent);%���� %������ǿ��
    final_Rho = Rho(:,:,rand_slice)*percent;
    final_Rho = abs(imresize(final_Rho,[row,col],'nearest'));
    II3 = zeros(row,col);
    for loopj = 1:num
        frame_i = randi([1,samples],1); 
        filename = [dirname,dirs(frame_i).name];
        temp_I = abs(imresize(double(rgb2gray(imread(filename))),[row,col],'nearest'));
        temp_I = temp_I/max(temp_I(:));%��һ��
        II3 = II3 + temp_I*weight(loopj);
    end
    final_Rho = final_Rho+II3*1;%Rho��Χ0-1 
    final_Rho = final_Rho.*temp_brain_mask;
    out_Rho(:,:,loopi) = final_Rho;
    if(max(final_Rho(:))>1.2)
        disp('Rho out of range')
        break;
    end
%     subplot(233);imshow(Rho(:,:,rand_slice),[]); colormap(jet);title('Rho');pause(0.001);
%     subplot(236); imshow(final_Rho,[]); colormap(jet);title('Rho');pause(0.001) ;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T2Star%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���T2Star
    WJG_T2Star = final_T2;    %����T2��Ϊ
    out_T2Star(:,:,loopi) = WJG_T2Star;
    disp(loopi)
end
VObj.Rho = abs(out_Rho);VObj.T1 = abs(out_T1);VObj.T2 = abs(out_T2);VObj.T2Star = abs(out_T2Star);
VObj.ZDim = 500;
save WJG_DeepL1 VObj
%