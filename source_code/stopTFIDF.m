addpath('./provided_code/');
siftdir = './sift/';
framesdir = './frames/';
fnames = dir([siftdir '/*.mat']); % Retrieve sift filenames

k = 500; % Number of clusters
numFiles = 300; % Sample frames
fnames = dir([siftdir '/*.mat']);
numFrames = length(fnames);

siftDescriptors = []; % Matrix of data points (descriptors)
numDescriptors = []; % Stores number of descriptors per frame

% Loop through the first k sift files
for i=1:numFrames
    % Load file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    siftDescriptors = [siftDescriptors descriptors'];

    n = size(descriptors, 1);
    
    numDescriptors = [numDescriptors n];
end

[membership,means,~] = kmeansML(k,siftDescriptors);
membership = membership'; % Reshape to obtain 1 x n vector

% Create Stop List
words = [1:k]; % row vector of words
maxWord = size(means,2);

[binCounts, ~] = histc(membership, 1:maxWord);

evict = 30 % removing 30 of the most frequent words
[~, stopInds] = maxk(binCounts, evict);

for stop = 1:evict
     % evicting 'stop words' from original vocab
    words(words == stopInds(1, stop)) = [];
end

% stores column vectors (weights for each frame):
TF_IDF_Weights = [];
N_D = length(words);

% col vector storing the number of frames word_i appears in:
framesPerWord = zeros(N_D, 1);

col = 1;
for i = 1:numFrames
    for word = 1:N_D
        spliceIndex = col + numDescriptors(1, i) - 1;
        result = find(membership(1, col:spliceIndex) == words(1,word));
        N_id = size(result,1);
        
        if N_id >= 1
            framesPerWord(word,1) = framesPerWord(word,1) + 1;
        end
    end
    col = col + numDescriptors(1,i);
end


% Computing the tf-idf weights:
col = 1;
for i= 1:numFiles
    weights = [];
    
    for word = 1:N_D
        spliceIndex = col + numDescriptors(1, i) - 1;
        result = find(membership(1, col:spliceIndex) == words(1,word));
        N_id = size(result,1);
        
        N_i = framesPerWord(word, 1);
        
        if N_i >= 1
            TF_IDF = (N_id / N_D) * log10(numFiles / N_i);
        else
            TF_IDF = 0;
        end
        
        weights = [weights TF_IDF];
    end
    
    col = col + numDescriptors(1,i);
    
    TF_IDF_Weights = [TF_IDF_Weights weights'];
end

fname = ([siftdir '/friends_0000000394.jpeg.mat']);
query = 'friends_0000000394.jpeg.mat';
load(fname, 'imname');
pathName = [framesdir '/' imname];
queryIm = imread(pathName);

% in compare_bow_and_deep we found the file index of the frame in queryInd
queryInd = 304; 

fileIndices = 1:numFrames;
% Avoid comparing selected frame to itself:
excludeFrame = fileIndices(fileIndices ~= queryInd);

frameTable = []; % stores frame paths
scoreTable = []; % stores similarities between frames' weight vectors

for otherFileNames=1:(numFrames-1)
    otherFileName = [siftdir '/' fnames(excludeFrame(1,otherFileNames)).name];
    score = computeSimilarity(TF_IDF_Weights(:,queryInd), TF_IDF_Weights(:,excludeFrame(1,otherFileNames)));
    scoreTable = [scoreTable; score];
    
    load(otherFileName, 'imname');
    imname = [framesdir '/' imname]; % get associated image with file        
    frameTable = [frameTable; imname];
    
end

% Obtain indices of top 5 weighted scores/frames
[~,inds] = maxk(scoreTable,5);

% Display 5 most similar frames along with queryIm
figure;
subplot(2,3,1);
imshow(queryIm);
title('Query Image');

for itr=1:5
    framePath = frameTable(inds(itr,1),:);
    frameIm = imread(framePath);
    subplot(2,3,itr+1);
    imshow(frameIm);
    title(strcat('Similarity Rank:', int2str(itr)));
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
