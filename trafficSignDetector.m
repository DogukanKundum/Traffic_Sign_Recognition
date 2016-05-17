
function [] = trafficSignDetector( input_img ) % Ana Fonksiyon

%[filename, pathname] = uigetfile({'*.*'}, 'Pick an Image File');
 %oImg=imread([pathname,filename]);
 oImg = imread('C:\Users\KUNDUM\Desktop\Resimler\5.jpg');
 %clcoImg = imread(input_img); % Orjinal Resmi oku
 binImg = trafficSignToBinImg(oImg); % Orjinal resmi ikilik formata çevirip gerekli iyileştirmeleri yapan fonk.
 test_vector = displayTrafficSign(binImg, oImg); % İkilik resimdeki verilere göre trafik işaretlerini bulup gösteren fonk.

 uzanti = '.jpg';
 
    for i = 1:7
    
        v_isim = strcat(int2str(i),uzanti);
     
        v_resim = strcat('C:\Users\KUNDUM\Desktop\Resimler\Yeni klasör\',v_isim);
        
        veri_resim = imread(v_resim);
     
        binImg = trafficSignToBinImg(veri_resim); % Orjinal resmi ikilik formata çevirip gerekli iyileştirmeleri yapan fonk.
        data_vector = displayTrafficSign(binImg, veri_resim); % İkilik resimdeki verilere göre trafik işaretlerini bulup gösteren fonk.
        
     end
 end

