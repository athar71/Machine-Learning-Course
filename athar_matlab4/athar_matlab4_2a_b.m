%%
clear
clc
load('BostonListing.mat');
data=[latitude, longitude];

for j=1:2558
    % W(:,j)=-0.5*(1/0.1^2)*sum((data-repmat(data(j,:),2558,1) ).^2,2);
    Xm = bsxfun(@minus,data,data(j,:));
    W(:,j) = dot(Xm,Xm,2);
    
end
W=exp(W./(-2*0.1^2));
D=diag(sum(W,2));
L1=D-W;
L3=D^(-0.5)*(L1)*D^(-0.5);
L3 = 1/2*(L3+L3');
[V3,D3] = eig(L3);
[~,I] = sort(diag(D3));
V3=V3(:,I);
[~,a3]=size(V3);
norm_V3=(sum(V3.^2,2)).^0.5;
V3_norm=V3./repmat(norm_V3,1,a3);

%preparing the ground _truth classes
A=unique(neighbourhood);
AA=zeros(2558,1);
for k=1:length(A)
    tf = strcmp(neighbourhood,A(k));
    AA(tf)=k*ones(sum(tf),1);
end


for k=1:25
    rng(2)
    [idx1,~]= kmeans(V3_norm(:,1:k),k);
    
    for i=1:k
        for j=1:25
            label=idx1==i;
            n(i,j)=sum(AA(label)==j);
            
        end
        
    end
    nn=max(n,[],2);
    Purity_metric(k)=sum(nn)/2558;
end
figure(1)
plot(1:25,Purity_metric)
title('purity metric vs. number of clusters')
xlabel('k')
ylabel('purity metric')

%% Part B
figure(2)
k=5;

rng(2)
[idx2,~]= kmeans(V3_norm(:,1:k),k);


plot(longitude(idx2==1),latitude(idx2==1),'.r');
hold on;
plot(longitude(idx2==2),latitude(idx2==2),'.b');
plot(longitude(idx2==3),latitude(idx2==3),'.y');
plot(longitude(idx2==4),latitude(idx2==4),'.g');
plot(longitude(idx2==5),latitude(idx2==5),'.m');
plot_google_map;
hold off;