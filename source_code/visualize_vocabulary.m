
addpath('./provided_code/');
siftdir = './sift/';
framesdir = './frames/';
fnames = dir([siftdir '/*.mat']); % Retrieve sift filenames

k = 1400; % Number of clusters
numFiles = 300; % Sample frames

siftDescriptors = []; % Matrix of data points (descriptors)
descriptImNames = []; % Stores image path names

posTable = []; % Store positions of descriptors
orientsTable = []; 
scalesTable = [];

% Loop through the first k sift files
for i=1:numFiles
    % Load file
    fname = [siftdir '/' fnames(i).name];
    load(fname, 'imname', 'descriptors', 'positions', 'scales', 'orients');
    siftDescriptors = [siftDescriptors descriptors'];

    imPath = [framesdir '/' imname];


    posTable = [posTable; positions];
    orientsTable = [orientsTable; orients];
    scalesTable = [scalesTable; scales];

    n = size(descriptors, 1);
    rep = repmat(imPath, n, 1);
    descriptImNames = [descriptImNames; rep];

end

[membership,means,~] = kmeansML(k,siftDescriptors);
membership = membership'; % Reshape to obtain 1 x n vector

% Choose 2 distinct, arbitrary "visual words"  
firstWord = 10;
secondWord = 40; 

% Display 25 patches per cluster/ visual word
index1 = find(membership == firstWord, 25);
index2 = find(membership == secondWord, 25);

for pos=1:25  

    % Display patches for firstWord
    ind1 = index1(1,pos);
    im1 = imread(descriptImNames(ind1,:));
    im1Gray = rgb2gray(im1);

    patch1 = getPatchFromSIFTParameters(posTable(ind1,:), scalesTable(ind1,:), orientsTable(ind1,:), im1Gray);
    figure(1);
    subplot(5,5,pos);
    imshow(patch1);

    % Display patches for secondWord
    ind2 = index2(1,pos);
    im2 = imread(descriptImNames(ind2,:));
    im2Gray = rgb2gray(im2);

    patch2 = getPatchFromSIFTParameters(posTable(ind2,:), scalesTable(ind2,:), orientsTable(ind2,:), im2Gray);
    figure(2);
    subplot(5,5,pos);
    imshow(patch2);
end
  
    


