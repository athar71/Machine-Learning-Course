%%
clear all
clc
close all

[data_circle,label_circle]=sample_circle(3,[500;500;500] );
[data_spiral,label_spiral]=sample_spiral(3,[500;500;500] );

for j=1:1500
    % W_c(:,j)=-0.5*(1/0.2^2)*sum((data_circle-repmat(data_circle(j,:),1500,1) ).^2,2);
    %
    % W_s(:,j)=-0.5*(1/0.2^2)*sum((data_spiral-repmat(data_spiral(j,:),1500,1) ).^2,2);
    
    
    Xm_c = bsxfun(@minus,data_circle,data_circle(j,:));
    W_c(:,j) = dot(Xm_c,Xm_c,2);
    
    Xm_s = bsxfun(@minus,data_spiral,data_spiral(j,:));
    W_s(:,j) = dot(Xm_s,Xm_s,2);
    
    
    
end
W_c=exp(W_c./(-2*0.2^2));
W_s=exp(W_s./(-2*0.2^2));

D_c=diag(sum(W_c,2));
D_s=diag(sum(W_s,2));


%% Part i
L1_c=D_c-W_c;
L1_s=D_s-W_s;
[V1_c,D1_c] = eig(L1_c);

[~,a_c]=size(V1_c);
norm_V1_c=(sum(V1_c.^2,2)).^0.5;
V1_c_norm=V1_c./repmat(norm_V1_c,1,a_c,1);

[V1_s,D1_s] = eig(L1_s);
[~,I] = sort(diag(D1_s));
V1_s=V1_s(:,I);
[~,a_s]=size(V1_s);
norm_V1_s=(sum(V1_s.^2,2)).^0.5;
V1_s_norm=V1_s./repmat(norm_V1_s,1,a_s,1);

L2_c=D_c^(-1)*(L1_c);
L2_s=D_s^(-1)*(L1_s);
[V2_c,D2_c] = eig(L2_c);
[V2_s,D2_s] = eig(L2_s);
[~,I] = sort(diag(D2_s));
V2_s=V2_s(:,I);

[~,a2_c]=size(V2_c);
norm_V2_c=(sum(V2_c.^2,2)).^0.5;
V2_c_norm=V2_c./repmat(norm_V2_c,1,a2_c,1);
[~,a2_s]=size(V2_s);
norm_V2_s=(sum(V2_s.^2,2)).^0.5;
V2_s_norm=V2_s./repmat(norm_V2_s,1,a2_s,1);


L3_c=D_c^(-0.5)*(L1_c)*D_c^(-0.5);
L3_s=D_s^(-0.5)*(L1_s)*D_s^(-0.5);
[V3_c,D3_c] = eig(L3_c);

[~,a3]=size(V3_c);
norm_V3_c=(sum(V3_c.^2,2)).^0.5;
V3_c_norm=V3_c./repmat(norm_V3_c,1,a3,1);
[V3_s,D3_s] = eig(L3_s);
[~,I] = sort(diag(D3_s));
V3_s=V3_s(:,I);
[~,a3_s]=size(V3_s);
norm_V3_s=(sum(V3_s.^2,2)).^0.5;
V3_s_norm=V3_s./repmat(norm_V3_s,1,a3_s,1);
figure(1)

subplot(3,2,1)
plot(1:1500,sort(diag(D1_c)))
title('circle shape data,sc__1')
subplot(3,2,2)
plot(1:1500,sort(diag(D1_s)))
title('spiral shape data,sc__1')

subplot(3,2,3)
plot(1:1500,sort(diag(D2_c)))
title('circle shape data,sc__2')
subplot(3,2,4)
plot(1:1500,sort(diag(D2_s)))
title('spiral shape data,sc__2')

subplot(3,2,5)
plot(1:1500,sort(diag(D3_c)))
title('circle shape data,sc__3')
subplot(3,2,6)
plot(1:1500,sort(diag(D3_s)))
title('spiral shape data,sc__3')
%% Part ii
k=1;
l=2;
figure(2)

