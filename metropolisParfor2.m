function g=metropolisParfor2(data,sampleSize,errorSd,prior,pool)
m=pool.NumWorkers;
n=ceil(sampleSize/m);
g=zeros(n,m);
parfor i=1:m
    g(:,i)=metropolis(data,n,errorSd,prior);
end
g=reshape(g,n*m,1);
g=g(length(g)-sampleSize+1:length(g));