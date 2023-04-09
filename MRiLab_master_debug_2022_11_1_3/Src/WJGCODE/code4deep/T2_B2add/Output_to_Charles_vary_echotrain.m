clear all;
dirname='brain_scan_30_1302/';
outputdir = 'Charles_echo_30fa_1502/';
name = 'yqq_';
phase_num=128;
fre_num = 128;
expand_num = 256;
model_num=500;
fid_dir_all=dir([dirname,'*.mat']);       %list all directories

WJG_order = 1;
for loopi = 1:length(fid_dir_all)
    output = zeros(11,expand_num,expand_num); 
    fid_dir =[dirname,fid_dir_all(loopi).name];
    load(fid_dir);
    
    % T2
    T2 = VSig.T2;
    T2 = abs(imresize(T2,[expand_num,expand_num],'nearest'));
    T2 = flip(T2,1);
    % B1
    B1 = VSig.B1;
    B1 = abs(imresize(B1,[expand_num,expand_num],'nearest'));
    B1 = flip(B1,1);
    % M0
    M0 = VSig.Rho;
    M0 = abs(imresize(M0,[expand_num,expand_num],'nearest'));
    M0 = flip(M0,1);
    mask1 = M0>0;
    
    %mask
    wb_edg = edge(T2STAR, 'canny', 0.01);
    wb_edg_all = wb_edg + circshift(wb_edg, 1, 1) + circshift(wb_edg, -1, 1)...
        + circshift(wb_edg, 1, 2) + circshift(wb_edg, -1, 2);
    mask = double(ones(size(wb_edg_all))-(wb_edg_all>0));
    output(6,:,:)=mask;
    %mask
    
    %ychange: 1/T2(T2>threshold), 1/threshold(T2<=threshold)
    threshold = 0.05;
    ychange = T2;
    ychange(T2==0) = 1;
    ychange = 1./ychange;
    ychange(ychange==1) = 0;
    ychange(T2<=threshold) = 1/threshold;
    output(5,:,:)=ychange;
    %ychange
    
    Sx = squeeze(VSig.Sx);
    Sy = squeeze(VSig.Sy);
    
    % echo 1
    K1 = Sx(1:end/2)+1i*Sy(1:end/2);
    K1 = reshape(K1,fre_num,phase_num);
    K1(:,2:2:end) = flipud(K1(:,2:2:end));
    expand_K1 = zeros(expand_num, expand_num) + 1.0i * zeros(expand_num, expand_num);
    expand_K1(round((expand_num-fre_num)/2)+1:round((expand_num+fre_num)/2),round((expand_num-phase_num)/2)+1:round((expand_num+phase_num)/2),:)=K1;
    I1=ifft2c(expand_K1);
    max4norm = max(abs(I1(:)));
    I1 = I1/max4norm;
    
    % echo 2
    K2 = Sx(end/2+1:2*end/2)+1i*Sy(end/2+1:2*end/2);
    K2 = reshape(K2,fre_num,phase_num);
    K2(:,2:2:end) = flipud(K2(:,2:2:end));
    expand_K2 = zeros(expand_num, expand_num) + 1.0i * zeros(expand_num, expand_num);
    expand_K2(round((expand_num-fre_num)/2)+1:round((expand_num+fre_num)/2),round((expand_num-phase_num)/2)+1:round((expand_num+phase_num)/2),:)=K2;
    I2=ifft2c(expand_K2);
    I2=fliplr(I2);
    I2 = I2/max4norm;
     
    I1 = rot90(I1,2);
    I2 = rot90(I2,2);

    [B2,rand_small_map]=creat_echo_train_gap(expand_num);
    I2=I2.*(B2.*rand_small_map);
    
    output(1,:,:) = real(I1);
    output(2,:,:) = imag(I1);
    output(3,:,:) = real(I2);
    output(4,:,:) = imag(I2);
                    
    output(10,:,:) = B2.*mask1;                   
     
    output(7,:,:) = T2;
    output(8,:,:) = M0;
    output(9,:,:) = B1.*mask1;
    
    filename=[outputdir,name,num2str(WJG_order),'.Charles'];
    [fid,msg]=fopen(filename,'wb');
    fwrite(fid,output,'single');
    fclose(fid);
    disp(WJG_order);
    WJG_order = WJG_order+1;
end

