# Second-order-finite-time-and-fixed-time-SPS

README for Second-order-finite-time-and-fixed-time-SPS

This repository contains the implementation of the proposed Second-order-finite-time-and-fixed-time-SPS algorithm. The proposed algorithm is designed for sparse signal recovery, and the initial value of the proposed system should fulfill Ax=b, where A is the measurement matrix, x is the original signal, and b is the measurement vector.

The algorithm takes two parameters: the sparsity (kk) and the projection matrix (P) onto the rowspace. The hard thresholding function (gz1) is used to keep only the k maximum magnitudes.

This repository also includes an automatic way for generating the estimate of sparsity in the recovery of the image. The Second-order-finite-time-SPS (qq2) and Second-order-fixed-time-SPS (q5) algorithms are also provided.

To use the algorithm, simply run the provided MATLAB scripts. Make sure to input the correct values for the parameters kk and P, and ensure that the initial value of the system fulfills Ax=b.

If you have any questions or suggestions for improvements, please feel free to create an issue in the repository.
