function S = WJG_convex_S(w,vx,vy)
%�ú���ʵ�ֵĹ���Ϊָ��ͼ���ж���εĶ��㣬�������ڸ�͹������е��������ص�
%xv��yvΪ�������갴��˳ʱ�������ʱ�롣vx(1) = xv(end); yv(1) = yv(end)
%�����w�Ǵ�С��vx vy���������Ƕ������ꡣ
%���SΪ��ǩ����
 
row = w;
col = w;
[A,B]=meshgrid(1:row,1:col);
S = inpolygon(A,B,vy,vx);
 