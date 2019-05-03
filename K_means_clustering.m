clc;
% clear;
close all;

fileName = 'D:\\code\\python\\dongdong\\crime\\crime.csv';


% [~, ~, data] = xlsread(fileName);
% 
subData = cell2mat(data(2:end, [13:16, 18, 19]));

hours = zeros(size(subData, 1), 1);

%% filter
columns = [1 2];

% this one is to get the data of district 5
% index = find(subData(:, 3) == 5);
% str = 'Clustering of crimes for District 5';

% this one is to get the data of district 521
% index = find(subData(:, 4) == 521);
% str = 'Clustering of crimes for Precinct 521';

% this one is to get all of the data
index = 1 : size(subData, 1);
str = 'Clustering of crimes for Denver';

panelData = subData(index, columns);
panelData = panelData(panelData(:, 1)<-100 & panelData(:, 2)>39, :);
% panelData = subData(:, columns);

bsNewFigure;
nCluster = 15;  
[idx, C, SUMD, D] = kmeans(panelData, nCluster);
load colorTbl.mat;
load original_color.mat;    

colors = {'#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', '#008080', '#e6beff', '#9a6324', '#ff0000', '#800000', '#aaffc3', '#808000', '#ffd8b1', '#000075', '#808080', '#ffffff', '#000000'};
nColor = size(original_color, 1);
% cc = {'ro', 'go', 'b*', 'co', 'm*', 'y*', 'r+', 'g+', 'b+', 'c+', 'm+', 'y+', 'b<', 'g>', 'r<', 'c>', 'ms'};
shapes = {'o', '*', '+', 's', '<', '>', '^', 'V', 'p', 'h', 'o', '*', '+', 's', '<', '>', '^', 'V', '.', 'p', 'h'};

bsNewFigure;
set(gcf, 'position', [200         200        1072         541]);

for i = 1 : nCluster
    index = find(idx == i);
%     plot(panelData(index, 1), panelData(index, 2), cc{i}); hold on;
    plot(panelData(index, 1), panelData(index, 2), shapes{i}, 'color', colors{i}, 'linewidth', 1.5); hold on;    
    plot(C(i,1), C(i, 2), 'k*', 'linewidth', 4);
end

xlabel('Longtitude');
ylabel('Latitude');


title(str);

name = sprintf('center_%s.txt', str);

fileID = fopen(name,'w');
fprintf(fileID, '%.4f %.4f\r\n', C');
fclose(fileID);

stpSaveFigure('./', str);





