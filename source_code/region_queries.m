addpath('./provided_code/');
siftdir = './sift/';
framesdir = './frames/';

fnames = dir([siftdir '/*.mat']);

numFrames = length(fnames);
frameInd = randperm(numFrames,4); % 4 random & unique frame indices

fileIndices = 1:numFrames;


load('kMeans.mat', 'means');

for frameItr=1:4
    % Get associated image with file
    selFileName = [siftdir '/' fnames(frameInd(1,frameItr)).name];
    load(selFileName, 'imname', 'positions');
    framePath = [framesdir '/' imname];
    queryIm = imread(framePath);

    % Get indices within selected region
    figure;
    inds = selectRegion(queryIm, positions);

     % Avoid comparing selected frame to itself:
    excludeFrame = fileIndices(fileIndices ~= frameInd(1,frameItr));

    frameTable = []; % stores frame paths
    scoreTable = []; % stores corresponding similarity scores

    regWordCounts = computeHistogram(selFileName, means, inds,1);

    for otherFileNames=1:(numFrames-1) % compute histograms for other files

        otherFileName = [siftdir '/' fnames(excludeFrame(1,otherFileNames)).name];

        otherWordCounts = computeHistogram(otherFileName, means, [], 0);

        % compute cosine similarity:
        numerator = dot(regWordCounts, otherWordCounts);
        otherNorm = sqrt(sum(otherWordCounts.^2));
        selNorm = sqrt(sum(regWordCounts.^2));
        denominator = otherNorm * selNorm;

        score = numerator / denominator;
        if isnan(score)
            score = 0;
        end


        load(otherFileName, 'imname');
        imname = [framesdir '/' imname]; % get associated image with file

        frameTable = [frameTable; imname];
        scoreTable = [scoreTable; score];

    end % end of computing histograms for other frames


    % Obtain indices of top 5 scores/frames
    [~,maxInds] = maxk(scoreTable,5);

    % Display 5 most similar frames

    figure;
    for itr=1:5
        framePath = frameTable(maxInds(itr,1),:);
        frameIm = imread(framePath);
        subplot(2,3,itr);
        imshow(frameIm);
        title(strcat('Similarity Rank:', int2str(itr)));
    end


end 






function histogram = computeHistogram(fname, means, inds, flag)

    % First compute membership of frame's descriptors
    load(fname, 'descriptors');

    data = []; % descriptors to be passed to computeMembership

    if (flag == 1) % if computing histogram for descriptors in a region

        for itr=1:length(inds)
            data = [data; descriptors(inds(itr),:)];
        end         
    else % flag == 0
        data = descriptors;         
    end

    [membership, ~] = computeMembership(data', means);

    % Second, compute the histogram vectors for the frame
    maxWord = size(means,2);
    histogram = histc(membership, 1:maxWord);
end
    
    
% Copied from 'kmeansMl.m' in provided_code by:
% David R. Martin <dmartin@eecs.berkeley.edu>
function [membership,rms] = computeMembership(data,means)
    %fprintf('computing membership for %d x %d data, %d x %d means...\n', size(data,1),size(data,2),size(means,1),size(means,2));
    z = distSqr(data,means);
    [d2,membership] = min(z,[],2);
    rms = sqrt(mean(d2));
end
