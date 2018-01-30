function rate=test(t,ES,EF,method)
% method 1 Manhattan/L1
% method 2 Euclidian/L2
% method 3 Mahalanoibis(eigen dimension must less than sampleNum(7))
disp('Begin test phase');
rate=0;
classNum=40;
mEF=cell(1,40);
if ismember(method,[1,2,3])
    for i=1:classNum
        mEF{i}=mean(EF{i},2);
    end
    for i=1:classNum
        for k=1:3
            I=imread(['att_faces/s',num2str(i),'/',num2str(t(k)),'.pgm']);
            I=reshape(I,[],1);
            I=double(I);
            y=ES'*I;
            sum=zeros(classNum,1);
            if method == 1
                for l=1:classNum
                    sum(l)=norm(mEF{l}-y,1);%Manhattan L1
                end
            elseif method ==2
                for l=1:classNum
                    sum(l)=norm(mEF{l}-y,2);%Euclidian L2
                end
            elseif method == 3
                for l=1:classNum
%                     sum(l)=mahal(y',EF{l}');
                    temp=cov(EF{l}')^-1;
                    sum(l)=(y-mEF{l})'*temp*(y-mEF{l});
                end
            end
            c=find(sum==min(sum));
            if i==c
                rate=rate+1;
                %disp(['s',num2str(i),'/',num2str(t(k)),'.pgm is matched.']);
            else
                disp(['s',num2str(i),'/',num2str(t(k)),'.pgm is not matched. Wrong ans is ',num2str(c),'.']);
            end
        end
    end
    disp(['ratio:',num2str(rate/1.2),'%']);
else
    disp('wrong method number,try help');
end