%%
clear all
clc
close all

[data_circle,label_circle]=sample_circle(3,[500;500;500] );

[THETA_c,RHO_c] = cart2pol(data_circle(:,1),data_circle(:,2));
k=1;
rng(2)
%linear scaling
THETA_cc=(THETA_c-min(THETA_c).*ones(length(THETA_c),1))./(max(THETA_c)-min(THETA_c));
RHO_cc=(RHO_c-min(RHO_c).*ones(length(RHO_c),1))./(max(RHO_c)-min(RHO_c));

dist_c_2=zeros(4,4);
sum1=zeros(4,3)
Data=[THETA_cc,RHO_cc];
for i=2:4
    center_c=zeros(1500,2);
    rng(2)
    [idx1,C1]= kmeans(Data,i,'Distance','cityblock',...
        'Replicate',20);
    
    
    
    subplot(3,2,k)
    gscatter(THETA_cc,RHO_cc,idx1,'rbgk')
    hold on
    scatter(C1(:,1),C1(:,2),'filled')
    title(['circle shaped dataset k= ' num2str(i)])
    k=k+1;
    %     C1(:,1)=min(THETA_c)+C1(:,1)*(max(THETA_c)-min(THETA_c));
    %     C1(:,2)=min(RHO_c)+C1(:,2)*(max(RHO_c)-min(RHO_c));
    %     [C1(:,1),C1(:,2)]=pol2cart(C1(:,1),C1(:,2));
    %
    %     for j=1:1500
    %
    %         center_c(j,:)=C1(idx1(j),:);
    %
    %     end
    %
    %     for j=1:1500
    %
    %         center_c(j,:)=C1(idx1(j),:);
    %
    %     end
    %     dist_c=(data_circle-center_c).^2;
    %
    %     for kk=1:i
    %         label1=idx1==kk;
    %
    %
    %     dist_c_2(kk,i-1)=sum(sum(dist_c(label1,:),2));
    %
    %
    %      end
       for j=1:1500
    
            center_c(j,:)=C1(idx1(j),:);
    
        end
          dist_c=([THETA_cc,RHO_cc]-center_c).^2;
    % %     [dist_cc(:,1),dist_cc(:,2)]=pol2cart(dist_c(:,1),dist_c(:,2));
    % %     dist_cc=dist_cc.^2;
    %     %     dist_c_2(i)=sum(sum(dist_c,2));
        for kk=1:i
            label1=idx1==kk;
            dist_c_2(kk,i-1)=sum(sum(dist_c(label1,:),2));
        end
    
end