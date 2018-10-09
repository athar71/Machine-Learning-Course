
%logloss
function logloss=logloss(Test,C,w)
s=0;
for i=1:length(Test)
    a=p(C(i,:),Test(:,i),w);
    s=s+log10(a);
end
logloss=(-1/length(Test))*s;

end