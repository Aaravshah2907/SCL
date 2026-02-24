// scalarSquare.c
// Copyright 2024 The MathWorks, Inc.

#include "mex.h"
#include "shared.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    if (nrhs != 1) {
        mexErrMsgIdAndTxt("MATLAB:scalarSquare:nrhs", "One input argument required.");
    }
 
    // Check that the input is a scalar double
    if (!mxIsDouble(prhs[0]) || !mxIsScalar(prhs[0])) {
        mexErrMsgIdAndTxt("MATLAB:scalarSquare:notScalar", "Input argument must be a scalar double.");
    }
 
    // Get the value of the input
    double a = mxGetScalar(prhs[0]);
 
    // Call the multiply function to square the number
    double result = multiply(a, a);
 
    // Set the output pointer to the output matrix
    plhs[0] = mxCreateDoubleScalar(result);
}