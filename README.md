# Image Classifier
> Created in Spring 2019 using MATLAB.


# Project Overview
This project serves as an image classifier. It allows users to select a region within an image of choice and retrieves the most similar video frames. Similarity scores are computed using bag-of-words modeling and k-means clustering. Results are based off of a dataset of 6,600 images. 


# Table of Contents
* [Sample Results](https://github.com/jschhie/image-detector-prog/#sample-results)
  * ["Sample Outputs" Directory: Layout & Contents](https://github.com/jschhie/image-detector-prog/#directory-layout-and-contents)
* [Terminology Mentioned](https://github.com/jschhie/image-detector-prog/#terminology-mentioned)
* [Acknowledgments](https://github.com/jschhie/image-detector-prog/#acknowledgments)


# Sample Results
Remark: This program makes use of pre-computed SIFT and deep features, as well as their associated images. Altogether, the program's initialization requires about 6 GB of data. 

For sake of convenience and clarity, sample results have been provided for both full-frame and region-based queries. Please see the ```sample_outputs``` directory. Its layout and contents are detailed in the next [section](https://github.com/jschhie/image-detector-prog/#directory-layout-and-contents).

## Directory Layout and Contents
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
The following list *briefly* highlights the terminology mentioned in this README.

* __Bag-of-Words Modeling:__ Uses a visual vocabulary of image patches.
* __SIFT (algorithm/descriptors):__ An abbreviation for Scale-Invariant Feature Transform. A Computer Vision algorithm used to describe local features within images.
* __K-Means Clustering:__ An algorithm used to cluster, or group similar features together; used to create visual words.
* __AlexNet:__ A well-known application designed by Alex Krizhevsky; served to detect objects.

# Acknowledgments
My former professor provided the template code (which can be found within the ```provided_code``` directory) and said dataset. Besides these, I implemented the rest of the source code with a coding partner. Lastly, this README was written by myself.
