%% Evresh twn idanikwn K ths Sxeshs T=K*ón kai plot korufwn vs K
%------Erwthma 1.2------
close all
minE = zeros(8,1);
bestKPosition = zeros(8,1);
foundNumSpikes = zeros(8,1);
givenNumSpikes = zeros(8,1);
bestKapa =  zeros(8,1);
sigma =  zeros(8,1);
best_T =  zeros(8,1);
nValues = 200; 
min_k = 2;
max_k = 4;
for i = 1:8
	name = ['Data/Data_Test_' num2str(i)];
	load(name)
    sequenceOfTimes = 1:1:length(data);  
	std_n = median(abs(data))/0.6745;
    stepK = (max_k-min_k)/nValues;
	Nspikes = zeros(nValues,1);
    
    j = 1;
	for k = min_k:stepK:max_k
    	T = k*std_n;  
        %Ta 8etika spikes
    	Nspikes(j) = nnz( diff(data>T) == 1);
        j = j+1;
	end
    
	[minE(i),bestKPosition(i)] = min(abs(Nspikes - spikeNum));
    foundNumSpikes(i) = Nspikes(bestKPosition(i));
    givenNumSpikes(i) = spikeNum;
    minE(i) = foundNumSpikes(i) - givenNumSpikes(i);
    k = min_k:stepK:max_k;
    bestKapa(i) = k(bestKPosition(i));
    sigma(i) = std_n;
    best_T(i) = k(bestKPosition(i))*std_n;
 	
    %Sxediash k vs Spikes
    figure(figureNum+1)
    figureNum = figureNum+1;
 	plot(k,Nspikes)
    hold on 
    plot(k,ones(length(k),1)*spikeNum)
    plot(k(bestKPosition(i)),spikeNum,'r*')
 	xlabel('K')
 	ylabel('Number of Spikes')
    name_title = sprintf('KorufesVsK DataTest%d',i);
    title(name_title,'FontSize',15)
    loc = sprintf('plots/1.2/%s',name_title);
    saveas(figureNum,loc,'png')
    
end

