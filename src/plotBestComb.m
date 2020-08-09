
NBestComb = 5;
for j=1:NBestComb
     x = OrderedRate(j,1);
     y = OrderedRate(j,2);
     close all
     handler = figure(figureNum+1);
     figureNum = figureNum+1;
        for i = 1:4
        titlesLabel= { 'Πλάτος πρώτου ακρότατου' ... 
                       'Λόγος μεταξύ πρώτου και δεύτερου μήκους' ...
                       'Συνολικό μήκος του Spike' ...
                       'Συνολικό εμαβαδό του Spike' ...
                       'Εμβαδόν του δεύτερου μισού του Spike' ...
                       'Τιμή του Spike στην μέση του μήκους του' ...
                       'Τιμή του Spike στο δεύτερο μισό του μήκους του' ...
                       'Θέση του δεύτερου ακρότατου' ...
                       'Θέση της μέγιστης τιμή του Spike'};


        subplot(2,2,i)
        color = savedData(i).classEst;
        gscatter(savedData(i).features(:,x), savedData(i).features(:,y),color,'kgrb','o*',6,'on');
        legend({'Noise', 'Class1','Class2', 'Class3'},'FontSize',9);
        xlabel(titlesLabel(x),'FontSize',10);
        ylabel(titlesLabel(y),'FontSize',10);
        title(['Ζεύγος Χαρακτηριστικών '  'Eval'  num2str(i)]);
        end
    name_title = sprintf('BestFeatures_x=%d_y=%d',x,y);
    loc = sprintf('plots/2.5/BestF/%s',name_title);
    saveFigureFullSize(handler,loc);

end
     