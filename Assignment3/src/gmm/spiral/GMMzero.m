function [xTest,Fmean,Fpi,FC]=GMMzero()

HighWay=importdata('zero1.txt');
[DOrig,NOrig]=size(HighWay);
xTrain=HighWay(1:0.7*DOrig,:);
[D,N]=size(xTrain);
%xTrain=(xTrain-ones(D,1)*mean(xTrain))/(det(cov(xTrain)));
K=10;
[idx,meanK]=kmeans(xTrain,K);
piK=zeros(K,1);
xk=cell(K,1);
for i=1:1:D
    piK(idx(i))=piK(idx(i))+1;
    xk{idx(i),1}=[xk{idx(i),1}; xTrain(i,:)];
end
C=cell(K,1);
for i=1:K
    C{i}=cov(xk{i});
end

piK=piK/D;

OutPut=cell(K,3);
for i=1:K
    OutPut{i,1}=meanK(i,:);
    OutPut{i,2}=piK(i,:);
    OutPut{i,3}=C{i};
    
end

[Fmean,Fpi,FC]=GMM(meanK,piK,C,xTrain);


xTest=HighWay(0.7*DOrig+1:DOrig,:);
end
