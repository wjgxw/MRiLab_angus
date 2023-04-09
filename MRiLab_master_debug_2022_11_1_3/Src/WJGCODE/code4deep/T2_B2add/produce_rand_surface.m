function  rand_surf= produce_rand_surface(y_num, x_num,kernel_size)

rand_k_space=zeros(y_num,x_num);
matrix_r=zeros(2*floor(kernel_size/2)+1,2*floor(kernel_size/2)+1);
center_pos=floor(kernel_size/2)+1;
for i=1:1:2*floor(kernel_size/2)+1
    for j=1:1:2*floor(kernel_size/2)+1
        matrix_r(i,j)=4*sqrt((i-center_pos)*(i-center_pos)+(j-center_pos)*(j-center_pos))/center_pos;
    end
end

kernel_data=exp(-matrix_r.*matrix_r);
rand_k_space(y_num/2-floor(kernel_size/2):y_num/2+floor(kernel_size/2), x_num/2-floor(kernel_size/2):x_num/2+floor(kernel_size/2))= kernel_data.*(rand(2*floor(kernel_size/2)+1,2*floor(kernel_size/2)+1)-0.5);

rand_image_space=real(ifft2c(rand_k_space));
max_value=max(max(rand_image_space));
min_value=min(min(rand_image_space));
rand_surf=rand()*(rand_image_space-min_value)/(max_value-min_value);
end