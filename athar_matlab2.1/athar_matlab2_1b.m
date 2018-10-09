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
%Hour=hour(Dates);
load('tmp.mat','Hour');
Hour1=Hour+ones(length(Dates),1);
H=dummyvar(Hour1);

clear Hour1
%total Data
T=[H,D,P]';
%v=randperm(length(Category));
q=(1:526829);
testlabel=(526830:length(Category));
Train=T(:,q);
Test=T(:,testlabel);
I2=unique(Category);
I1=unique(PdDistrict);
%finding real class of test data
dummytest=C(testlabel,:);
[testclass,~] = find(dummytest');



%%  Step 2
% clc
% close all
% clear 


%load('tmp2.mat');
dummytrain=C(q,:);
[trainclass,~] = find(dummytrain');

%gradiant descent algorithm
w=zeros(41,length(I2));
lamda=1000;
y=[];
loglossv=zeros(1,1000);
counter=0;


len_I2 = length(I2);

for i=1:1000
    disp('grad Start')
    tic
    w=w-(10^(-5)).*gradient(w,Train,len_I2,trainclass,lamda);
    toc
    counter=counter+1

    y=[y,fNLL(w,Train,len_I2,trainclass,lamda)];
    loglossv(i)=logloss(Test,C(testlabel,:),w);
    
    %finding CCR
    %estimated class
    [~,predict]=max(w'*Test);
    labelCCR=predict==testclass';
    CCR(i)=(sum(labelCCR))/length(testlabel);
    
end
save('matlab_b.mat','CCR','y','loglossv');
figure;
plot(1:length(y),y,'b')
title('objective function against #of iteration')
xlabel('iteration')
ylabel('objective function')

figure(2);
plot(1:1000,loglossv,'b')
title('logloss against #of iteration')
xlabel('iteration')
ylabel('logloss')

figure(3);
plot(1:1000,CCR,'r')
title('CCR against #of iteration')
xlabel('iteration')
ylabel('CCR')
%savefig('CCR.jpg')
