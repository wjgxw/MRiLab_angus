%�������ڻ���ѧϰ��ѵ������
%����ͼ��
% by �⽡ XMU 
% 2018.4.4
clc;clear all;close all;
%����������ɼ���ͼ��
%�����ĳߴ�
row = 512;
col = row;
slice = 100;
num = 100;%��Ĥ����
sigma = 1.1;%���ڸ�˹�˲�
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
for sam_loop = 1:10 %���������϶࣬����ֳɼ���
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����MRiLabģ��
    load('BrainHighResolution')
    %�޸Ĳ���
    VObj.XDim = row;
    VObj.YDim = col;
    VObj.ZDim = slice;
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
        filename = [dirname,dirs((sam_loop-1)*max_slice+1).name];  %sam_loop��ʾ��ȡ�ı���ͼƬ��Ҫ���ϵ����������
        II1 = double(rgb2gray(imread(filename)))/255;%��һ��
        II1 = abs(imresize(II1,[row,col]));    
        filename = [dirname,dirs((sam_loop-1)*max_slice+2).name];
        II2 = double(rgb2gray(imread(filename)))/255;%��һ��
        II2 = abs(imresize(II2,[row,col])); 
        filename = [dirname,dirs((sam_loop-1)*max_slice+3).name];
        II3 = double(rgb2gray(imread(filename)))/255;%��һ��
        II3 = abs(imresize(II3,[row,col])); 
        temp_brain_mask = brain_mask(:,:,mod(loopi,mask_num)+1);%ѭ��ȡ��ģ��   
        temp_brain_mask = imresize(temp_brain_mask,[row,col]);
        %mask+����ͼ��ͼ����
        temp_I1 = temp_brain_mask.*II1;
        temp_I2 = temp_brain_mask.*II2;
        temp_I3 = temp_brain_mask.*II3;
        %ͼ��+mask
        %T1��Χ0~5s
        temp_mask = zeros(row,col);
        final_T1 = zeros(row,col);
        for loopj = 1:num
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_T1,temp_mask] =  WJGshape(final_T1,temp_mask,row,col,filename,1);%Բ
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_T1,temp_mask] =  WJGshape(final_T1,temp_mask,row,col,filename,2);%��
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_T1,temp_mask] =  WJGshape(final_T1,temp_mask,row,col,filename,3);%������
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_T1,temp_mask] =  WJGshape(final_T1,temp_mask,row,col,filename,4);%������  
            new_mask = temp_brain_mask.*abs(temp_mask-temp_brain_mask);%%��������
            if (sum(new_mask(:))<sum(temp_brain_mask(:))/8) 
                break;
            end
        end
        new_mask = temp_brain_mask.*abs(temp_brain_mask-temp_mask);%��ֹģ����ص�
        final_T1 = final_T1.*temp_brain_mask+temp_I1.*new_mask;
        final_T1=imfilter(final_T1,gausFilter,'replicate');
        final_T1 = final_T1*5;
        subplot(131);imshow(final_T1,[]); colormap(jet);title('T1');pause(0.001)

     %T2��Χ0~2.2s
        temp_mask = zeros(row,col);
        final_T2 = zeros(row,col);
        for loopj = 1:num
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_T2,temp_mask] =  WJGshape(final_T2,temp_mask,row,col,filename,1);%Բ
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_T2,temp_mask] =  WJGshape(final_T2,temp_mask,row,col,filename,2);%��
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_T2,temp_mask] =  WJGshape(final_T2,temp_mask,row,col,filename,3);%������
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_T2,temp_mask] =  WJGshape(final_T2,temp_mask,row,col,filename,4);%������ 
            new_mask = temp_brain_mask.*abs(temp_mask-temp_brain_mask);%%��������
            if (sum(new_mask(:))<sum(temp_brain_mask(:))/8) 
                break;
            end
        end
        new_mask = temp_brain_mask.*abs(temp_brain_mask-temp_mask);%��ֹģ����ص�
        final_T2 = final_T2.*temp_brain_mask+temp_I2.*new_mask;
        final_T2=imfilter(final_T2,gausFilter,'replicate');
        final_T2 = final_T2*2.2;
        subplot(132);imshow(final_T2,[]); colormap(jet);title('T2');pause(0.001)

     %Rho��Χ0-1
        temp_mask = zeros(row,col);
        final_Rho = zeros(row,col);
        for loopj = 1:num
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_Rho,temp_mask] =  WJGshape(final_Rho,temp_mask,row,col,filename,1);%Բ
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_Rho,temp_mask] =  WJGshape(final_Rho,temp_mask,row,col,filename,2);%��
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_Rho,temp_mask] =  WJGshape(final_Rho,temp_mask,row,col,filename,3);%������
            frame_i = randi([1,samples],1); 
            filename = [dirname,dirs(frame_i).name];
            [final_Rho,temp_mask] =  WJGshape(final_Rho,temp_mask,row,col,filename,4);%������
            new_mask = temp_brain_mask.*abs(temp_mask-temp_brain_mask);%%��������
            if (sum(new_mask(:))<sum(temp_brain_mask(:))/8) 
                break;
            end
        end
        new_mask = temp_brain_mask.*abs(temp_brain_mask-temp_mask);%��ֹģ����ص�
        final_Rho = final_Rho.*temp_brain_mask+temp_I3.*new_mask;
        final_Rho=imfilter(final_Rho,gausFilter,'replicate');
        final_Rho = final_Rho*1;
        subplot(133);imshow(final_Rho,[]); colormap(jet);title('Rho');pause(0.001) 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�Rho%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Rho(:,:,loopi) = final_Rho;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T1%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        T1(:,:,loopi) = final_T1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T2%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        T2(:,:,loopi) = final_T2;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�޸�T2Star%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %���T2Star
        WJG_T2Star = final_T2;    %����T2��Ϊ
        T2Star(:,:,loopi) = WJG_T2Star;
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
    save(savename,'VObj')
end
%