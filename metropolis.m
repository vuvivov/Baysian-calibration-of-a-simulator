%generate posterior sample
%prior is a ProbDistUnivParam object
function g=metropolis(data,sampleSize,errorSd,prior)
g=zeros(sampleSize,1);
g(1)=mean(prior);metroSd=std(prior);
for i=1:(sampleSize-1)
    gg=random('norm',g(i),metroSd);
    alpha=min(1,piTauG(gg,data(:,2),data(:,1),errorSd,prior)/piTauG(g(i),data(:,2),data(:,1),errorSd,prior));
    u=random('unif',0,1);
    if u<alpha
        g(i+1)=gg;
    else
        g(i+1)=g(i);
    end
end