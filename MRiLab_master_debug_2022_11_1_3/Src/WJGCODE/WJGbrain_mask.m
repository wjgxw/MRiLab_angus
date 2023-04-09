clc
clear all
close all
%��������ѵ���õĴ��Ե���Ĥ
load('BrainModel');
brain_mask = Anatomy(:,:,20:end);%ǰ20���������ã�����
mask_num = size(brain_mask,3);
row = 256;
final_mask = zeros(row,row,mask_num);
for loopi = 1:mask_num
    temp_brain_mask = brain_mask(:,:,loopi);%ѭ��ȡ��ģ��
    temp_brain_mask = imresize(temp_brain_mask,[row-20,row-20]);
    temp_brain_mask = padarray(temp_brain_mask,[10,10]);
    level = graythresh(temp_brain_mask);
    temp_brain_mask = im2bw(temp_brain_mask,level);
    se1=strel('disk',3);%�����Ǵ���һ���뾶Ϊ5��ƽ̹��Բ�̽ṹԪ��
    temp_brain_mask=imclose(temp_brain_mask,se1);%�ȿ��������;
    imshow(temp_brain_mask,[])
    final_mask(:,:,loopi) = temp_brain_mask;
end
