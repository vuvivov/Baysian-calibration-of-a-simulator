function g=metropolisGPUArray(data,sampleSize,n,errorSd,prior)
data=gpuArray(data);
sampleSize=gpuArray(sampleSize);
n=gpuArray(n);
errorSd=gpuArray(errorSd);
metroSd=gpuArray(std(prior));
g=gpuArray.zeros(1,sampleSize)+mean(prior);
for i=1:n
    gg=gpuArray.randn(size(g)).*metroSd+g;
    alpha=min(1,piTauG(gg,data(:,2),data(:,1),errorSd,prior)./piTauG(g,data(:,2),data(:,1),errorSd,prior));
    u=gpuArray.rand(size(g));
    change=(u<alpha);
    g=gg.*change+g.*(1-change);
end
g=gather(g');