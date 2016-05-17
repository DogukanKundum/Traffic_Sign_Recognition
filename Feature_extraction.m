function [ feature_vector ] = Feature_extraction( BW )

% gürültü giderme için filtre uygulanıyor
ortalama_filtre = fspecial('average');
filtreli_resim = imfilter(BW, ortalama_filtre,'replicate');
subplot(2,2,1); 
imshow(filtreli_resim); 
title('filtreli resim');

% kontrast arttırılmış resimden ortalama gri seviye değeri alınıyor
OGD = mean(mean(filtreli_resim));

canny_edge = edge(filtreli_resim,'canny');
subplot(2,2,2); 
imshow(canny_edge); 
title('canny');

sobel_edge = edge(filtreli_resim,'sobel');
subplot(2,2,3); 
imshow(sobel_edge);
title('sobel');

prewitt_edge = edge(filtreli_resim,'prewitt');
subplot(2,2,4); 
imshow(prewitt_edge);
title('prewitt');

% kontrast arrtırılmış resim, siyah-beyaza çevriliyor
gri_esik = graythresh(filtreli_resim); %siyah-beyaza çevirmek için eşik değeri otomatik olarak bulunuyor
rice_bw = im2bw(filtreli_resim,gri_esik); %resim_imadjust isimli resim, "level" değeri eşik kabul edilerek siyah-beyaz resme çevriliyor
rice_BW = bwareaopen(rice_bw,5); %"rice_bw" resminde, alanı 50 pikselden küçük nesneler siliniyor
figure; 
imshow(rice_BW); title('küçük nesneler silinmiş'); 
%improfile;

% siyah-beyaz resimdeki nesneler bulunuyor
cc = bwconncomp(rice_BW, 4); %4'lü piksel komşuluğu ile resimdeki nesneler belirleniyor.
tanecik_sayisi = cc.NumObjects;
rice_etiketli = labelmatrix(cc); %bulunan her nesne numaralandırılarak etiketleniyor
rice_RGB = label2rgb(rice_etiketli);
figure; 
imshow(rice_RGB); title('etiketleri renklendirilmiş');

%bulunan nesnelerden istenilen özellikler alınıyor
rice_verisi = regionprops(cc,'Centroid','Perimeter','Orientation'); %taneciklerden alan, ağırlık merkezi, çevre ve eğim bilgileri alınıyor
rice_merkezler = [rice_verisi.Centroid];
rice_cevreler = [rice_verisi.Perimeter];
rice_egimler = [rice_verisi.Orientation];

figure; plot(rice_cevreler,rice_egimler,'b*');
title('Alan ve eğim arasındaki ilişki');
xlabel('Alanlar(pixel)'); ylabel('Eğimler(derece)');


%farklı özellikler çıkarılıyor
EK_cevre = min(rice_cevreler); %en küçük cevre
EB_cevre = max(rice_cevreler); %en büyük cevre
EK_egim = min(rice_egimler); %en küçük eğim
EB_egim = max(rice_egimler); %en büyük eğim
EK_merkez = min(rice_merkezler);
EB_merkez = max(rice_merkezler);

%siyah piksel değerlerinin tamamı bulunuyor
top_siyah = 0;
top_beyaz = 0;
for a = 1:100
    for b = 1:100
        pixel = BW(a,b);
        if( pixel == 0)
            top_siyah = top_siyah + 1;
        end
        if( pixel > 0)
            top_beyaz = top_beyaz + 1;
        end
        
    end
end

%siyah piksel ile beyaz piksel oranı bulunuyor
bw_average = top_siyah/top_beyaz;

%özellik vektör, çıkarılan özelliklere göre oluşturuluyor
feature_vector = [OGD gri_esik tanecik_sayisi EK_cevre EB_cevre EK_egim EB_egim EK_merkez EB_merkez top_siyah top_beyaz bw_average];

end
