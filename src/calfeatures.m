%% Xarakthristika
%------Erwthma 2.4 ------
close all
for i = 1:4
    %Feature1 = Platos prwtou akrotatou
    firstPeakPosition = 2*lengthSpike+1;
    feature1 = savedData(i).spikeEst(firstPeakPosition,:)';
    %Feature2 = Logos meta3u prwtou kai deuterou mhkous
    feature2 = zeros(size(savedData(i).spikeEst,2),1);
    %Feature3 = Sunoliko mhkos tou Spike
    feature3 = zeros(size(savedData(i).spikeEst,2),1);
    %Feature4 = Sunoliko embado tou Spike
    feature4 = zeros(size(savedData(i).spikeEst,2),1);
    %Feature5 = Embado tou deuterou misou tou Spike
    feature5 = zeros(size(savedData(i).spikeEst,2),1);
    %Feature6 = Timh tou Spike sthn mesh tou mhkous tou
    feature6 = zeros(size(savedData(i).spikeEst,2),1);
    %Feature7 = Timh tou Spike sthn mesh tou deyterou misou mhkous tou
    feature7 = zeros(size(savedData(i).spikeEst,2),1);
    %Feature8 = 8esh tou deuterou akrotatou
    feature8 = zeros(size(savedData(i).spikeEst,2),1);
    %Feature9 = 8esh ths megisths timhs tou spike
    feature9 = feature1;
    firstZeroVect = zeros(size(savedData(i).spikeEst,2),1);
    secondZeroVect = zeros(size(savedData(i).spikeEst,2),1);
    thirdZeroVect = zeros(size(savedData(i).spikeEst,2),1);
    
    for r = 1:size(savedData(i).spikeEst,2)
    %Prwto mgdeniko ekei pou allazei h paragwgos,logo 8oruvou mporei na
    %mhn pernaei apo to mhden h kumatomorfh,ara xrhsimopoioume auth thn
    %proseggish,to idio kai ta to trito mhdeniko,to deutero mhdeniko
    %pernaei sigoura apo to mhden,ara deutero mhdeniko ekei poy
    %allazei proshmo h kumatomorfh meta to shmeio prwtou akrwtatou.
        deriv = diff(savedData(i).spikeEst(:,r)); %Paragwgos kumatomorfhs
        firstZero = firstPeakPosition-1;
        signOfPeakDer = sign(deriv(firstPeakPosition-1));
        while( sign(deriv(firstZero)) == signOfPeakDer  && firstZero > 1 )
            firstZero = firstZero - 1 ;
        end
        secondZero = firstPeakPosition;
        signOfPeak = sign(savedData(i).spikeEst(firstPeakPosition,r));
        while( sign(savedData(i).spikeEst(secondZero,r)) == signOfPeak  && secondZero < 4*lengthSpike-1 )
            secondZero = secondZero + 1 ;
        end
        %To trito mhdeniko einai ekei pou exoume allagei tou proshmmou ths
        %paragwgou duo fores se sxesh me thn arxikh timh tou proshmou enos 
        %shmeiou meta apo to shmeio tou prwtou akrotatou
        thirdZero = secondZero + 1;
        while( sign(deriv(thirdZero)) == -signOfPeakDer  && thirdZero < 4*lengthSpike-1)
        thirdZero = thirdZero + 1 ;
        end
        %Deytero Akrotato
        feature8(r) = thirdZero;
        %8esh ths Max timhs tou spike
        if(savedData(i).classEst(r) == 3), feature9(r) = firstPeakPosition; else feature9(r) = thirdZero; end
        %Trito Mhdeniko
        while( sign(deriv(thirdZero)) == signOfPeakDer  && thirdZero < 4*lengthSpike)
        thirdZero = thirdZero + 1 ;
        end
        
        %Apo8hkeuoume ta xarakthristika
        feature2(r) = (secondZero - firstZero)/(thirdZero - secondZero);
        feature3(r) = (thirdZero - firstZero);
        feature4(r) = trapz(firstZero:thirdZero,savedData(i).spikeEst(firstZero:thirdZero,r));
        feature5(r) = trapz(secondZero:thirdZero,savedData(i).spikeEst(secondZero:thirdZero,r));
        feature6(r) = savedData(i).spikeEst(round((firstZero+thirdZero)/2),r);
        feature7(r) = savedData(i).spikeEst(round((secondZero+thirdZero)/2),r);
        
        firstZeroVect(r) = firstZero;
        secondZeroVect(r) = secondZero;
        thirdZeroVect(r) = thirdZero;
        
    end
    
    savedData(i).features = [feature1 feature2 feature3 feature4 feature5 feature6 feature7 feature8 feature9]; 

end

  %{
Plot twn spikes feature7
figure(2)
for g = 1:130
plot( savedData(i).spikeEst(:,g))
hold on 
plot(firstZeroVect(g),savedData(i).spikeEst(firstZeroVect(g),g),'b*')
plot(secondZeroVect(g),savedData(i).spikeEst(secondZeroVect(g),g),'g*')
plot(thirdZeroVect(g),savedData(i).spikeEst(thirdZeroVect(g),g),'y*')
plot(round((thirdZeroVect(g)+secondZeroVect(g))/2),feature7(g),'m*')
plot(2*lengthSpike+1,savedData(i).features(g,1),'r*')
name = ['Spike' num2str(g)];
title(name);
%pause(0.5);
%hold off
end
legend('Kumatomorfes','firstZero','secondZero','ThirdZero','Endiamesa se 2,3 Zeros','PrwtoAkrotato')
%}


 %{
Plot twn spikes me feature8
figure(3)
for g = 1:130
plot( savedData(i).spikeEst(:,g))
hold on 
plot(2*lengthSpike+1,savedData(i).features(g,1),'r*')
plot(feature8(g),savedData(i).spikeEst(feature8(g),g),'m*')
name = ['Spike' num2str(g)];
title(name);
%pause(0.5);
%hold off
end
legend('Kumatomorfes','PrwtoAkrotato','DeuteroAkrotato')
%}

%{
Plot twn spikes me feature9
figure(4)
for g = 1:130
plot( savedData(i).spikeEst(:,g))
hold on 
plot(feature9(g),savedData(i).spikeEst(feature9(g),g),'m*')
name = ['Spike' num2str(g)];
title(name);
%pause(0.5);
%hold off
end
legend('Kumatomorfes','MaxValues')
%}