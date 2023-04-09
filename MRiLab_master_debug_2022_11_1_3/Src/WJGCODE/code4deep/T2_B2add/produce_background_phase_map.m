function  current_map= produce_background_phase_map(expand_num)
current_map=zeros(expand_num,expand_num);
rand_coeff_team=rand(1,20)-0.5;
for i=1:1:expand_num
    for j=1:1:expand_num
        
        current_x_length=(j-expand_num/2)/expand_num;  % 0~1
        current_y_length=(i-expand_num/2)/expand_num; % 0~1
        
        current_map(i,j)=2*rand_coeff_team(20)-rand_coeff_team(1)*current_x_length-rand_coeff_team(2)*current_y_length...
            -rand_coeff_team(3)*current_x_length*current_x_length-rand_coeff_team(4)*current_x_length*current_y_length-rand_coeff_team(5)*current_y_length*current_y_length...
            -rand_coeff_team(6)*current_x_length*current_x_length*current_x_length-rand_coeff_team(7)*current_y_length*current_y_length*current_y_length...
            +rand_coeff_team(8)*exp(-2*(rand_coeff_team(9))*current_x_length*current_x_length)+rand_coeff_team(10)*exp(-2*(rand_coeff_team(11))*current_y_length*current_y_length);
        
    end
end
rand_surf= produce_rand_surface(expand_num, expand_num,8);
current_map=current_map+0.2*rand()*rand_surf;
max_value=max(max(max(abs(current_map))));
current_map=(0.5*rand()+0.5)*pi*current_map/max_value;
end
