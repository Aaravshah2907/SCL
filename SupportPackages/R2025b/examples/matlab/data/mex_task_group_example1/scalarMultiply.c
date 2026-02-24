// scalarMultiply.c
// Copyright 2024 The MathWorks, Inc.

#include "mex.h"
#include "shared.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    if (nrhs != 2) {
        mexErrMsgIdAndTxt("MATLAB:scalarMultiply:nrhs", "Two input arguments required.");
    }

    // Check that both inputs are scalar doubles
    if (!mxIsDouble(prhs[0]) || !mxIsScalar(prhs[0])) {
        mexErrMsgIdAndTxt("MATLAB:scalarMultiply:notScalar", "First input argument must be a scalar double.");
    }
    if (!mxIsDouble(prhs[1]) || !mxIsScalar(prhs[0])) {
        mexErrMsgIdAndTxt("MATLAB:scalarMultiply:notScalar", "Second input argument must be a scalar double.");
    }
 
    // Get the value of the inputs
    double a = mxGetScalar(prhs[0]);
    double b = mxGetScalar(prhs[1]);
 
    // Call the multiply function
    double result = multiply(a, b);
 
    // Set the output pointer to the output matrix
    plhs[0] = mxCreateDoubleScalar(result);
}