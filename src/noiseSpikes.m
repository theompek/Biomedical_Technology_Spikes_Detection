close all
numOfNoiseSpikes = zeros(4,1);
numOfrealSpikes = zeros(4,1);
numOfGivenSpikes = zeros(4,1);
%% Ypologismos twn realSpikes kai noiseSpikes
%-----Erwthma 2.3-----
for i = 1:4
    name = ['Data/Data_Eval_E_' num2str(i)];
	load(name)
    numOfGivenSpikes(i) = length(spikeTimes);    
    maxRange = 30;
    sm = 14;    
    noisePointsIndex = [];
    savedData(i).classEst = zeros(size(savedData(i).spikeTimesEst,2),1);
    for r = 1:size(savedData(i).spikeFirstPeakTimes,2)
        minDictance = savedData(i).spikeFirstPeakTimes(r) - spikeTimes;
        minDictance(minDictance < 0) = maxRange + 1000; %aporiptoume arnhtikes times
        [minDictance ,index] = min(minDictance);
        if minDictance > maxRange || minDictance < sm
            noisePointsIndex = [noisePointsIndex r];
        else
            savedData(i).classEst(r) = spikeClass(index);
        end
    end
    noisePointTimes = savedData(i).spikeFirstPeakTimes(noisePointsIndex);
    RealSpikesTimes = savedData(i).spikeFirstPeakTimes;
    RealSpikesTimes(noisePointsIndex) = [];
    numOfNoiseSpikes(i) = length(noisePointTimes);
    numOfrealSpikes(i) = length(RealSpikesTimes);
   
end
