function g=metropolisParfor(data,sampleSize,errorSd,prior,pool)
m=pool.NumWorkers;n=ceil(sampleSize/m);
g=zeros(n,m);metroSd=std(prior);
gg=zeros(m,1);alpha=gg;u=gg;g0=gg+mean(prior);
parfor ii=1:m
    for i=1:n
        gg(ii)=random('norm',g0(ii),metroSd);
        alpha(ii)=min(1,piTauG(gg(ii),data(:,2),data(:,1),errorSd,prior)/piTauG(g0(ii),data(:,2),data(:,1),errorSd,prior));
        u(ii)=random('unif',0,1);
        if u(ii)<alpha(ii)
            g(i,ii)=gg(ii);
        else
            g(i,ii)=g0(ii);
        end
        g0(ii)=g(i,ii);
    end
end
g=reshape(g,m*n,1);g=g(length(g)-sampleSize+1:length(g));