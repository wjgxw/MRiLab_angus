% close all
Sx = VImg.Sx;
Sy = VImg.Sy;
[row,col,~,slice] = size(Sx);
length = row*col;
datapoint=[];
for loopi = 1:slice %multi epi
    Sx_t = Sx((loopi-1)*length+1:loopi*length);
    Sy_t = Sy((loopi-1)*length+1:loopi*length);
    K1 = Sx_t+1i*Sy_t;
    K1 = reshape(K1,[row,col]);
%     imagesc(abs(K1));colormap jet
%     set(gca,'position',[0 0 1 1]);
    I1 = fftshift(ifftn(fftshift(K1)));
    datapoint=[datapoint,I1(22,38),I1(31,21),I1(47,39)];
    figure(loopi);imagesc(abs(I1));colormap jet
    set(gca,'position',[0 0 1 1]);
end
abs(datapoint)

