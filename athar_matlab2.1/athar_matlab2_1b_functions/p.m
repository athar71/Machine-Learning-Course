%p
function p=p(Cj,xj,w)
a=sum(Cj*w'*xj);
Z=z(w,xj);
p=exp(a)/Z;
end