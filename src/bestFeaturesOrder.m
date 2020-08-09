
%-----Erwthma 2.5----
%Epilogh xarakthristikwn x kai y
q = 0;
XYRate=[];
for x = 1:9
    q = q+1;
    for y = q:9
     if(x~=y)
        rate = zeros(4,1);
        for i = 1:4
            %Epilogh xarakthristikwn
            Data = [savedData(i).features(:,x) savedData(i).features(:,y)];
            group = savedData(i).classEst;
            rate(i) = MyClassify(Data, group);
        end
        RateData(x,y).rate = rate;
        XYRate = [ XYRate ; x y RateData(x,y).rate(4)]; 
     end
    end
end

[~,Index]=sort(XYRate(:,3),'descend');
OrderedRate = XYRate(Index,:);
