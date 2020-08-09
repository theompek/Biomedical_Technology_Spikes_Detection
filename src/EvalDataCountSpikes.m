close all
ArxikhDiafora = zeros(4,1);
Nspikes = zeros(4,1);
givenNumSpikes = zeros(4,1);
for i = 1:4
%-----Erwthma 2.1-----
    name = ['Data/Data_Eval_E_' num2str(i)];
	load(name)
    sequenceOfNum = 1:1:length(data);
	std_n = median(abs(data))/0.6745;   
    x = std_n;
    %Kanonas tou K
    bestK = 2.973 + 26.08*x + -332.6*x.^2 + 1556*x.^3 + -3289*x.^4 + 2624*x.^5;
    T = bestK*std_n;
    %Ari8mos twn Spikes
    Nspikes(i) = nnz(diff(data>T) == 1);   
    %Diafora apo ton pragmatiko ari8mo twn spikes
    givenNumSpikes(i) = length(spikeTimes);
	ArxikhDiafora(i) = Nspikes(i)-givenNumSpikes(i);
    %8a vroume tis xronikes 8eseis/stigmes twn spikes,stis opoies mia exmh pernaei
    %to katwfli 'T'
    spikeTimesEst = sequenceOfNum( diff(data>T) == 1) + 1;
    %Apo8hkeuoume tis xronikes stigmes se mia domh 
    savedData(i).spikeTimesEst = spikeTimesEst;
 
%-----Erwthma 2.2-----
    %Briskoume thn xronikh stigmh tou prwtou akrotatou
        lengthSpike = 12;
        spikeFirstPeakTimes = spikeTimesEst;
        mesosOros = mean(data);
            for r = 1:length(spikeFirstPeakTimes);
              if spikeFirstPeakTimes(r)-lengthSpike > 0 && spikeFirstPeakTimes(r)+lengthSpike <= length(data);
                  [~ , Imax] = max(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+lengthSpike)));
                  [~ , Imin] = min(data((spikeFirstPeakTimes(r)-lengthSpike):(spikeFirstPeakTimes(r)+2*lengthSpike)));
                  
                  %Pernoume to prwto xrinika apo ta duo akrotata
                  I = min(Imax,Imin) - lengthSpike - 1;
                  spikeFirstPeakTimes(r) = spikeFirstPeakTimes(r) + I;  
              end
            end
       
    %Apo8hkeuoume tis xronikes stigmes se mia domh gia to plot argotera 
    savedData(i).spikeFirstPeakTimes = spikeFirstPeakTimes;
    %Apo8hkeuoume ta stigmiotupa twn kumatomofwn evrous '3*lengthSpike+1'
    savedData(i).spikeEst = zeros(4*lengthSpike+1,length(spikeFirstPeakTimes));
    for j = 1:length(spikeFirstPeakTimes)
    savedData(i).spikeEst(:,j) = data((spikeFirstPeakTimes(j)-2*lengthSpike):(spikeFirstPeakTimes(j)+2*lengthSpike));
    end
 %-----------------------------------------

end

