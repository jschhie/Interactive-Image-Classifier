addpath('./provided_code/');
siftdir = './sift/';
framesdir = './frames/';
    
fnames = dir([siftdir '/*.mat']);
    
numFrames = length(fnames);
frameInd = randperm(numFrames,3); % 3 random & unique frame indices
    
fileIndices = 1:numFrames;
     
load('kMeans.mat', 'means');
    
for selectedFrame=1:3
	selFileName = [siftdir '/' fnames(frameInd(1,selectedFrame)).name]; % First file name
    selWordCounts = computeHistogram(selFileName,means);
        
    load(selFileName, 'imname');
    imname = [framesdir '/' imname];
        
	queryIm = imread(imname);
        
    % Avoid comparing selected frame to itself:
    excludeFrame = fileIndices(fileIndices ~= frameInd(1,selectedFrame));
        
    frameTable = []; % Stores frame paths
    scoreTable = []; % Stores corresponding similarity scores
        
    for otherFileNames=1:(numFrames-1) % Compute histograms for other file
        # Set up 
    	otherFileName = [siftdir '/' fnames(excludeFrame(1,otherFileNames)).name];
        otherWordCounts = computeHistogram(otherFileName, means);
            
        % Compute cosine similarity:
        numerator = dot(selWordCounts, otherWordCounts);
        otherNorm = sqrt(sum(otherWordCounts.^2));
        selNorm = sqrt(sum(selWordCounts.^2));
        denominator = otherNorm * selNorm;
            
        score = numerator / denominator;
        if isnan(score)
            score = 0;
        end
               
        load(otherFileName, 'imname');
        imname = [framesdir '/' imname]; % Get associated image with file
            
        frameTable = [frameTable; imname];
        scoreTable = [scoreTable; score];

	end
        
    % Obtain indices of top 5 scores/frames
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
