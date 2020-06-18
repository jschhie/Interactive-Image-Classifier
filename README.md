# Interactive Image Classifier
> Created in Spring 2019 using MATLAB.


# Project Overview
This project serves as an interactive image classifier. Users can select either (1) a region/object within an image of choice, or (2) an entire image. The program then retrieves the top *n* = 5 most similar images to the given queries. 

Similarity scores are computed using bag-of-words modeling and k-means clustering. 

Results are based off of a dataset of 6,600 video frames. 

A brief description of the terminology used within this document can be found [here](https://github.com/jschhie/image-detector-prog/#terminology-mentioned).


# Table of Contents
* [Sample Results](https://github.com/jschhie/image-detector-prog/#sample-results)
  * [Example I: Full-Frame Query](https://github.com/jschhie/image-detector-prog/#example-i-full-frame-query)
  * [Example II: Region-Based Query](https://github.com/jschhie/image-detector-prog/#example-ii-region-based-query)
* [Directory Layout & Contents](https://github.com/jschhie/image-detector-prog/#directory-layout-and-contents)
* [Terminology Mentioned](https://github.com/jschhie/image-detector-prog/#terminology-mentioned)
* [Acknowledgments](https://github.com/jschhie/image-detector-prog/#acknowledgments)


# Sample Results
This program makes use of pre-computed SIFT and deep features, as well as their associated images. Altogether, the program's initialization requires __about 6 GB__ of data. 

For sake of convenience and clarity, sample results have been provided for both full-frame and region-based queries. 

## Example I: Full-Frame Query
> Retrieves top *n* = 5 most similar video frames to selected image.

![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/full_frames/full%20frame%20matches%201.jpg?raw=true "Full-Frame Query and Results")

## Example II: Region-Based Query
> Retrieves top *n* = 5 most similar video frames containing queried region/object (in this example, a kitchen table).

| Query | Retrieved Images | 
| :---: | :-----: |
| ![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/region_based/sample_kitchen_table/find%20kitchen%20table.jpg?raw=true "Query: Detect Kitchen Table") | ![alt text](https://github.com/jschhie/image-detector-prog/blob/master/sample_outputs/region_based/sample_kitchen_table/kitchen%20table%20matches.jpg?raw=true "Results: Kitchen Table") | 

Please see the ```sample_outputs``` directory for additional examples. Its layout and contents are detailed in the next [section](https://github.com/jschhie/image-detector-prog/#directory-layout-and-contents).

# Directory Layout and Contents
This section pertains to the ```sample_outputs``` directory. Its subdirectories and their contents are summarized below.

| Subdirectory Name | Description of Contents |
| :---: | ----- |
| ```full_frames``` | Sample results based on full-frame queries. |
| ```full_frames_comparison``` | Visual comparison between AlexNet Image Classification and SIFT-based descriptors. This project is based on the latter. Serves to illustrate program's accuracy/effectiveness. |
| ```raw_matches``` | Sample queried region versus computed SIFT descriptors. |  
| ```region_based``` | Sample results based on region-based queries. |
| ```visual_vocab``` | Sample visual vocabulary (aka bag-of-words, where each image patch represents a "word"). |

> REMARK: The subdirectories within ```full_frames``` and ```region_based``` contain pairs of queried and retrieved images.


# Terminology Mentioned
The following list *briefly* explains some of the terminology used within this document.

* __Bag-of-Words Modeling:__ Uses a visual vocabulary of image patches.
* __SIFT (algorithm/descriptors):__ An abbreviation for Scale-Invariant Feature Transform. A Computer Vision algorithm used to describe local features within images.
* __K-Means Clustering:__ An algorithm used to cluster, or group similar features together; used to create visual words.
* __AlexNet:__ A well-known application designed by Alex Krizhevsky; served to detect objects.

# Acknowledgments
My former professor provided the template code (which can be found within the ```provided_code``` directory) and said dataset. Besides these, I implemented the rest of the source code with a coding partner. Lastly, this README was written by myself.
