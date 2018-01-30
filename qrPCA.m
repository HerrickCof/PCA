function rate=qrPCA(eigenDim,method)
% Train and test
% arg1:eigen dimension=(1:TotalSamples)
% arg2:measure method
% method 1 Manhattan/L1()
% method 2 Euclidian/L2()
% method 3 Mahalanoibis(eigen dimension must less than classes)
[t,ES,EF]=train(eigenDim);
rate=test(t,ES,EF,method);

