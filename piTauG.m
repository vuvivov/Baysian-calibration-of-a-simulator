%calculate the likelihood
%prior is a ProbDistUnivParam object
%input: vector tau,h;vector' g
function p=piTauG(g,tau,h,errorSd,prior)
p=exp(-.5*sum((t(h,g)-(tau*ones(1,length(g)))).^2)/errorSd^2)/errorSd.*pdf(prior,g);

