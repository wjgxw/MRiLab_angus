%process the result of MRiLab
% norm the data
%for deep learning
%
clc
clear 
close all
addpath(genpath('../../WJGCODE'))
dirname='/data5/wj/OLED_T1/scheme1/samples/random_texture/';
addpath(dirname)
GAMMA = 2.675380303797068e+08/2/pi;

outputdir = '/data5/wj/OLED_T1/scheme1/data4train_rat/';
fid_dir_all=dir([dirname,'sample*']);       %list all directories
phase_num=128;
fre_num = 128;
expand_num = 256;
sigma=1e-2;
WJG_order=1;
% max_amp = 4.5;%max_amp_T1(dirname);  %phantom4.5

for loopi = 1:length(fid_dir_all)
    fid_dir =[dirname,fid_dir_all(loopi).name,'/'];
    fid_file_all=dir([fid_dir,'DEEP*']);    %list all files
    for loopj = 1:length(fid_file_all)
        fid_file =[fid_dir,fid_file_all(loopj).name];
        load(fid_file)
        T1 = VSig.T1;
        T1 = abs(imresize(T1,[expand_num,expand_num],'nearest'));
        T2 = VSig.T2;
        T2 = abs(imresize(T2,[expand_num,expand_num],'nearest'));
        B1 = VSig.B1;
        B1 = abs(imresize(B1,[expand_num,expand_num],'nearest'));
        B0 = VSig.B0*GAMMA;
        B0 = imresize(B0,[expand_num,expand_num],'nearest');
        M0 = VSig.Rho;
        M0 = abs(imresize(M0,[expand_num,expand_num],'nearest'));
        mask = M0>0;
        Sx = squeeze(VSig.Sx);
        Sy = squeeze(VSig.Sy);
        %% echo1
        sigma=8*rand()+2;
        both_img_noise=normrnd(0,sigma,fre_num,phase_num)+1.0i*normrnd(0,sigma,fre_num,phase_num);
        K = Sx+1i*Sy;
        K1 = K(1:end/3);
        K1 = reshape(K1,[fre_num,phase_num]);
        K1(:,2:2:end) = flipud(K1(:,2:2:end));
        im1=ifft2c(K1);
        im1=im1+both_img_noise;
        K1=fft2c(im1);        
        
        expand_K1 = zeros(expand_num,expand_num);
        expand_K1(round((expand_num-fre_num)/2)+1:round((expand_num+fre_num)/2),round((expand_num-phase_num)/2)+1:round((expand_num+phase_num)/2),:)=K1;
        I1=ifft2c(expand_K1);     %(1,i f f)(2,f,i,i)
        max_amp = max(abs(I1(:)));
        I1 = I1/max_amp;
        I1 = (imrotate(I1,-90));

        %% echo2
        both_img_noise=normrnd(0,sigma,fre_num,phase_num)+1.0i*normrnd(0,sigma,fre_num,phase_num);        
        K1 = K(end/3+1:end*2/3);
        K1 = reshape(K1,[fre_num,phase_num]);
        K1(:,2:2:end) = flipud(K1(:,2:2:end));
        im1=ifft2c(K1);
        im1=im1+both_img_noise;
        K1=fft2c(im1);  
        expand_K1 = zeros(expand_num,expand_num);
        expand_K1((expand_num-phase_num)/2+1:(expand_num+phase_num)/2,(expand_num-fre_num)/2+1:(expand_num+fre_num)/2)=K1;
        I2=ifft2c(expand_K1);    %(1,i f f)(2,f,i,i)
        I2 = I2/max_amp;
        I2 = (imrotate(I2,-90));

        %% echo3        
        K1 = K(end*2/3+1:end);
        K1 = reshape(K1,[fre_num,phase_num]);
        K1(:,2:2:end) = flipud(K1(:,2:2:end));
        im1=ifft2c(K1);
        im1=im1+both_img_noise;
        K1=fft2c(im1);  
        expand_K1 = zeros(expand_num,expand_num);
        expand_K1((expand_num-phase_num)/2+1:(expand_num+phase_num)/2,(expand_num-fre_num)/2+1:(expand_num+fre_num)/2)=K1;
        I3=ifft2c(expand_K1);     %(1,i f f)(2,f,i,i)
        I3 = I3/max_amp;
        I3 = flipud(imrotate(I3,-90));

        output(1,:,:) = real(I1);
        output(2,:,:) = imag(I1);
        output(3,:,:) = real(I2);
        output(4,:,:) = imag(I2);        
        output(5,:,:) = real(I3);
        output(6,:,:) = imag(I3);        
        
        output(7,:,:) = T2;
        output(8,:,:) = T1;
        output(9,:,:) = M0;
        output(10,:,:) = B1.*mask;
        output(11,:,:) = B0/50.*mask;
%         figure(1);imshow(abs(I1),[]);colormap jet;
%         figure(2);imshow(abs(I2),[]);colormap jet;
%         figure(3); imshow((abs(I3)),[]),colormap jet
%         figure(4); imshow(abs(T1),[0,3]),colormap jet
%             figure(5); imshow(abs(B1.*mask),[0.8,1.2]),colormap jet
%             figure(6); imshow(B0.*mask,[-100,100]),colormap jet
% % 
%         figure(5);imshow((abs(ifftshift(fft2(fftshift(I1))))),[]);colormap jet;
%         figure(6);imshow((abs(ifftshift(fft2(fftshift(I2))))),[]);colormap jet;
%         figure(7);imshow((abs(ifftshift(fft2(fftshift(I3))))),[]);colormap jet;
        filename=[outputdir,'randomtexture_',num2str(WJG_order),'.Charles'];
        [fid,msg]=fopen(filename,'wb');
        fwrite(fid,output,'single');
        fclose(fid); 
        disp(WJG_order)
        WJG_order = WJG_order+1;
    end
    
%     imshow(abs(origin_2D_complex),[])
end




