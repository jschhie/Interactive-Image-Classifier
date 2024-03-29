# Image Similarity Search for <i>Friends</i> (TV Show)

> Written in MATLAB.


# Project Overview
This project serves as an interactive image classifier. Users can select either (1) a region/object within an image of choice, or (2) an entire image. The program then retrieves the top *n* = 5 most similar images to the given queries. 

Similarity scores are computed using bag-of-words modeling and k-means clustering. 

Results are based off of a dataset of 6,600+ distinct video frames from the American T.V. series <i>Friends</i>. <b> Note: The dataset has not been provided in this repository. </b> Please see [visual demo](https://github.com/jschhie/image-detector-prog/#sample-results) instead.

A brief description of the terminology used can be found [here](https://github.com/jschhie/image-detector-prog/#terminology-mentioned).


# Table of Contents
* [Sample Results](https://github.com/jschhie/image-detector-prog/#sample-results)
  * Full-Frame Query
  * Region-Based Query
* [Directory Layout & Contents](https://github.com/jschhie/image-detector-prog/#directory-layout-and-contents)
* [Terminology Mentioned](https://github.com/jschhie/image-detector-prog/#terminology-mentioned)


# Sample Results
This program makes use of Scale-Invariant Feature Transform (SIFT) descriptors, as well as their associated images. 

Sample results have been provided below for both full-frame and region-based queries. 

## Example I: Full-Frame Query
> Retrieves top *n* = 5 most similar video frames to selected image.

![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/full_frames/full%20frame%20matches%201.jpg?raw=true "Full-Frame Query and Results")

## Example II: Region-Based Query
> Retrieves top *n* = 5 most similar video frames containing queried region/object (in this example, a kitchen table, which is outlined in blue).

| Query | Retrieved Images | 
| :---: | :-----: |
| ![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/region_based/sample_kitchen_table/find%20kitchen%20table.jpg?raw=true "Query: Detect Kitchen Table") | ![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/region_based/sample_kitchen_table/kitchen%20table%20matches.jpg?raw=true "Results: Kitchen Table") | 

Please see the ```sample_outputs``` directory for additional examples. Its layout and contents are detailed in the next section.

# Directory Layout and Contents
This section pertains to the ```sample_outputs``` directory. Its subdirectories and their contents are summarized below.

| Subdirectory Name | Description of Contents |
| :---: | ----- |
| ```full_frames``` | Sample results based on full-frame queries. |
| ```full_frames_comparison``` | Visual comparison between AlexNet Image Classification and SIFT-based descriptors. This project is based on the latter. Serves to illustrate program's accuracy/effectiveness. |
| ```raw_matches``` | Sample queried region versus computed SIFT descriptors. |  
| ```region_based``` | Sample results based on region-based queries. |
| ```visual_vocab``` | Sample visual vocabulary (aka bag-of-words, where each image patch represents a "word"). |


# Terminology
| Terminology | Description |
| :---: | ----- |
| *Bag-of-Words (BoW) Modeling* | A histogram of visual image patches/literal words within a given image/text; describes the frequency of unique (visual) words |
| *SIFT (algorithm/descriptors)* |   An abbreviation for Scale-Invariant Feature Transform; describes local, unique features within images |
| *AlexNet* | A well-known Computer Vision application designed by Alex Krizhevsky that detected and classified objects |

