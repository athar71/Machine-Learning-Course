%%
clear all
clc
close all

[data_circle,label_circle]=sample_circle(3,[500;500;500] );
[data_spiral,label_spiral]=sample_spiral(3,[500;500;500] );


k=1;
l=2;
rng(2)
dist_s_2=zeros(4,4);
dist_c_2=zeros(4,4);

for i=2:4
    center_c=zeros(1500,2);
    center_s=zeros(1500,2);
    [idx1,C1]= kmeans(data_circle,i,'Distance','sqeuclidean',...
        'Replicates',20);
    
    [idx2,C2]= kmeans(data_spiral,i,'Distance','sqeuclidean',...
        'Replicates',20);
    
    subplot(3,2,k)
    gscatter(data_circle(:,1),data_circle(:,2),idx1,'rbgk')
    hold on
    scatter(C1(:,1),C1(:,2),'filled','m')
    title(['circle shaped dataset k= ' num2str(i)])
    k=k+2;
    subplot(3,2,l)
    gscatter(data_spiral(:,1),data_spiral(:,2),idx2,'rbgk')
    hold on
    scatter(C2(:,1),C2(:,2),'filled','m')
    title(['spiral shaped dataset k= ' num2str(i)])
    l=l+2;
    
    for j=1:1500
        
        center_c(j,:)=C1(idx1(j),:);
        center_s(j,:)=C2(idx2(j),:);
    end
    dist_c=(data_circle-center_c).^2;
    dist_s=(data_spiral-center_s).^2;
    for kk=1:i
        label1=idx1==kk;
         label2=idx2==kk;
    
    dist_c_2(kk,i-1)=sum(sum(dist_c(label1,:),2));
    
    dist_s_2(kk,i-1)=sum(sum(dist_s(label2,:),2));
    end
end
