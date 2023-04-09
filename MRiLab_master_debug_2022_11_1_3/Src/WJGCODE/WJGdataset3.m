%�������ڻ���ѧϰ��ѵ������
%����ͼ��
% by �⽡ XMU 
% 2018.6.25
clc;clear all;close all;
%����������ɼ���ͼ��
%�����ĳߴ�
row = 500;      %   row=440��ͼ��fovΪ22cm����ʱ�ֱ���Ϊ0.5ms
col = row;
slice = 100; %������������
num = 100;      %��Ĥ����
sigma = 1.3;    %���ڸ�˹�˲�
gausFilter = fspecial('gaussian',[3 3],sigma);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������Ȼͼ������ѵ������
%���������ͼ�ε��ڲ����и�ֵ
%������Ȼͼ��
dirname = 'D:\Users\How\Desktop\angus\dataset\image\';
dirs=dir([dirname,'*.jpg']);
samples = length(dirs);
load('brain_mask');
mask_num = size(brain_mask,3);
for sam_loop =2:10 %���������϶࣬����ֳɼ���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����MRiLabģ��
    load('BrainHighResolution')
    %�޸Ĳ���
    VObj.XDim = row;
    VObj.YDim = col;
    VObj.ZDim = slice;
    VObj.XDimRes=0.44e-3;
    VObj.YDimRes=0.44e-3;
    VObj.ZDimRes=1e-3;
    %����Rho
    Rho = zeros(row,col,slice);
    %����T1
    T1 = zeros(row,col,slice);
    %����T2
    T2 = zeros(row,col,slice);
    %����T2Star
    T2Star = zeros(row,col,slice);
    %����ECon
    ECon = zeros(row,col,slice,3);
    %����MassDen
    MassDen =zeros(row,col,slice);
    max_slice = min([samples,mask_num,slice]);%��ֹ���
    for loopi = 1:max_slice
        frame_i = randi([1,samples-10],1); 
        filename = [dirname,dirs(frame_i).name]; % ��ȡ�ı���ͼƬ��Ҫ���ϵ����������
        II1 = double(rgb2gray(imread(filename)))/255;%��һ��
        II1 = abs(imresize(II1,[row,col],'nearest'));    
        filename = [dirname,dirs(frame_i+1).name];
        II2 = double(rgb2gray(imread(filename)))/255;%��һ��
        II2 = abs(imresize(II2,[row,col])); 
        filename = [dirname,dirs(frame_i+2).name];
        II3 = double(rgb2gray(imread(filename)))/255;%��һ��
        II3 = abs(imresize(II3,[row,col])); 
        sel_frame = randi([1,mask_num],1); 
        temp_brain_mask = brain_mask(:,:,mod(sel_frame,mask_num)+1);%ѭ��ȡ��ģ��   
        temp_brain_mask = imresize(temp_brain_mask,[row,col]);
        %mask+����ͼ��ͼ����
        temp_I1 = temp_brain_mask.*II1; %T1
        temp_I2 = temp_brain_mask.*II2; %T2
        temp_I3 = temp_brain_mask.*II3; %M0
        %ͼ��+mask
        %T1��Χ0~5s
        temp_mask = zeros(row,col);
        final_T1 = zeros(row,col);
        final_T2 = zeros(row,col);
        final_Rho = zeros(row,col);
        for loopj = 1:num
            [final_T1,final_T2,final_Rho,temp_mask] =  WJGshape1(final_T1,final_T2,final_Rho,temp_mask,row,col,dirname,dirs,1);%Բ
            [final_T1,final_T2,final_Rho,temp_mask] =  WJGshape1(final_T1,final_T2,final_Rho,temp_mask,row,col,dirname,dirs,2);%��
            [final_T1,final_T2,final_Rho,temp_mask] =  WJGshape1(final_T1,final_T2,final_Rho,temp_mask,row,col,dirname,dirs,3);%������
            [final_T1,final_T2,final_Rho,temp_mask] =  WJGshape1(final_T1,final_T2,final_Rho,temp_mask,row,col,dirname,dirs,4);%������  
            new_mask = temp_brain_mask.*abs(temp_mask-temp_brain_mask);%%��������
            if (sum(new_mask(:))<sum(temp_brain_mask(:))/8) 
                break;
            end
%         subplot(131);imshow(final_T1,[]); colormap(jet);title('T1');pause(0.001)
%         subplot(132);imshow(final_T2,[]); colormap(jet);title('T2');pause(0.001)
%         subplot(133);imshow(final_Rho,[]); colormap(jet);title('Rho');pause(0.001) 
        end
        new_mask = temp_brain_mask.*abs(temp_brain_mask-temp_mask);%��ֹģ����ص�
        final_T1 = final_T1.*temp_brain_mask+temp_I1.*new_mask;
        final_T1=abs(imfilter(final_T1,gausFilter,'replicate'))/max(final_T1(:));
        final_T1 = final_T1*3;      %T1��Χ
%         subplot(131);imshow(final_T1,[]); colormap(jet);title('T1');pause(0.001)

     %T2��Χ0~2.2s
        final_T2 = final_T2.*temp_brain_mask+temp_I2.*new_mask;
        final_T2=abs(imfilter(final_T2,gausFilter,'replicate'))/max(final_T2(:));
        final_T2 = final_T2*1;    %T2��Χ
%         subplot(132);imshow(final_T2,[]); colormap(jet);title('T2');pause(0.001)

     %Rho��Χ0-1
        final_Rho = final_Rho.*temp_brain_mask+temp_I3.*new_mask;
        final_Rho=abs(imfilter(final_Rho,gausFilter,'replicate'))/max(final_Rho(:));
        final_Rho = final_Rho*1;
%         subplot(133);imshow(final_Rho,[]); colormap(jet);title('Rho');pause(0.001) 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�Rho%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Rho(:,:,loopi) = final_Rho;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T1%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        T1(:,:,loopi) = final_T1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T2%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        T2(:,:,loopi) = final_T2;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T2Star%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %���T2Star
        WJG_T2Star = final_T2;    %����T2��Ϊ
        T2Star(:,:,loopi) = WJG_T2Star*0;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�ECon%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %�ⲿ�ִ������Ҫ���������ݽṹ��������ͬ
        %���ECon
        WJG_ECon = final_Rho*0;    %
        ECon(:,:,loopi) = WJG_ECon;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�MassDen%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %���ECon
        WJG_MassDen = final_Rho*0;    %
        MassDen(:,:,loopi) = WJG_MassDen;
        disp(loopi)
    end
    VObj.Rho = abs(Rho);VObj.T1 = abs(T1);VObj.T2 = abs(T2);VObj.T2Star = abs(T2Star);VObj.ECon = abs(ECon);VObj.MassDen = abs(MassDen);
    savename = ['WJG_DeeL',num2str((sam_loop-1)*max_slice+loopi)];
    save(savename,'VObj','-v7.3')
end
%