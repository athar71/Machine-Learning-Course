function [dpm] = athar_dpmeans(X, lambda)
% Dirichlet Process K-means
%  X: n x d data matrix
%  lambda: cluster penalty parameter
%
% Reference:
% B. Kulis and M. Jordan, "Revisiting k-means: New Algorithms via Bayesian Nonparametrics"

% DP-means parameters

K = 1;
[n,d] = size(X);

dpm.K = K;
dpm.d = d;
dpm.z=ones(n,1);
dpm.mu = mean(X);
dpm.sigma = 1;
dpm.pik = 1/K*ones(K,1);
dpm.nk = zeros(K,1);
% DP-means algorithm
max_iter = 1000;

fprintf('running dp-means...\n');
for iter = 1:max_iter
%  Calculate distances
for j=1:n
dist=zeros(1,dpm.K);
for k = 1:dpm.K
dist(k) = norm(X(j,:)-dpm.mu(k,:)).^2;
end
[dmin,z_min]=min(dist);
if dmin>lambda
dpm.K=dpm.K+1;
dpm.mu=[dpm.mu;X(j,:)];
else
dpm.z(j)=z_min;
end
end

for k=1:dpm.K
l=dpm.z==k;
dpm.mean(:,k)=mean(X(l,:));
end
end
end