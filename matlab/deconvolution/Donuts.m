[X,Y] = meshgrid(1:100,1:100)
sphere = zeros(100,100)

sphere( ((X-50).^2 + (Y-50).^2)<100 ) = 1;

imagesc(sphere)

kernel1=zeros(21,21);
kernel2=zeros(21,21);

kernel1(11,11)=1;
kernel2(11,11)=1;

kernel1=imgaussfilt(kernel1, 2.0);
kernel2=imgaussfilt(kernel1, 4.0);

subplot(3,2,1)
imagesc(kernel1)
title('Kernel sigma=2.0');

subplot(3,2,2)
imagesc(kernel2)
title('Kernel sigma=4.0');

convolved=conv2(sphere, kernel1);

subplot(3,2,3)
imagesc(convolved)
title('Convolved sigma=2.0');

[deconvolved1, psf1]=deconvblind(convolved, kernel1, 50);

[deconvolved2, psf2]=deconvblind(convolved, kernel2, 50);
[deconvolved3, psf2]=deconvblind(convolved, kernel2, 500);

subplot(3,2,4)
imagesc(deconvolved1)
title('50 iterations blind deconvolution, initial guess sigma=2.0');

subplot(3,2,5)
imagesc(deconvolved2)
title('50 iterations blind deconvolution, initial guess sigma=4.0');

subplot(3,2,6)
imagesc(deconvolved3)
title('500 iterations blind deconvolution, initial guess sigma=4.0');

image_array=[kernel1, kernel2, convolved; deconvolved1, deconvolved2, deconvolved3];
imshow(image_array, ['a', 'b', 'c';'d','e','f']);




