function [ ozellik_vektor ] = displayTrafficSign( bin_img, original )
 
 [num, L] = bwboundaries(bin_img, 4, 'noholes'); % Objelerin sınırlarını seçer
 stats = regionprops(L, 'basic'); % objelerin özelliklerini elde eder
 figure, imshow(original); % Orjinal resmi ekrana basar
 
 for k=1 : length(num) % Resimdeki tüm objeleri tarar
 
 coords = stats(k).BoundingBox; % Sınır koordinatlar
 x1 = coords(1);
 y1 = coords(2);
 x2 = x1 + coords(3);
 y2 = y1 + coords(4);
 
 x2 = floor(x2);
 y2 = floor(y2);
 
 eulerNumber = bweuler(bin_img(y1:y2, x1:x2)); % Objenin içinde boşluk var mı?
 
 if(eulerNumber<1) % Eğer objenin içinde boşluk veya boşluklar varsa bu bir trafik işaretidir, çerçeve içine al

 hold on
 
 x3 = x2-x1;
 y3 = y2-y1;
 I2 = imcrop(original,[x1 y1 x3 y3]);
 
 I3 = imresize(I2, [100 100]);
 figure, imshow(I3);
 
 temp = trafficSignToBinImg(I3);
 
 hsvFormat= rgb2ntsc(I3); % RGB renk uzayından NTSC renk uzayına dönüşüm yapılıyor

 a = hsvFormat(:,:,1);

 bw1=imfill(temp,'holes'); %Resimde çukur diye nitelendirilen yerleri dolduruyoruz.

 bw2 = bw1.*a;
 
 %bw=im2bw(bw2,0.5); %Resim tamamen siyah-beyaz piksellere dönüştü.

 bw = filter2(fspecial('average', 3), bw2); % Kenarlıkları kalınlaştırıyoruz
 
 figure,imshow(bw);
 
 ozellik_vektor = feature_extraction(bw);
 
 hold off
 
 end
 
 end
    
end
