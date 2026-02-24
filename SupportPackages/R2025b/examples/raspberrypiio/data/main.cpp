//
// Prerelease License - for engineering feedback and testing purposes
// only. Not for sale.
//
// main.cpp
//
// Code generation for function 'main'
//

/*************************************************************************/
/* This automatically generated example C++ main file shows how to call  */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

// Include files
#include "main.h"
#include "raspi_fileRead_resnet.h"
#include "raspi_fileRead_resnet_initialize.h"
#include "raspi_fileRead_resnet_terminate.h"
#include "iostream"

// Function Declarations
static char argInit_char_T();

static int argInit_d50x1_char_T(char result_data[]);

// Function Definitions
static char argInit_char_T()
{
  return '?';
}

static int argInit_d50x1_char_T(char result_data[])
{
  int result_size;
  // Set the size of the array.
  // Change this size to the value that the application requires.
  result_size = 2;
  // Loop over the array to initialize each element.
  for (int idx0{0}; idx0 < 2; idx0++) {
    // Set the value of the array element.
    // Change this value to the value that the application requires.
    result_data[idx0] = argInit_char_T();
  }
  return result_size;
}

int main(int argc, char** argv)
{
    //Check number of input arguments
    if (argc!=2){
        std::cerr <<"Usage: " << argv[0] << "<image file name>";
        return -1;
    }
  // Initialize the application.
  // You do not need to do this more than one time.
  raspi_fileRead_resnet_initialize();
  // Invoke the entry-point functions.
  // You can call entry-point functions multiple times.
  main_raspi_fileRead_resnet(argv[1]);
  // Terminate the application.
  // You do not need to do this more than one time.
  raspi_fileRead_resnet_terminate();
  return 0;
}

void main_raspi_fileRead_resnet(const char* fileName)
{
  int fileName_size;
  char fileName_data[50];
  // Initialize function 'raspi_fileRead_resnet' input arguments.
  // Initialize function input argument 'fileName'.
  //fileName_size = argInit_d50x1_char_T(fileName_data);
  sprintf(fileName_data,"%s",fileName);
  fileName_size = strlen(fileName);
  // Call the entry-point 'raspi_fileRead_resnet'.
  raspi_fileRead_resnet(fileName_data, &fileName_size);
}

// End of code generation (main.cpp)
