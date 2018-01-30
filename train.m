function [t,ES,EF]=train(eigenDim)
% return test index,eigen space,eigen face
disp('Begin train phase');
tic;
X=zeros();
EigFace=cell(1,40);
classNum=40;
sampleNum=7;
trainIndex=randperm(10,sampleNum);%10 samples per class
testIndex=setdiff((1:10),trainIndex);
t=testIndex;
for i=1:classNum
    for j=trainIndex()
        I=reshape(imread(['att_faces/s',num2str(i),'/',num2str(j),'.pgm']),1,[]);
        if size(X)==[1,1]
            X=I;
        else
            X=[X;I];            
        end
    end
end
X=X';
X=double(X);                                    %centralise or mean face
H=(X-mean(X,2))/sqrt(classNum*sampleNum-1);     % 1/sqrt(samples - 1)
% S=cell(1,40); %covariance matrix set S=X{i}*X{i}'
disp(['X   ',num2str(size(X))]);
disp(['H   ',num2str(size(H))]);
[Q,R]=qr(H);
[~,D,V]=svd(R');
disp(['Q   ',num2str(size(Q))]);
disp(['R   ',num2str(size(R))]);
disp(['D   ',num2str(size(D))]);
disp(['V   ',num2str(size(V))]);
%     S{i}=Q*V*D'*D*V'*Q';
%     S{i}=H{i}*H{i}';
%     [eigVec eigVal]=eig(S{i});
h=diag(D);
h=h(1:eigenDim);
[vL,~]=size(V);
temp=zeros(vL,eigenDim);
for j=1:eigenDim
    temp(:,j)=V(:,j);
end
EigSpace=Q*temp;
temp=EigSpace'*X;
for i=1:classNum
    EigFace{i}=temp(:,(i-1)*sampleNum+1:(i-1)*sampleNum+7);
end
ES=EigSpace;
EF=EigFace;
time=toc;
disp(['train time:',num2str(time),' seconds']);
