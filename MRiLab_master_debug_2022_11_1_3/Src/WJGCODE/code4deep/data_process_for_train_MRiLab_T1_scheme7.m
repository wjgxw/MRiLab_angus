%process the result of MRiLab
% norm the data
%for deep learning
%
clc
clear 
close all
dirname='/data3/wj/OLED_T1/scheme7/';
addpath(dirname)
GAMMA = 2.675380303797068e+08/2/pi;

outputdir = [dirname,'data4train2_texture0.6/'];
fid_dir_all=dir([dirname,'sample2*']);       %list all directories
phase_num=128;
fre_num = 128;
expand_num = 256;
sigma=1e-3;
WJG_order=1;
max_amp =  3.6;%max_amp_T1(dirname);

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
        T2STAR = VSig.T2STAR;
        T2STAR = abs(imresize(T2STAR,[expand_num,expand_num],'nearest'));
        B1 = VSig.B1;
        B1 = abs(imresize(B1,[expand_num,expand_num],'nearest'));
        B0 = VSig.B0*GAMMA;
        B0 = abs(imresize(B0,[expand_num,expand_num],'nearest'));
        M0 = VSig.Rho;
        M0 = abs(imresize(M0,[expand_num,expand_num],'nearest'));
        mask = M0>0;
        Sx = squeeze(VSig.Sx);
        Sy = squeeze(VSig.Sy);
        
        K = Sx+1i*Sy;
        K1 = K(1:end/4);
        K1 = reshape(K1,[fre_num,phase_num]);
        K1(:,2:2:end) = flipud(K1(:,2:2:end));
        expand_K1 = zeros(expand_num,expand_num);
        expand_K1((expand_num-phase_num)/2+1:(expand_num+phase_num)/2,(expand_num-fre_num)/2+1:(expand_num+fre_num)/2)=K1;
        I1=fftshift(ifft2(ifftshift(expand_K1)));     %(1,i f f)(2,f,i,i)
        I1 = I1/max_amp;
        I1 = (imrotate(I1,-90));
        both_img_noise=normrnd(0,sigma,expand_num,expand_num)+1.0i*normrnd(0,sigma,expand_num,expand_num);
        I1 = I1+both_img_noise;
        
        K1 = K(end/4+1:end*2/4);
        K1 = reshape(K1,[fre_num,phase_num]);
        K1(:,2:2:end) = flipud(K1(:,2:2:end));
        expand_K1 = zeros(expand_num,expand_num);
        expand_K1((expand_num-phase_num)/2+1:(expand_num+phase_num)/2,(expand_num-fre_num)/2+1:(expand_num+fre_num)/2)=K1;
        I2=fftshift(ifft2(ifftshift(expand_K1)));     %(1,i f f)(2,f,i,i)
        I2 = I2/max_amp;
        I2 = flipud(imrotate(I2,-90));
        both_img_noise=normrnd(0,sigma,expand_num,expand_num)+1.0i*normrnd(0,sigma,expand_num,expand_num);
        I2 = I2+both_img_noise;
        
        K1 = K(end*2/4+1:end*3/4);
        K1 = reshape(K1,[fre_num,phase_num]);
        K1(:,2:2:end) = flipud(K1(:,2:2:end));
        expand_K1 = zeros(expand_num,expand_num);
        expand_K1((expand_num-phase_num)/2+1:(expand_num+phase_num)/2,(expand_num-fre_num)/2+1:(expand_num+fre_num)/2)=K1;
        I3=fftshift(ifft2(ifftshift(expand_K1)));     %(1,i f f)(2,f,i,i)
        I3 = I3/max_amp;
        I3 = (imrotate(I3,-90));
        both_img_noise=normrnd(0,sigma,expand_num,expand_num)+1.0i*normrnd(0,sigma,expand_num,expand_num);
        I3 = I3+both_img_noise;

        K1 = K(end*3/4+1:end);
        K1 = reshape(K1,[fre_num,phase_num]);
        K1(:,2:2:end) = flipud(K1(:,2:2:end));
        expand_K1 = zeros(expand_num,expand_num);
        expand_K1((expand_num-phase_num)/2+1:(expand_num+phase_num)/2,(expand_num-fre_num)/2+1:(expand_num+fre_num)/2)=K1;
        I4=fftshift(ifft2(ifftshift(expand_K1)));     %(1,i f f)(2,f,i,i)
        I4 = I4/max_amp;
        I4 = (imrotate(I4,-90));
        both_img_noise=normrnd(0,sigma,expand_num,expand_num)+1.0i*normrnd(0,sigma,expand_num,expand_num);
        I4 = I4+both_img_noise;
        
        output(1,:,:) = real(I1);
        output(2,:,:) = imag(I1);
        output(3,:,:) = real(I2);
        output(4,:,:) = imag(I2);        
        output(5,:,:) = real(I3);
        output(6,:,:) = imag(I3);        
        output(7,:,:) = real(I4);
        output(8,:,:) = imag(I4);  
        
        output(9,:,:) = T1;
        output(10,:,:) = T2;
        output(11,:,:) = T2STAR;
        output(12,:,:) = B0/50.*mask;
        output(13,:,:) = B1.*mask;
        output(14,:,:) = M0;
%         figure(1);imshow(abs(I1),[]);colormap jet;
%         figure(2);imshow(abs(I2),[]);colormap jet;
%         figure(3); imshow(abs(I3),[]),colormap jet
%         figure(4); imshow(abs(I4),[]),colormap jet
%         figure(5); imshow(abs(T1),[0,3]),colormap jet
%             figure(6); imshow(abs(B1.*mask),[0.8,1.2]),colormap jet
%             figure(7); imshow(abs(B0.*mask),[-50,50]),colormap jet
% 
%         figure(5);imshow(log(abs(ifftshift(fft2(fftshift(I1))))),[]);colormap jet;
%         figure(6);imshow((abs(ifftshift(fft2(fftshift(I3))))),[]);colormap jet;
        filename=[outputdir,num2str(WJG_order),'.Charles'];
        [fid,msg]=fopen(filename,'wb');
        fwrite(fid,output,'single');
        fclose(fid); 
        WJG_order = WJG_order+1;
        disp(WJG_order)
    end
    
%     imshow(abs(origin_2D_complex),[])
end




