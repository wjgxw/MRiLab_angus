function [ c ] = WJGgenCircle(w,r,center)
%GENCIRCLE Summary of this function goes here
%   Detailed explanation goes here
%   w ��ģ��Ĵ�С
%   r Բ��ģ��İ뾶
%   center Բ��
[rr cc] = meshgrid(1:w);
c = sqrt((rr-center(1)).^2 + (cc-center(2)).^2) <= r;
end