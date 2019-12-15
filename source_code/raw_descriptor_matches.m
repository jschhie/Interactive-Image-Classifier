addpath('./provided_code'); % shouldn't specify absolute path?
load('twoFrameData.mat');

oninds = selectRegion(im1,positions1);
[d2Rows, ~] = size(descriptors2);
temp = ones(d2Rows, 1);
threshold = 0.185;
results = [];

for pos1=1:length(oninds)
    for pos2=1:d2Rows
       distance = dist2(descriptors1(oninds(pos1),:), descriptors2(pos2,:));
       temp(pos2) = distance; 
    end
    closestK = find(temp < threshold); % returns a column vector
    results = [results; closestK]; % append to results
end

results
figure;
imshow(im2);
displaySIFTPatches(positions2(results,:), scales2(results), orients2(results), im2); 

