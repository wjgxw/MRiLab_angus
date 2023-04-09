clc
clear 
close all
row = 352;
col = 352;
% filename ='/data4/angus_wj/yqq_adv/adv/dataset/train/brain_62.Charles';
filename ='/data4/angus_wj/MRH_ZOOM_2pulse_heart/data4trainM_noise2/train/8.Charles';
fid = fopen(filename, 'r');
data_in = fread(fid,'single')';
step = length(data_in)/row/col;

M1 = reshape(data_in,[step,row,col]);
% for loopi = 1:16
%     I1 = squeeze(M1(loopi,:,:));
%     imshow(abs(I1),[0,1]);colormap jet
% end
% figure();
% subplot(121)
% K1 = fftshift(fft2(fftshift(I1)));
% imshow(abs(I1),[]);colormap jet
% I1 = squeeze(M1(3,:,:))+1i*squeeze(M1(4,:,:));
% subplot(122)
% K1 = fftshift(fft2(fftshift(I1)));
% imshow(abs(I1),[]);colormap jet
% figure(3);
% figure(9);imshow(abs(ifftshift(fft2(fftshift(I1)))),[]);colormap jet;
for loopi = 1:step
    temp_input = data_in(loopi:step:end);
    M1= reshape(temp_input,[row,col]);
%     subplot(4,4,loopi);
   figure; imshow((M1),[]);colormap jet;
end



