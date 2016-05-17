function [] = trafficSignDetector( input_img ) % Ana Fonksiyon

close all;
clear;
clc;

 %[filename, pathname] = uigetfile({'*.*'}, 'Pick an Image File');
 %oImg=imread([pathname,filename]);
 oImg = imread('C:\Users\KUNDUM\Desktop\Resimler\9.jpg');
 %clcoImg = imread(input_img); % Orjinal Resmi oku
 binImg = trafficSignToBinImg(oImg); % Orjinal resmi ikilik formata çevirip gerekli iyileştirmeleri yapan fonk.
 test_vector = displayTrafficSign(binImg, oImg); % İkilik resimdeki verilere göre trafik işaretlerini bulup gösteren fonk.

 uzanti = '.jpg';
 en_kucuk = 9999;
 
    for i = 1:7
    
        v_isim = strcat(int2str(i),uzanti);
     
        v_resim = strcat('C:\Users\KUNDUM\Desktop\Resimler\Yeni klasör\',v_isim);
        
        veri_resim = imread(v_resim);
     
        binImg = trafficSignToBinImg(veri_resim); % Orjinal resmi ikilik formata çevirip gerekli iyileştirmeleri yapan fonk.
        data_vector = displayTrafficSign(binImg, veri_resim); % İkilik resimdeki verilere göre trafik işaretlerini bulup gösteren fonk.
        
        sonuc = test_vector - data_vector;
        
        sonuc = sonuc.^2;
        
        sum_vector = sum(sonuc);
        
        degerlendirme = sqrt(sum_vector);
   
        if (en_kucuk >= degerlendirme)
            en_kucuk = degerlendirme;
            data_indeks = i;
            resim = veri_resim;
        end
        
    end
    
    if( data_indeks == 1 )
        h = msgbox('Yaya Geçidi','Success');
    end
    
    if( data_indeks == 2 )
        ...
    end
    
    if( data_indeks == 3 )
        ...
    end
    
    if( data_indeks == 4 )
        ...
    end
    
    if( data_indeks == 5 )
        ...
    end
    
    if( data_indeks == 6 )
        ...
    end
    
    if( data_indeks == 7 )
        ...
    end
     
 end
