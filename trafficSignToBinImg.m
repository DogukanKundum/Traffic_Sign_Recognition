function [ BW ] = trafficSignToBinImg( trafikResmi )
 
hsvFormat= rgb2ntsc(trafikResmi); % RGB renk uzayından NTSC renk uzayına dönüşüm yapılıyor

a = hsvFormat(:,:,1);

b = hsvFormat(:,:,2);

c = hsvFormat(:,:,3); % HSV -&gt; 3. parametre yani value (brighness veya parlaklık) kullanılıyor

c = c+b;

out = filter2(fspecial('gaussian', 3), c); % filtre kullanılarak kalite arttırılıyor

out = out.*c; 

BW = im2bw(10*out,0.2); % Görüntü siyah-beyaz hale getiriliyor ve beyazlıkların belirginliği arttırılıyor

BW = bwareaopen(BW, 30); % Küçük objeler temizleniyor

BW = imdilate(BW, strel('disk',4)); % Dilation morfolojik işlemi uygulanıyor

BW = imdilate(BW,strel('disk',1)); % Dilation morfolojik işlemi uygulanıyor

BW = imerode(BW, strel('diamond', 3)); % Erode morfolojik işlemi uygulanıyor

BW = filter2(fspecial('average', 3), BW); % Kenarlıkları kalınlaştırıyoruz
%figure, imshow(BW); title('aaa'); % Orjinal resmi ekrana basar
 
end
