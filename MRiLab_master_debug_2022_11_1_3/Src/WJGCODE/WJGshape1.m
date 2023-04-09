function [T1_out,T2_out,Rho_out,new_mask] =  WJGshape1(T1,T2,Rho,mask,row,col,dirname,dirs,type)
%�������ͼ�Σ�����ͼ�����������
%���Ѿ����ɵ�T1,T2,Rho�Ļ����ϼ�����Ӽ���ģ��
%maskΪ����ģ��
%dirΪ�������Ĺ�ѧͼ��·��

radius_limit = row;
mini_size = 5;%��С�ߴ�
T1_out = T1;
T2_out = T2;
Rho_out = Rho;
switch type
    case 1    
        %����Բ
        mask1 = zeros(row,col);
        RADIUS = randi([mini_size,round(radius_limit/16)],1); 
        center = randi([20,row/2+round(radius_limit/4)],1,2); 
        temp_mask = WJGgenCircle(row,RADIUS,center);
        if(sum(temp_mask(:))>50)    %��ֹ���������С��ͼ��
            mask1 = mask1+temp_mask;
        end
        new_mask = mask1.*abs(mask1-mask);%��ֹģ����ص�
        T1_out = Add_tex(T1,dirname,dirs,new_mask);  
        T2_out = Add_tex(T2,dirname,dirs,new_mask); 
        Rho_out = Add_tex(Rho,dirname,dirs,new_mask); 
        new_mask = abs(new_mask+mask)>0;  

    case 2
        %���ɻ�
        mask1 = zeros(row,col);
        RADIUS1 = randi([mini_size,round(radius_limit/16)],1);
        RADIUS2 = randi([mini_size,round(radius_limit/16)],1);
        center = randi([20,row/2+round(radius_limit/4)],1,2); 
        temp_mask = WJGgenRing( row,max(RADIUS1,RADIUS2),min(RADIUS1,RADIUS2),center );
        if(sum(temp_mask(:))>50)    %��ֹ���������С��ͼ��
            mask1 = mask1+temp_mask;
        end
        new_mask = mask1.*abs(mask1-mask);%��ֹģ����ص�
        T1_out = Add_tex(T1,dirname,dirs,new_mask);  
        T2_out = Add_tex(T2,dirname,dirs,new_mask); 
        Rho_out = Add_tex(Rho,dirname,dirs,new_mask); 
        new_mask = abs(new_mask+mask)>0; 
    case 3
        %����������
        mask1 = zeros(row,col);
        shape = randi([1,round(radius_limit/4)],2,2);  %��С
        center = randi([20,row/2+round(radius_limit/8)],2,1); 
        center = [center,center];
        shape = shape+center;
        x = min([sort(shape(1,:));row,row]);    %���Ʒ�Χ
        y = min([sort(shape(2,:));col,col]);
        vx = [x(1),x(1),x(2),x(2),x(1)];
        vy = [y(1),y(2),y(2),y(1),y(1)];
        temp_mask = WJG_convex_S(row,vx,vy);
        if(sum(temp_mask(:))>50)    %��ֹ���������С��ͼ��
            mask1 = mask1+temp_mask;
        end
        new_mask = mask1.*abs(mask1-mask);%��ֹģ����ص�
        T1_out = Add_tex(T1,dirname,dirs,new_mask);  
        T2_out = Add_tex(T2,dirname,dirs,new_mask); 
        Rho_out = Add_tex(Rho,dirname,dirs,new_mask); 
        new_mask = abs(new_mask+mask)>0;
    case 4 
%����������
        mask1 = zeros(row,col);
        shape = randi([1,round(radius_limit/4)],2,3);
        center = randi([20,row/2+round(radius_limit/4)],2,1); 
        center = [center,center,center];
        shape = shape+center;
        x = min([sort(shape(1,:));row,row,row]);
        y = min([sort(shape(2,:));col,col,col]);
        vx = [x(1),x(2),x(3),x(1)];
        vy = [y(1),y(2),y(3),y(1)];
        temp_mask = WJG_convex_S(row,vx,vy);
        if(sum(temp_mask(:))>50)    %��ֹ���������С��ͼ��
            mask1 = mask1+temp_mask;
        end
        new_mask = mask1.*abs(mask1-mask);%��ֹģ����ص�
        T1_out = Add_tex(T1,dirname,dirs,new_mask);  
        T2_out = Add_tex(T2,dirname,dirs,new_mask); 
        Rho_out = Add_tex(Rho,dirname,dirs,new_mask); 
        new_mask = abs(new_mask+mask)>0;
end
      
% imshow(mask1+mask2+mask3+mask4)

function out =  Add_tex(input,dirname,dirs,new_mask)
samples = length(dirs);
[row,col] = size(input);
frame_i = randi([1,samples],1); 
filename = [dirname,dirs(frame_i).name];
II = double(rgb2gray(imread(filename)))/255;%��һ��
II = abs(imresize(II,[row,col],'nearest'));
out = new_mask.*II+input; 
