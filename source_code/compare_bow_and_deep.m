% Part II: Problem E Script
% compare_bow_and_deep.m

% The following script compares SIFT bag-of-words 
% with Deep Features (via AlexNet)

% Retrieve two specific frames
addpath('./provided_code/');
siftdir = './sift/';
framesdir = './frames/';

% Frame 1
fname1 = ([siftdir '/friends_0000004503.jpeg.mat']); 
query1 = 'friends_0000004503.jpeg.mat';
load(fname1, 'imname');
pathName1 = [framesdir '/' imname];   

% Frame 2
fname2 = ([siftdir '/friends_0000000394.jpeg.mat']);
query2 = 'friends_0000000394.jpeg.mat';
load(fname2, 'imname');
pathName2 = [framesdir '/' imname];     

siftNames = [fname1; fname2]; % Sift file names
fPathNames = [pathName1; pathName2]; % Frame paths

% Load Sift File Names
fnames = dir([siftdir '/*.mat']);

% Finding the index of query frames
for i = 1:length(fnames)
    if strcmp(fnames(i).name,query1)
        queryIndex1 = i;
    elseif strcmp(fnames(i).name,query2)
        queryIndex2 = i;
    end
end

queryInd = [queryIndex1; queryIndex2];


% Load all Frame names
numFrames = length(fnames); % to use for when we exclude
fileIndices = 1:numFrames;


% Load kMeans
load('kMeans.mat', 'means');

for query=1:2
    currQuery = [siftNames(query,:)]; % Current query
    load(currQuery, 'descriptors', 'deepFC7');
    queryDeep = deepFC7;
    imname = fPathNames(query,:);
    
    selWordCounts = computeHistogram(currQuery,means);

    queryIm = imread(imname);

    % Avoid comparing selected frame to itself:
    excludeFrame = fileIndices(fileIndices ~= queryInd(query,1));

    frameTable = []; % stores frame paths
    BoWScoreTable = []; % stores similarity between histograms
    deepScoreTable = []; % stores similarity between deepFC vectors
    
    for otherFileNames=1:(numFrames-1) % compute histograms for other files

        otherFileName = [siftdir '/' fnames(excludeFrame(1,otherFileNames)).name];
        load(otherFileName, 'deepFC7');
        otherDeep = deepFC7;
        otherWordCounts = computeHistogram(otherFileName, means);

        BoWScore = computeSimilarity(selWordCounts, otherWordCounts);
        deepScore = computeSimilarity(queryDeep, otherDeep);


        load(otherFileName, 'imname');
        imname = [framesdir '/' imname]; % get associated image with file

        frameTable = [frameTable; imname];
        BoWScoreTable = [BoWScoreTable; BoWScore];
        deepScoreTable = [deepScoreTable; deepScore];

    end
    
    % Obtain indices of top 10 scores/frames
    % based on BoW and AlexNet features
    [~,BoWInds] = maxk(BoWScoreTable,10);
    [~,deepInds] = maxk(deepScoreTable,10);

    % Display 10 most similar frames along with queryIm
    displayMatches(queryIm, frameTable, BoWInds);
    displayMatches(queryIm, frameTable, deepInds);
    
end % iterate through each selected frame


% Subfunctions:
function displayMatches(queryIm, frameTable, inds)
    figure;
    subplot(4,3,1);
    imshow(queryIm);
    title('Query Image');

    for itr=1:10
        framePath = frameTable(inds(itr,1),:);
        frameIm = imread(framePath);
        subplot(4,3,itr+1);
        imshow(frameIm);
        title(strcat('Similarity Rank:', int2str(itr)));
    end
end


function score = computeSimilarity(queryData, otherData)
        % Pass in either histogram or deepFC7 vectors and
        % compute cosine similarity:
        numerator = dot(queryData, otherData);
        selNorm = sqrt(sum(queryData.^2));
        otherNorm = sqrt(sum(otherData.^2));
        denominator = otherNorm * selNorm;

        score = numerator / denominator;
        if isnan(score)
            score = 0;
        end
end

function histogram = computeHistogram(fname, means)

    % First compute membership of frame's descriptors
    load(fname, 'descriptors');
    [membership, ~] = computeMembership(descriptors', means);

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
