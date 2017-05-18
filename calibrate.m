%generate output information 
%data is input data
%priorName and varargin are used the same way as in the function pdf
function calibrate(data,sampleSize,priorName,varargin)
prior=makedist(priorName,varargin{:});
pdfCover=.999;resolution=5120;
fileName=[prior.DistributionName,' ',num2str(prior.ParameterValues)];
pdfMax=icdf(prior,pdfCover);pdfMin=icdf(prior,1-pdfCover);pdfRange=pdfMax-pdfMin;pdfBin=(pdfRange)/resolution;x=(pdfMin-pdfRange*.1):pdfBin:(pdfMax+pdfRange*.1);
%prior
priorMode=fminsearch(@(x)(-pdf(prior,x)),(pdfMax+pdfMin)/2);
priorMean=mean(prior);
priorSd=std(prior);
priorMedian=median(prior);
fg=figure;
plot(x,pdf(prior,x),'g');xlabel('g');ylabel('\pi (g), \pi (g|\tau)');hold;
%posterior by likelihood funciton and numerical integration
max=fminsearch(@(X)(-piTauG(X(1),data(:,2),data(:,1),X(2),prior)),[5,1]);
errorSd=max(2);
yl=piTauG(x,data(:,2),data(:,1),errorSd,prior);
intgPiTauG=integral(@(X)piTauG(X,data(:,2),data(:,1),errorSd,prior),pdfMin,pdfMax);yl=yl/intgPiTauG;
posteriorLikeliFunMode=max(1)
posteriorLikeliFunMean=integral(@(X)X.*piTauG(X,data(:,2),data(:,1),errorSd,prior),pdfMin,pdfMax)/intgPiTauG
posteriorLikeliFunSd=sqrt(integral(@(X)(X-posteriorLikeliFunMean).^2.*piTauG(X,data(:,2),data(:,1),errorSd,prior)./intgPiTauG,pdfMin,pdfMax))
posteriorLikeliFunMedian=quantileEpdf(x,yl,.5);
%posterior by metropolis algorithm
g=metropolis(data,sampleSize,errorSd,prior);
[yg,x]=ksdensity(g,x);plot(x,yg,'r');
posteriorMCMCMode=myMode(x,yg)
posteriorMCMCMean=mean(g) 
posteriorMCMCSd=std(g)
posteriorMCMCMedian=median(g);
legend('prior','posterior','Location','NorthWest');
hold off;title({'Density for g' ,fileName});
saveas(fg,['pdf' fileName '.pdf']);
%quantiles vs data
xx=0.001:.001:4.5;p=.05:.1:.95;
fg=figure;hold;
priorQ=icdf(prior,p);postQ=quantileEpdf(x,yl,p);
p1=scatter(data(:,1),data(:,2),'b');p2=plot(xx,t(xx',priorQ),'g');p3=plot(xx,t(xx',postQ),'r');legend([p1,p2(1),p3(1)],'field data','prior','posterior','Location','NorthWest');
hold off;title({'Data and Simulator Uncertainty',fileName});xlabel('h');ylabel('t, \tau');
saveas(fg,[fileName '.pdf']);
fg=figure;hold;
p1=scatter(data(:,1),data(:,2),'b');p2=plot(xx,t(xx',priorMode),'g');p3=plot(xx,t(xx',posteriorLikeliFunMode),'r');legend([p1,p2(1),p3(1)],'field data','prior','posterior','Location','NorthWest');
hold off;title({'Data and Simulator Output with Mode of g',fileName});xlabel('h');ylabel('t, \tau');
saveas(fg,[fileName '2.pdf']);