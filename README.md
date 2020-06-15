# README in progress

# Image Classifier
> Created in Spring 2019 using MATLAB.


# Project Overview
This project serves as an image classifier. It allows users to select a region within an image of choice and retrieves the most similar video frames. Similarity scores are computed using bag-of-words modeling and k-means clustering. Results are based off of a pre-selected dataset of over 6,600 images. 


# Table of Contents
* [Remark & Sample Results](https://github.com/jschhie/image-detector-prog/#sample-results)
* [Acknowledgments](https://github.com/jschhie/image-detector-prog/#acknowledgments)


# Remark & Sample Results
This program makes use of pre-computed SIFT and deep features, as well as their associated images. Altogether, the program's initialization requires about 6 GB of data.

For convenience, sample results have been provided for both full-frame and region-based queries. Please see the ```/p3 submission/``` directory. Each subdirectory contains a pair of queried and retrieved frames.


# Acknowledgments
My former professor provided the template code, which can be found within the ```/provided_code/``` directory. Besides this, I implemented the rest of the source code with a coding partner. Lastly, this README.md was created by myself.
