function [ c ] = WJGgenRing( w,r1,r2,center )
%GENRING Summary of this function goes here
%   Detailed explanation goes here
%   r1��r2 �ֱ�Ϊ��뾶���ڰ뾶��r1Ӧ����r2
c1 = WJGgenCircle(w,r1,center);
c2 = WJGgenCircle(w,r2,center);
c = c1 & ~c2;
end