# Image Similarity Search for <i>Friends</i> (TV Show)
> MATLAB

# Project Overview
<p>This interactive image classifier allows users to select a specific region/object within an image, or an entire image. The program retrieves the top n = 5 most similar photos based on the selection.</p>

<p>Similarity scores are calculated using bag-of-words modeling and k-means clustering, using a dataset of 6,600+ distinct video frames from the American TV series <i>Friends</i>.</p>

> Note: The dataset is not included in this repository. Please see the [visual demo](https://github.com/jschhie/image-detector-prog/#sample-results) for examples.

For a brief description of the terminology used, see [here](https://github.com/jschhie/image-detector-prog/#terminology).

# Table of Contents
* [Sample Results](https://github.com/jschhie/image-detector-prog/#sample-results)
  * Full-Frame Query
  * Region-Based Query
* [Directory Layout & Contents](https://github.com/jschhie/image-detector-prog/#directory-layout-and-contents)
* [Terminology](https://github.com/jschhie/image-detector-prog/#terminology)

# Sample Results
This program uses Scale-Invariant Feature Transform (SIFT) descriptors, along with their associated images. 

Below are sample results for both full-frame and region-based queries. 

## Example I: Full-Frame Query
> Retrieves top *n* = 5 most similar video frames to the selected image.

![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/full_frames/full%20frame%20matches%201.jpg?raw=true "Full-Frame Query and Results")

## Example II: Region-Based Query
> Retrieves top *n* = 5 most similar video frames containing the queried region/object (in this example, a kitchen table, outlined in blue).

| Query | Retrieved Images | 
| :---: | :-----: |
| ![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/region_based/sample_kitchen_table/find%20kitchen%20table.jpg?raw=true "Query: Detect Kitchen Table") | ![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/region_based/sample_kitchen_table/kitchen%20table%20matches.jpg?raw=true "Results: Kitchen Table") | 

Please refer to the ```sample_outputs``` directory for additional examples. Its layout and contents are detailed in the following section.

# Directory Layout and Contents
This section outlines the structure and contents of the ```sample_outputs``` directory, including its subdirectories.

| Subdirectory Name | Description of Contents |
| :---: | ----- |
| ```full_frames``` | Sample results based on full-frame queries. |
| ```full_frames_comparison``` | Visual comparison between AlexNet Image Classification and SIFT-based descriptors, illustrating the program's accuracy and effectiveness. |
| ```raw_matches``` | Sample queried region compared to computed SIFT descriptors. |  
| ```region_based``` | Sample results based on region-based queries. |
| ```visual_vocab``` | Sample visual vocabulary (also known as bag-of-words), where each image patch represents a "word". |


# Terminology
| Terminology | Description |
| :---: | ----- |
| *Bag-of-Words (BoW) Modeling* | A histogram of visual image patches or literal words within a given image or text, describing the frequency of unique (visual) words |
| *SIFT (Scale-Invariant Feature Transform)* |  A method for detecting and describing local, unique features within images |
| *AlexNet* | A well-known Computer Vision model designed by Alex Krizhevsky for detecting and classifying objects |