for i=2:4
    rng(2)
    [idx1,~]= kmeans(V3_c_norm(:,1:i),i);
    rng(2)
    [idx2,~]= kmeans(V3_s_norm(:,1:i),i);
    
    subplot(3,2,k)
    gscatter(data_circle(:,1),data_circle(:,2),idx1,'rbgk')
    hold on
    
    title(['SC-3-circle shaped dataset k= ' num2str(i)])
    k=k+2;
    subplot(3,2,l)
    gscatter(data_spiral(:,1),data_spiral(:,2),idx2,'rbgk')
    hold on
    
    title(['SC-3-spiral shaped dataset k= ' num2str(i)])
    l=l+2;
    
end

%%
i=3;

[idx1,~]= kmeans(V1_c_norm(:,1:i),i);

[idx1_s,~]= kmeans(V1_s_norm(:,1:i),i);

[idx2,~]= kmeans(V2_c_norm(:,1:i),i);

[idx2_s,~]= kmeans(V2_s_norm(:,1:i),i);
[idx3,~]= kmeans(V3_c_norm(:,1:i),i);

[idx3_s,~]= kmeans(V3_s_norm(:,1:i),i);

figure(3)

subplot(3,2,1)
hold on
plot3(V1_c_norm(idx1==1,1),V1_c_norm(idx1==1,2),V1_c_norm(idx1==1,3),'r.')
plot3(V1_c_norm(idx1==2,1),V1_c_norm(idx1==2,2),V1_c_norm(idx1==2,3),'b.')
plot3(V1_c_norm(idx1==3,1),V1_c_norm(idx1==3,2),V1_c_norm(idx1==3,3),'g.')
title('circle shape data,sc__1,k=3')
hold off

subplot(3,2,2)
hold on
plot3(V1_s_norm(idx1==1,1),V1_s_norm(idx1==1,2),V1_s_norm(idx1==1,3),'r.')
plot3(V1_s_norm(idx1==2,1),V1_s_norm(idx1==2,2),V1_s_norm(idx1==2,3),'b.')
plot3(V1_s_norm(idx1==3,1),V1_s_norm(idx1==3,2),V1_s_norm(idx1==3,3),'g.')
title('spiral shape data,sc__1,k=3')
hold off

subplot(3,2,3)
hold on
plot3(V2_c_norm(idx1==1,1),V2_c_norm(idx1==1,2),V2_c_norm(idx1==1,3),'r.')
plot3(V2_c_norm(idx1==2,1),V2_c_norm(idx1==2,2),V2_c_norm(idx1==2,3),'b.')
plot3(V2_c_norm(idx1==3,1),V2_c_norm(idx1==3,2),V2_c_norm(idx1==3,3),'g.')
title('circle shape data,sc__2,k=3')
hold off

subplot(3,2,4)
hold on
plot3(V2_s_norm(idx1==1,1),V2_s_norm(idx1==1,2),V2_s_norm(idx1==1,3),'r.')
plot3(V2_s_norm(idx1==2,1),V2_s_norm(idx1==2,2),V2_s_norm(idx1==2,3),'b.')
plot3(V2_s_norm(idx1==3,1),V2_s_norm(idx1==3,2),V2_s_norm(idx1==3,3),'g.')
title('spiral shape data,sc__2,k=3')
hold off

subplot(3,2,5)
hold on
plot3(V3_c_norm(idx1==1,1),V3_c_norm(idx1==1,2),V3_c_norm(idx1==1,3),'r.')
plot3(V3_c_norm(idx1==2,1),V3_c_norm(idx1==2,2),V3_c_norm(idx1==2,3),'b.')
plot3(V3_c_norm(idx1==3,1),V3_c_norm(idx1==3,2),V3_c_norm(idx1==3,3),'g.')
title('circle shape data,sc__3,k=3')
hold off

subplot(3,2,6)
hold on
plot3(V3_s_norm(idx1==1,1),V3_s_norm(idx1==1,2),V3_s_norm(idx1==1,3),'r.')
plot3(V3_s_norm(idx1==2,1),V3_s_norm(idx1==2,2),V3_s_norm(idx1==2,3),'b.')
plot3(V3_s_norm(idx1==3,1),V3_s_norm(idx1==3,2),V3_s_norm(idx1==3,3),'g.')
title('spiral shape data,sc__3,k=3')
hold off











