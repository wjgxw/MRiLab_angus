%process the result of MRiLab
% norm the data
%for deep learning
%Angus
clc
clear 
close all
dirname='/data4/mlc/T2star_diffusion/datagen20/';
outputdir = [dirname, 'data4train1/'];
fid_dir_all=dir([dirname,'*1']);       %list all directories
phase_num=128;
fre_num = 128;
expand_num = 256;
sigma=1e-2;
WJG_order=1;
GAMMA = 2.675380303797068e+08/2/pi;
for loopi = 1:length(fid_dir_all)
    fid_dir =[dirname,fid_dir_all(loopi).name,'/'];
    fid_file_all=dir([fid_dir,'DEEP*']);    %list all files
    for loopj = 1:length(fid_file_all)
        fid_file =[fid_dir,fid_file_all(loopj).name];
        load(fid_file)
        %% T2
        T2 = VSig.T2;
        T2 = abs(imresize(T2,[expand_num,expand_num],'nearest'));
        T2 = imrotate(T2,-90);
        %% B1
%         B1 = VSig.B1;
%         B1 = abs(imresize(B1,[expand_num,expand_num],'nearest'));
%         B1 = imrotate(B1,-90);
        %% M0
        M0 = VSig.Rho;
        M0 = abs(imresize(M0,[expand_num,expand_num],'nearest'));
        M0 = imrotate(M0,-90);
        mask = M0>0;
        %% ADC
        ADC = VSig.ADC;
        ADC = abs(imresize(ADC,[expand_num,expand_num],'nearest'));
        ADC = imrotate(ADC,-90);
        %% B0
%         B0 = VSig.B0;
%         B0 = (imresize(B0,[expand_num,expand_num],'nearest'));
%         B0 = imrotate(B0,-90);
        
        Sx = squeeze(VSig.Sx);
        Sy = squeeze(VSig.Sy);
        %% input
        K1 = Sx(1:end/2)+1i*Sy(1:end/2);               
        K1 = reshape(K1,fre_num,phase_num);
        K1(:,2:2:end) = flipud(K1(:,2:2:end));
        expand_K1 = zeros(expand_num,expand_num);
        expand_K1(round((expand_num-fre_num)/2+1):round((expand_num+fre_num)/2),round((expand_num-phase_num)/2+1):round((expand_num+phase_num)/2))=K1;
        I1=fftshift(ifft2(ifftshift(expand_K1)));     %(1,i f f)(2,f,i,i)
        max4norm = max(abs(I1(:)));
        I1 = I1/max4norm;
        both_img_noise=normrnd(0,sigma,expand_num,expand_num)+1.0i*normrnd(0,sigma,expand_num,expand_num);
        I1 = I1+both_img_noise;

        K2 = Sx(end/2+1:end)+1i*Sy(end/2+1:end);
        K2 = reshape(K2,fre_num,phase_num);       
        K2(:,2:2:end) = flipud(K2(:,2:2:end));
        if sum(abs(K2(:,end)))==0 %avoid wrong data 
            disp ('wrong data')
            fid_file
            break
        end
        expand_K2 = zeros(expand_num,expand_num);
        expand_K2(round((expand_num-fre_num)/2+1):round((expand_num+fre_num)/2),round((expand_num-phase_num)/2+1):round((expand_num+phase_num)/2))=K2;
        I2=fftshift(ifft2(ifftshift(expand_K2)));     %(1,i f f)(2,f,i,i)
        I2 = I2/max4norm;
        both_img_noise=normrnd(0,sigma,expand_num,expand_num)+1.0i*normrnd(0,sigma,expand_num,expand_num);
        I2 = I2+both_img_noise;
        I1 = flipud(I1);
%         I2 = flipud(I2);
     
% %         
%         figure(1);imshow(abs(I1),[]);colormap jet;
%         figure(2);imshow(abs(I2),[]);colormap jet;
%         figure(3);imshow(angle(I1),[]);colormap jet;colorbar
%         figure(6);imshow(T2*2,[]);colormap jet;
%         figure(7);imshow(M0,[]);colormap jet;colorbar
%         figure(8);imshow(ADC*1000,[]);colormap jet;
%         figure(9);imshow((abs(ifftshift(fft2(fftshift(I1))))),[]);colormap jet;
%         figure(10);imshow((abs(ifftshift(fft2(fftshift(I2))))),[]);colormap jet;
        output(1,:,:) = real(I1);
        output(2,:,:) = imag(I1);
        output(3,:,:) = real(I2);
        output(4,:,:) = imag(I2);

        output(5,:,:) = T2*2;
        output(6,:,:) = ADC*1000;
        output(7,:,:) = zeros(size(T2));%B1.*mask;
        output(8,:,:) = M0;   

        filename=[outputdir,num2str(WJG_order),'.Charles'];
        [fid,msg]=fopen(filename,'wb');
        fwrite(fid,output,'single');
        fclose(fid); 
        WJG_order = WJG_order+1;
        disp(WJG_order)
    end
    
%     imshow(abs(origin_2D_complex),[])
end




