clear all;
dirname='/data4/angus_wj/MRH_T2T2starAP/gensample/newbrain/sample1/';
outputdir = '/data4/angus_wj/MRH_T2T2starAP/data4trainyqq/';
addpath(genpath('/home/wj/Desktop/cest_shuffling/lib/'))
name = 'brainnew_';
phase_num=128;
fre_num = 128;
expand_num = 256;
model_num=500;
GAMMA = 2.675380303797068e+08/2/pi;
fid_dir_all=dir([dirname,'*.mat']);       %list all directories

WJG_order = 1;
for loopi = 1:length(fid_dir_all)
    output = zeros(10,expand_num,expand_num);
    fid_dir =[dirname,fid_dir_all(loopi).name];
    load(fid_dir);
    
    % T2
    T2 = VSig.T2;
    T2 = abs(imresize(T2,[expand_num,expand_num],'nearest'));
    T2 = rot90(T2,2);
    % T2star
    T2STAR = VSig.T2STAR;
    T2STAR = abs(imresize(T2STAR,[expand_num,expand_num],'nearest'));
    T2STAR = rot90(T2STAR,2);
    % B0
    B0 = VSig.B0*GAMMA;
    B0 = imresize(B0,[expand_num,expand_num],'nearest');
    B0 = rot90(B0,2);
    % B1
    B1 = VSig.B1;
    B1 = abs(imresize(B1,[expand_num,expand_num],'nearest'));
    B1 = rot90(B1,2);
    % M0
    M0 = VSig.Rho;
    M0 = abs(imresize(M0,[expand_num,expand_num],'nearest'));
    M0 = rot90(M0,2);
    mask1 = M0>0;
    
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
    I2=fliplr(I2);
    I2 = I2/max4norm;
    
%     [rand_map,rand_small_map]=creat_echo_train_gap(expand_num);
%     rand_phase=produce_background_phase_map(expand_num);
%     I2=I2.*(rand_map).*exp(1.0i*rand_phase);
    
    output(1,:,:) = real(I1);
    output(2,:,:) = imag(I1);
    output(3,:,:) = real(I2);
    output(4,:,:) = imag(I2);
    
    output(5,:,:) = T2.*mask1;
    output(6,:,:) = T2STAR.*mask1;
    output(7,:,:) = B0.*mask1;
    output(8,:,:) = M0;
    output(9,:,:) = B1.*mask1;
    output(10,:,:) = B1.*mask1;
    
%         figure(1);
%         subplot(2,3,1);imshow(abs(I1),[0 1]);
%         subplot(2,3,2);imshow(abs(I1)*50,[0 1]);
%         subplot(2,3,3);imshow(abs(fft2c(I1)),[0 1]);
%     
%         subplot(2,3,4);imshow(abs(I2),[0 1]);
%         subplot(2,3,5);imshow(abs(I2)*50,[0 1]);
%         subplot(2,3,6);imshow(abs(fft2c(I2)),[0 1]);
%             colormap jet;
% 
%         figure(2);
%         subplot(2,3,1);imshow(reshape(output(5,:,:),[expand_num,expand_num]),[0 0.2]);
%         subplot(2,3,2);imshow(reshape(output(6,:,:),[expand_num,expand_num]),[0 0.2]);
%         subplot(2,3,3);imshow(reshape(output(7,:,:),[expand_num,expand_num]),[]);
%         subplot(2,3,4);imshow(reshape(output(8,:,:),[expand_num,expand_num]),[0 1]);
%         subplot(2,3,5);imshow(reshape(output(9,:,:),[expand_num,expand_num]),[0.8 1.2]);
%         subplot(2,3,6);imshow(reshape(output(10,:,:),[expand_num,expand_num]),[]);
%         colormap jet;
    
    nankey=isnan(output);
    if sum(nankey(:))>0
        disp('warming: NAN !!')
    else
        filename=[outputdir,name,num2str(WJG_order),'.Charles'];
        [fid,msg]=fopen(filename,'wb');
        fwrite(fid,output,'single');
        fclose(fid);
        disp(WJG_order);
        WJG_order = WJG_order+1;
    end
end

