%gradiant 

function Result=gradient(w,x,len_I2,trainclass,lamda)
e=exp(x'*w);
z=sum(e,2);
Result=zeros(41,len_I2);
for i=1:len_I2
    
        
       label=trainclass==i; 
       A=e(:,i)./z;
       Result(:,i)=Result(:,i)+x*(A-label);
   
Result(:,i)=Result(:,i)+lamda*w(:,i);
end
end