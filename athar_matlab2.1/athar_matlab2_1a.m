
clear
clc
load('data_SFcrime_train')
clear Address X Y


%load('data_SFcrime_test');
%making binary matrix for pdistrict, P as place, C as Category
P=nominal(PdDistrict);
P=dummyvar(P);
C=nominal(Category);
C=dummyvar(C);
%making binary matrix for day of week
Day=weekday(Dates);
D=dummyvar(Day);

%making binary matrix for hour
Hour=hour(Dates);


Hour1=Hour+ones(length(Dates),1);
H=dummyvar(Hour1);

clear Hour1


figure;
hist(Day)
xlabel('Daynumber')
title('DayOfWeek histograms')
set(get(gca,'child'),'FaceColor','b');


figure(2);
hist(categorical(PdDistrict))
xlabel('police department district')
title('PdDistrict histograms')
set(get(gca,'child'),'FaceColor','c');
figure(3);
hist(Hour)
xlabel('hour')
title('Hour histograms')
set(get(gca,'child'),'FaceColor','g');
%it is alphabetically sorted, so the binary crime with nth element 1 is the
%nth element in I2
I2=unique(Category);

%cat=[idx2,cat1];

%most likely hour of occurrence of each type of crime
for i=1:length(I2)
   label=strcmp(Category,I2(i));
   Hs=sum(H(label,:));
   [~,L]=sort(Hs,'descend');
   A(i,:)=[I2(i),L(1)-1];
   
    
end
I1=unique(PdDistrict);


%most likely  type of crime within each PdDistrict
B=[];
for i=1:length(I1)
   label2=strcmp(PdDistrict(:,1),I1(i));
   Cs=sum(C(label2,:));
   [~,L]=sort(Cs,'descend');

   B=[B;I1(i),I2(L(1))];
   
    
end
load('data_SFcrime_test');
clear Address X_test Y_test



%making binary matrix for pdistrict, P as place, C as Category
Ptest=nominal(PdDistrict_test);
Ptest=dummyvar(Ptest);

%making binary matrix for day of week
Daytest=weekday(Dates_test);
Dtest=dummyvar(Daytest);

%making binary matrix for hour
Hourtest=hour(Dates_test);
Hour1test=Hourtest+ones(length(Dates_test),1);
Htest=dummyvar(Hour1test);

clear Hour1test



