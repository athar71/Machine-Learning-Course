function fNLL=fNLL(w,x,len_I2,trainclass,lamda)
%defining NLL
A=exp(w'*x);
A=log(sum(A));
A=sum(A);
s=0;
d=0;
for i=1:len_I2
   label=trainclass==i; 
    s=s+(w(:,i))'*x*(label);
    d=d+lamda*0.5*(norm(w(:,i)))^2;
end
fNLL=d-s+A;
end