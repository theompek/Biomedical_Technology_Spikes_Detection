
%% -------- Erwthma 1.1 --------
close all
figureNum = 0;

mkdir('plots/1.1');
for i = 1:8
	name = ['Data/Data_Test_' num2str(i)];
	load(name)
    figure(figureNum+1)
    figureNum = figureNum+1;
    plot(data(1:10000))
    name_title = sprintf('DataTest%d',i);
    title(name_title,'FontSize',15)
    loc = sprintf('plots/1.1/%s',name_title);
    saveas(figureNum,loc,'png')   
end

%% -------- Erwthma 1.2 --------
mkdir('plots/1.2');
findBestK;
%Grafikh K vs Sigma
figure(figureNum+1)
figureNum = figureNum+1;
plot(sigma,bestKapa)
ylabel('K')
xlabel('sigma')
title('Συντελεστής Κ συναρτήσει της διακύμανσης του θορύβου','FontSize',15)
name_title = sprintf('K_Vs_Sigma');
loc = sprintf('plots/1.2/%s',name_title);
saveas(figureNum,loc,'png')   
%
%% -------- Erwthma 1.3 --------
mkdir('plots/1.3');
figure(figureNum+1)
figureNum = figureNum+1;
plot(sigma,bestKapa)
hold on 
%Kanonas
sig = 0.05:0.01:0.45;
x = sig;
plot(sig,(2.973 + 26.08*x + -332.6*x.^2 + 1556*x.^3 + -3289*x.^4 + 2624*x.^5))
ylabel('Κ')
xlabel('sigma')
title('Ο κανόνας είναι πολυώνυμο 5ου βαθμού')
name_title = sprintf('Kanonas');
loc = sprintf('plots/1.3/%s',name_title);
saveas(figureNum,loc,'png')   

%Epalh8evoume oti o kanonas doulevei swsta
%Xrhsimopoioume ton kanona sta DataTest dedomana gia epalh8eush
TestDataCountSpikes;

f = figure(figureNum+1);
figureNum = figureNum+1;
Data = [Nspikes,givenNumSpikes,minE];
colNames = {'Εντοπισμένες','Δοσμένες','Διαφορά'};
rowNames = {'DataTest1','DataTest2','DataTest3','DataTest4','DataTest5','DataTest6','DataTest7','DataTest8'};
uit = uitable(f,'RowName',rowNames,'ColumnName',colNames,'Data',Data,'Position',[10 220 330 180]);
name_title = sprintf('NumOfSpikesByTheRule');
loc = sprintf('plots/1.3/%s',name_title);
saveas(figureNum,loc,'png')   
%

%% -------- Erwthma 2.1 --------
mkdir('plots/2.1');
%Xrhsimopoioume ton kanona sta DataEval dedomena
%EvalDataCountSpikes;

f = figure(figureNum+1);
figureNum = figureNum+1;
Data = [Nspikes,givenNumSpikes,ArxikhDiafora];
colNames = {'Εντοπισμένες','Δοσμένες','Διαφορά'};
rowNames = {'DataEval1','DataEval2','DataEval3','DataEval4'};
uit = uitable(f,'RowName',rowNames,'ColumnName',colNames,'Data',Data,'Position',[10 220 330 100]);
name_title = sprintf('NumOfSpikesByTheRule');
loc = sprintf('plots/2.1/%s',name_title);
saveas(figureNum,loc,'png')   

%% -------- Erwthma 2.2 --------
mkdir('plots/2.2');
%Plot twn spikes pou vrikame apo ton kanona
for i = 1:4
    figure(figureNum+1);
    figureNum = figureNum+1;
    for g = 1:length(savedData(i).spikeEst)
        plot( savedData(i).spikeEst(:,g))
        hold on 
        plot(2*lengthSpike+1,savedData(i).spikeEst(2*lengthSpike+1,g),'r*')
    end
     title('Spikes ordered by the first Peak');
    name_title = sprintf('SpikesByFirstPeakEval%d',i);
    loc = sprintf('plots/2.2/%s',name_title);
    saveas(figureNum,loc,'png')   
end

%% -------- Erwthma 2.3 --------
mkdir('plots/2.3');
%Ypologismos 8oruvou sta Spikes kai antistoixhsh twn spikes se classes
noiseSpikes;

%Pososto epituxias telika
successEnd = 100 - (abs(TelikhDiafora)./numOfGivenSpikes).*100;
%Pososto 8oruvou sta deigmata
Noise = ((numOfNoiseSpikes)./(numOfrealSpikes+numOfNoiseSpikes)).*100;

f = figure(figureNum+1);
figureNum = figureNum+1;
Data = [numOfNoiseSpikes + numOfrealSpikes,numOfrealSpikes,numOfNoiseSpikes,Noise,successEnd];
colNames = {'Αρχικός Αριθμός Spikes','Μετά την αποθορυβοποίηση','Αριθμός Θορύβου','Ποσοστό θορύβου','Τελικό Ποσοστό Επιτυχίας'};
rowNames = {'DataEval1','DataEval2','DataEval3','DataEval4'};
uit = uitable(f,'RowName',rowNames,'ColumnName',colNames,'Data',Data,'Position',[10 20 755 100]);
name_title = sprintf('NumOfSpikesByTheRule');
loc = sprintf('plots/2.3/%s',name_title);
saveas(figureNum,loc,'png')  

i = 1;
name = ['Data/Data_Eval_E_' num2str(i)];
load(name)
for class = 1:3
    figure(figureNum+1)
    figureNum = figureNum+1;
    T = savedData(i).spikeFirstPeakTimes(savedData(i).classEst == class) ;
    T2 = savedData(i).spikeTimesEst(savedData(i).classEst == class) ;
    for j = 1:length(T)
        m = T(j) ;
        d = 30;
        plot(data(m-d:m+d+40))
        hold on
        plot(d+1,data(m),'r*')    
    end
    name_title = sprintf(['Spike class ' num2str(class)]);
    title(name_title)    
    loc = sprintf('plots/2.3/%s',name_title);
    saveas(figureNum,loc,'png')   
end 


%% -------- Erwthma 2.4 --------
mkdir('plots/2.4')
calfeatures;
plotFeatures;


%% -------- Erwthma 2.5 --------
mkdir('plots/2.5')
bestFeaturesOrder;
mkdir('plots/2.5/BestF')
plotBestComb;
features = [5 6;4 7;7 8];
figureNum = rateComb(savedData,figureNum,features);

features = [7 8 6; 7 8 4; 7 8 5];
figureNum = rateComb(savedData,figureNum,features);

for i = 1:9
features = 1:i;
figureNum = rateComb(savedData,figureNum,features);
end

