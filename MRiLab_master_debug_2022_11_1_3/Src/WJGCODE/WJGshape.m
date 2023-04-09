function [finan_output,new_mask] =  WJGshape(finan_I,mask,row,col,filename,type)
radius_limit = row;
mini_size = 5;%��С�ߴ�
II = double(rgb2gray(imread(filename)))/255;%��һ��
II = imresize(II,[row,col]);
finan_output = finan_I;
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
        finan_output = new_mask.*II+finan_I;
        new_mask = abs(new_mask+mask)>0;
    case 2
        %���ɻ�
        mask2 = zeros(row,col);
        RADIUS1 = randi([mini_size,round(radius_limit/16)],1);
        RADIUS2 = randi([mini_size,round(radius_limit/16)],1);
        center = randi([20,row/2+round(radius_limit/4)],1,2); 
        temp_mask = WJGgenRing( row,max(RADIUS1,RADIUS2),min(RADIUS1,RADIUS2),center );
        if(sum(temp_mask(:))>50)    %��ֹ���������С��ͼ��
            mask2 = mask2+temp_mask;
        end
        new_mask = mask2.*abs(mask2-mask);%��ֹģ����ص�
        finan_output = new_mask.*II+finan_I;
        new_mask = abs(new_mask+mask)>0;
    case 3
        %����������
        mask3 = zeros(row,col);
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
            mask3 = mask3+temp_mask;
        end
        new_mask = mask3.*abs(mask3-mask);%��ֹģ����ص�
        finan_output = new_mask.*II+finan_I;
        new_mask = abs(new_mask+mask)>0;
    case 4 
%����������
        mask4 = zeros(row,col);
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
            mask4 = mask4+temp_mask;
        end
        new_mask = mask4.*abs(mask4-mask);%��ֹģ����ص�
        finan_output = new_mask.*II+finan_I;
        new_mask = abs(new_mask+mask)>0;
%         imshow(mask4)
end
      
% imshow(mask1+mask2+mask3+mask4)



