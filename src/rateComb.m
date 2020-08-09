function [ figureNum ] = rateComb(savedData,figureNum, indexes )
%-----Erwthma 2.5----
%Epilogh xarakthristikwn
rate = zeros(4,1);
for j = 1:size(indexes,1)
for i = 1:4
    %Epilogh xarakthristikwn
    Data = savedData(i).features(:,indexes(j,:));
    group = savedData(i).classEst;
    rate(i) = MyClassify(Data, group);
end
f = figure(figureNum+1);
figureNum = figureNum+1;
colNames = {'Ποσοστό Ταξινόμησης'};
rowNames = {'DataEval1','DataEval2','DataEval3','DataEval4'};
uitable(f,'RowName',rowNames,'ColumnName',colNames,'Data',rate,'Position',[10 20 255 100]);
name_title = sprintf('Rate_%d',figureNum);
loc = sprintf('plots/2.5/%s',name_title);
saveas(figureNum,loc,'png')   

end

end

