# Exponential-filtering-technique-for-Euclidean-norm-regularized-ELM

## Proposed Approach: Exponential Filtering for Enhanced Regularization
### Introduction
Our proposed approach aims to address the limitations of Tikhonov regularization by introducing an exponential filtering technique. By incorporating this technique into the Extreme Learning Machine (ELM) algorithm, we enhance the regularization process and improve the model's ability to generalize effectively. This README file provides an overview of our approach, its implementation in MATLAB, and instructions for running the code.

### Methodology
The key idea behind our approach is to adaptively handle noise in the input data, providing a more accurate representation of real-world scenarios. We achieve this by incorporating an exponential filtering method into the ELM algorithm. This technique allows us to overcome the assumption of white and Gaussian noise in Tikhonov regularization, which may not hold true in practical applications. By leveraging the benefits of exponential filtering, we aim to enhance the regularization process and improve the overall performance of the ELM model.

### Code Organization
The MATLAB code for our proposed approach is organized as follows:

1. main.m: This is the main script that demonstrates the usage of our approach. It includes the necessary steps to prepare the data, apply the exponential filtering technique, and train the ELM model.

2. ELM_fraction.m: This script contains the implementation of the exponential filtering method with ELM algorithm, including the training and testing phases. It takes the input data and applies the filtering technique to remove noise and enhance the data representation. Finally, trains the ELM_fraction model to obtain the desired predictions.

3. ELM.m: This script implements the ELM algorithm, including the training and testing phases. It takes the preprocessed data and trains the ELM model to obtain the desired predictions.

4. Other necessory files are also included. 

### Citation
If you find our proposed approach or the provided code useful in your research work, please consider citing our paper:

Naik, S.M., Subramani, C., Jagannath, R.K. et al. Exponential filtering technique for Euclidean norm-regularized extreme learning machines. Pattern Anal Applic (2023). https://doi.org/10.1007/s10044-023-01174-8
