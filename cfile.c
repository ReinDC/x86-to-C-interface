#include <stdio.h>
#include <stdlib.h>

// Declare the assembly function (pls see asmfile.asm for the function)
void imgCvtGrayIntToDouble(size_t rows, size_t cols, unsigned char *input, double *output);

int main() {
    size_t rows, cols;

    // Prompt the user for the dimensions of the grayscale image
    printf("Enter the number of rows: ");
    scanf("%zu", &rows);

    printf("Enter the number of columns: ");
    scanf("%zu", &cols);

    // Allocate memory for input and output arrays
    size_t total_pixels = rows * cols;
    unsigned char *input = (unsigned char *)malloc(total_pixels * sizeof(unsigned char));
    double *output = (double *)malloc(total_pixels * sizeof(double));

    if (!input || !output) {
        printf("Memory allocation failed.\n");
        return 1;
    }

    // Read the grayscale pixel values
    printf("Enter the grayscale pixel values (0-255):\n");
    size_t i; // Declare loop variable outside the loop
    for (i = 0; i < total_pixels; i++) {
        int pixel;
        scanf("%d", &pixel); // Read as integer for input validation
        if (pixel < 0 || pixel > 255) {
            printf("Invalid pixel value. Please enter values between 0 and 255.\n"); //ensures data input is correct
            free(input);
            free(output);
            return 1;
        }
        input[i] = (unsigned char)pixel; // Store as unsigned char
    }

    // Call the assembly function 
    imgCvtGrayIntToDouble(rows, cols, input, output);

    // Print
    printf("Double Float pixel values:\n");
    for (i = 0; i < rows; i++) {
        size_t j; // Declare nested loop variable
        for (j = 0; j < cols; j++) {
            printf("%.2f ", output[i * cols + j]);
        }
        printf("\n");
    }

    // Free allocated memory
    free(input);
    free(output);

    return 0;
}