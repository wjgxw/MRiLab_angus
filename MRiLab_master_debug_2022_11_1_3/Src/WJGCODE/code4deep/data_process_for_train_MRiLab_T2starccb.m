%process the result of MRiLab
% norm the data
%for deep learning
%Angus
clc
clear 
close all
addpath(genpath('SPIRiT_v0.3/ESPIRiT/'))
dirname='/data4/angus_wj/MRH_T2T2star571AP/gensample/random150/';
outputdir = '/data4/angus_wj/MRH_T2T2star571AP/data4train150_newnoise/random150_';
fid_dir_all=dir([dirname,'sample*']);       %list all directories
phase_num=128;
fre_num = 128;
expand_num = 256;
sigma=0.4e-2;
WJG_order=1;
GAMMA = 2.675380303797068e+08/2/pi;
% max_amp =  5;%max_amp_I1(fid_dir_all)
for loopi = 1:length(fid_dir_all)
    fid_dir =[dirname,fid_dir_all(loopi).name,'/'];
    fid_file_all=dir([fid_dir,'DEEP*']);    %list all files
    for loopj = 1:length(fid_file_all)
        fid_file =[fid_dir,fid_file_all(loopj).name];
        load(fid_file)
        %% T1
%         T1 = VSig.T1;
%         T1 = abs(imresize(T1,[expand_num,expand_num],'nearest'));
%         T1 = imrotate(T1,180);
        %% T2
        T2 = VSig.T2;
        T2 = abs(imresize(T2,[expand_num,expand_num],'nearest'));
        T2 = imrotate(T2,180);
        %% T2star
        T2STAR = VSig.T2STAR;
        T2STAR = abs(imresize(T2STAR,[expand_num,expand_num],'nearest'));
        T2STAR = imrotate(T2STAR,180);
        %% T2prime
        T2Prime = T2STAR.*T2./(T2-T2STAR+eps).*(T2>0.005);
%         T2Prime = 1./(T2Prime+eps).*(T2>0.005);
        T2Prime = (T2Prime>0.4).*0.4+(T2Prime<=0.4).*T2Prime;  %error ~5% when T2=20e-3.T2star=20e-3;
        %% B0
        B0 = VSig.B0*GAMMA;
        B0 = imresize(B0,[expand_num,expand_num],'nearest');
        B0 = imrotate(B0,180);
        %% B1
        B1 = VSig.B1;
        B1 = abs(imresize(B1,[expand_num,expand_num],'nearest'));
        B1 = imrotate(B1,180);
        %% M0
        M0 = VSig.Rho;
        M0 = abs(imresize(M0,[expand_num,expand_num],'nearest'));
        M0 = imrotate(M0,180);
        mask = M0>0;
        Sx = squeeze(VSig.Sx);
        Sy = squeeze(VSig.Sy);

      % noise
    sigma=8*rand()+2;
    both_img_noise1=normrnd(0,sigma,fre_num,phase_num)+1.0i*normrnd(0,sigma,fre_num,phase_num);
    both_img_noise2=normrnd(0,sigma,fre_num,phase_num)+1.0i*normrnd(0,sigma,fre_num,phase_num);
    
    % echo 1
    K1 = Sx(1:end/2)+1i*Sy(1:end/2);
    K1 = reshape(K1,fre_num,phase_num);
    K1(:,2:2:end) = flipud(K1(:,2:2:end));
    
    im1=ifft2c(K1);
    im1=im1+both_img_noise1;
    K1=fft2c(im1);
    
    expand_K1 = zeros(expand_num, expand_num) + 1.0i * zeros(expand_num, expand_num);
    expand_K1(round((expand_num-fre_num)/2)+1:round((expand_num+fre_num)/2),round((expand_num-phase_num)/2)+1:round((expand_num+phase_num)/2),:)=K1;
    I1=ifft2c(expand_K1);
    max4norm = max(abs(I1(:)));
    I1 = I1/max4norm;      
      % echo 2
    K2 = Sx(end/2+1:2*end/2)+1i*Sy(end/2+1:2*end/2);
    K2 = reshape(K2,fre_num,phase_num);
    K2(:,2:2:end) = flipud(K2(:,2:2:end));
    
    im2=ifft2c(K2);
    im2=im2+both_img_noise2;
    %K2=flip(flip(fft2c(im2),1),2);
    %K2=flip(fft2c(im2),1);
    
    expand_K2 = zeros(expand_num, expand_num) + 1.0i * zeros(expand_num, expand_num);
    expand_K2(round((expand_num-fre_num)/2)+1:round((expand_num+fre_num)/2),round((expand_num-phase_num)/2)+1:round((expand_num+phase_num)/2),:)=K2;
    I2=ifft2c(expand_K2);
    I2=flipud(fliplr(I2));
    I2 = I2/max4norm;      
        
    
        %%mask
% % % 		WJG_edge = edge(T2, 'canny', 0.01);
% % % 		WJG_edge = WJG_edge + circshift(WJG_edge, 1, 1) + circshift(WJG_edge, -1, 1)...
% % % 					 + circshift(WJG_edge, 1, 2) + circshift(WJG_edge, -1, 2);
% % % 		WJG_edge = double(~WJG_edge);		
% % % 		%ychange: 1/T2(T2>threshold), 1/threshold(T2<=threshold)
% % % 		threshold = 0.05;
% % % 		ychange = T2;
% % % 		ychange(T2==0) = 1;
% % % 		ychange = 1./ychange;
% % % 		ychange(ychange==1) = 0;
% % % 		ychange(T2<=threshold) = 1/threshold;        
%         
        figure(1);imshow(abs(I1),[]);colormap jet;colorbar
        figure(2);imshow(abs(I2),[]);colormap jet;colorbar
%         figure(3);imshow((B0.*mask),[-100,100]);colormap jet;colorbar
%         figure(4);imshow(abs(M0),[]);colormap jet;colorbar
%         figure(5);imshow(B1.*mask,[0.8,1.2]);colormap jet;colorbar
% %         figure(6);imshow(ychange,[]);colormap jet;colorbar
%         figure(7);imshow(T2,[0,0.2]);colormap jet;colorbar
%         figure(8);imshow(T2STAR,[]);colormap jet;colorbar
%         figure(9);imshow(T2Prime,[0,0.4]);colormap jet;colorbar
%         figure(9);imshow((abs(ifftshift(fft2(fftshift(I1))))),[]);colormap jet;
%         figure(10);imshow((abs(ifftshift(fft2(fftshift(I2))))),[]);colormap jet;
        output(1,:,:) = real(I1);
        output(2,:,:) = imag(I1);
        output(3,:,:) = real(I2);
        output(4,:,:) = imag(I2);
        output(5,:,:) = T2;
        output(6,:,:) = T2STAR;
        output(7,:,:) = B0.*mask/50;
        output(8,:,:) = M0;
        output(9,:,:) = B1.*mask; 
        output(10,:,:) = T2Prime.*mask; 
% 
        filename=[outputdir,num2str(WJG_order),'.Charles'];
        [fid,msg]=fopen(filename,'wb');
        fwrite(fid,output,'single');
        fclose(fid); 
        WJG_order = WJG_order+1;
        disp(WJG_order)
    end 
%     imshow(abs(origin_2D_complex),[])
end




